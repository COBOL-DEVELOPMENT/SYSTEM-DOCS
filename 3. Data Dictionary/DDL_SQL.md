### Insurance System Database DDL

#### Overview (Ver 2.0)

#### This document contains the DDL_SQL scripts for the Insurance System database.
#### PK, AK, UK, FK applied. 
#### Index applied for the policy issuing
1. select policy_no from T4_policy after premium calculation.
2. Policy_no indexed T4_Policy, T1_Applicant, T3_Premium_Calc, T2_Underwriting.

#### SQL List
1. Applicant Information
2. Reject Customer DB
3. Reject Customer Information
4. Customer DB
5. Underwriting Information
6. Customer Information
7. Premium Information
8. Insurance Policy

```sql
/* =========================================================
   1. Applicant Information
   ========================================================= */
CREATE TABLE T1_Applicant_Information (
  Applicant_ID        BIGINT       NOT NULL,
  Name                VARCHAR(100) NOT NULL,
  DOB                 DATE         NOT NULL,
  Gender_Code         CHAR(2)      NOT NULL,
  Address_Line1       VARCHAR(120) NOT NULL,
  Address_Line2       VARCHAR(120) NULL,
  City                VARCHAR(60)  NOT NULL,
  State_Code          CHAR(2)      NOT NULL,
  Zip_Code            VARCHAR(10)  NOT NULL,
  Phone_No            VARCHAR(30)  NULL,
  Email               VARCHAR(120) NULL,
  Occupation_Code     CHAR(2)      NOT NULL,
  Applied_Product_Code CHAR(2)     NOT NULL,
  Coverage_Code       CHAR(2)      NULL,
  Proceed_Date        DATETIME     NOT NULL,
  Reserved            VARCHAR(100) NULL,

  CONSTRAINT PK_T1_Applicant_Information
    PRIMARY KEY (Applicant_ID)  
);

/* =========================================================
   2. Reject Customer DB
   ========================================================= */
CREATE TABLE T2_Reject_Customer_DB (
  Reject_ID                   BIGINT   NOT NULL,
  Applicant_ID                BIGINT   NOT NULL,
  Underwriting_Result_Code    CHAR(2)  NOT NULL,
  Reject_Reason_Code          CHAR(2)  NOT NULL,
  Proceed_Date                DATETIME NOT NULL,
  Reserved                    VARCHAR(100) NULL,

  CONSTRAINT PK_T2_Reject_Customer_DB
    PRIMARY KEY (Reject_ID),

  CONSTRAINT FK_T2_RejectDB_Applicant
    FOREIGN KEY (Applicant_ID)
    REFERENCES T1_Applicant_Information (Applicant_ID)
);

/* =========================================================
   3. Reject Customer Information
   ========================================================= */
CREATE TABLE T3_Reject_Customer_Information (
  Reject_ID              BIGINT       NOT NULL,
  Full_Name              VARCHAR(100) NOT NULL,
  Reject_Reason_Code     CHAR(2)      NOT NULL,
  Notice_Date            DATE         NOT NULL,
  Notice_Template_Code   CHAR(2)      NULL,
  Language_Code          CHAR(2)      NULL,
  Proceed_Date           DATETIME     NOT NULL,
  Reserved               VARCHAR(100) NULL,

  CONSTRAINT PK_T3_Reject_Customer_Information
    PRIMARY KEY (Reject_ID),

  CONSTRAINT FK_T3_RejectInfo_RejectDB
    FOREIGN KEY (Reject_ID)
    REFERENCES T2_Reject_Customer_DB (Reject_ID)
);

/* =========================================================
   4. Customer DB
   ========================================================= */
CREATE TABLE T4_Customer_DB (
  Customer_ID          BIGINT       NOT NULL,
  Applicant_ID         BIGINT       NOT NULL,
  Policy_No            VARCHAR(30)  NOT NULL,
  Current_Status_Code  CHAR(2)      NOT NULL,
  Premium_Amount       DECIMAL(18,2) NOT NULL,
  Proceed_Date         DATETIME     NOT NULL,
  Reserved             VARCHAR(100) NULL,

  CONSTRAINT PK_T4_Customer_DB
    PRIMARY KEY (Customer_ID),

  --- UK (natural key): Policy_No is typically unique in Customer DB.
  CONSTRAINT UK_T4_Customer_DB_Policy_No
    UNIQUE (Policy_No),

  -- (Optional) If enforcing 1:1 Applicant → Customer:
  -- CONSTRAINT UK_T4_Customer_DB_Applicant UNIQUE (Applicant_ID),

  CONSTRAINT FK_T4_CustomerDB_Applicant
    FOREIGN KEY (Applicant_ID)
    REFERENCES T1_Applicant_Information (Applicant_ID)
);

/* =========================================================
   5. Underwriting Information
   ========================================================= */
CREATE TABLE T5_Underwriting_Information (
  UW_Case_No                 VARCHAR(30) NOT NULL,
  Applicant_ID               BIGINT      NOT NULL,
  Underwriting_Decision_Code CHAR(2)     NOT NULL,
  Risk_Class_Code            CHAR(2)     NULL,
  Inspector_ID               VARCHAR(20) NULL,
  Proceed_Date               DATETIME    NOT NULL,
  Reserved                   VARCHAR(100) NULL,

  CONSTRAINT PK_T5_Underwriting_Information
    PRIMARY KEY (UW_Case_No),

  CONSTRAINT FK_T5_UWInfo_Applicant
    FOREIGN KEY (Applicant_ID)
    REFERENCES T1_Applicant_Information (Applicant_ID)

  -- (Optional) If only one UW case is allowed per Applicant:
  -- ,CONSTRAINT UK_T5_UWInfo_Applicant UNIQUE (Applicant_ID)
);

/* =========================================================
   6. Customer Information
   ========================================================= */
CREATE TABLE T6_Customer_Information (
  Customer_ID          BIGINT    NOT NULL,
  Applied_Product_Code CHAR(2)   NOT NULL,
  Policy_Status_Code   CHAR(2)   NOT NULL,
  Proceed_Date         DATETIME  NOT NULL,
  Reserved             VARCHAR(100) NULL,

  CONSTRAINT PK_T6_Customer_Information
    PRIMARY KEY (Customer_ID),

  CONSTRAINT FK_T6_CustInfo_CustomerDB
    FOREIGN KEY (Customer_ID)
    REFERENCES T4_Customer_DB (Customer_ID)
);

/* =========================================================
   7. Premium Information
   ========================================================= */
CREATE TABLE T7_Premium_Information (
  Premium_Calc_ID  BIGINT        NOT NULL,
  Applicant_ID     BIGINT        NOT NULL,
  Net_Premium      DECIMAL(18,2) NOT NULL,
  Loading_Factor   DECIMAL(8,4)  NOT NULL,
  Calc_Date        DATE          NOT NULL,
  Proceed_Date     DATETIME      NOT NULL,
  Reserved         VARCHAR(100)  NULL,

  CONSTRAINT PK_T7_Premium_Information
    PRIMARY KEY (Premium_Calc_ID),

  CONSTRAINT FK_T7_Premium_Applicant
    FOREIGN KEY (Applicant_ID)
    REFERENCES T1_Applicant_Information (Applicant_ID)

  -- (Optional) Prevent duplicates for the same Applicant and Calc_Date:
  -- ,CONSTRAINT UK_T7_Premium_AppDate UNIQUE (Applicant_ID, Calc_Date)
);

/* =========================================================
   8. Insurance Policy
   ========================================================= */
CREATE TABLE T8_Insurance_Policy (
  Policy_No           VARCHAR(30) NOT NULL,
  Issue_Date          DATE        NOT NULL,
  Coverage_Code       CHAR(2)     NULL,
  Policy_Document_ID  VARCHAR(50) NOT NULL,
  Proceed_Date        DATETIME    NOT NULL,
  Reserved            VARCHAR(100) NULL,

  CONSTRAINT PK_T8_Insurance_Policy
    PRIMARY KEY (Policy_No),

  -- If Policy_Document_ID must be unique per policy:
  CONSTRAINT UK_T8_Policy_Document_ID
    UNIQUE (Policy_Document_ID)
);

/* =========================================================
   FK: Customer DB -> Insurance Policy (Policy_No)
   (T8 생성 후 추가)
   ========================================================= */
ALTER TABLE T4_Customer_DB
  ADD CONSTRAINT FK_T4_CustomerDB_Policy
  FOREIGN KEY (Policy_No)
  REFERENCES T8_Insurance_Policy (Policy_No);

```
