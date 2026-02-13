### Insurance System Database DDL

#### Overview (Ver 2.0)

#### This document contains the DDL_SQL scripts for the Insurance System database.
#### PK, AK, UK, FK applied. 
#### Index applied for the policy issuing
1. select policy_no from T4_policy after premium calculation.
2. Policy_no indexed T4_Policy, T1_Applicant, T3_Premium_Calc, T2_Underwriting.
3. Indexes used for policy retrieval logic: (Policy batch and contract lookup process).

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
   Insurance System DB DDL
   Core Structure:
   Customer → Applicant → Policy
   ========================================================= */

/* =========================================================
   0. Customer
   - Master record for person/entity
   ========================================================= */
CREATE TABLE T0_Customer (
  Customer_ID    BIGINT       NOT NULL,
  Full_Name      VARCHAR(100) NOT NULL,
  DOB            DATE         NULL,
  Gender_Code    CHAR(2)      NULL,
  Phone_No       VARCHAR(30)  NULL,
  Email          VARCHAR(120) NULL,
  Proceed_Date   DATETIME     NOT NULL,
  Reserved       VARCHAR(100) NULL,

  CONSTRAINT PK_T0_Customer
    PRIMARY KEY (Customer_ID)
);

/* =========================================================
   1. Applicant
   - Application unit
   - A customer may submit multiple applications
   ========================================================= */
CREATE TABLE T1_Applicant (
  Applicant_ID         BIGINT        NOT NULL,
  Customer_ID          BIGINT        NOT NULL,
  Applied_Product_Code CHAR(2)       NOT NULL,
  Coverage_Code        CHAR(2)       NULL,

  Address_Line1        VARCHAR(120)  NOT NULL,
  Address_Line2        VARCHAR(120)  NULL,
  City                 VARCHAR(60)   NOT NULL,
  State_Code           CHAR(2)       NOT NULL,
  Zip_Code             VARCHAR(10)   NOT NULL,

  Occupation_Code      CHAR(2)       NOT NULL,
  Proceed_Date         DATETIME      NOT NULL,
  Reserved             VARCHAR(100)  NULL,

  CONSTRAINT PK_T1_Applicant
    PRIMARY KEY (Applicant_ID),

  CONSTRAINT FK_T1_Applicant_Customer
    FOREIGN KEY (Customer_ID)
    REFERENCES T0_Customer (Customer_ID)
);

/* =========================================================
   2. Underwriting
   - Underwriting history per application
   ========================================================= */
CREATE TABLE T2_Underwriting (
  UW_Case_No                 VARCHAR(30) NOT NULL,
  Applicant_ID               BIGINT      NOT NULL,
  Underwriting_Decision_Code CHAR(2)     NOT NULL,
  Risk_Class_Code            CHAR(2)     NULL,
  Inspector_ID               VARCHAR(20) NULL,
  Proceed_Date               DATETIME    NOT NULL,
  Reserved                   VARCHAR(100) NULL,

  CONSTRAINT PK_T2_Underwriting
    PRIMARY KEY (UW_Case_No),

  CONSTRAINT FK_T2_UW_Applicant
    FOREIGN KEY (Applicant_ID)
    REFERENCES T1_Applicant (Applicant_ID)
);

/* =========================================================
   3. Premium Calculation
   - Premium calculation history per application
   ========================================================= */
CREATE TABLE T3_Premium_Calc (
  Premium_Calc_ID BIGINT        NOT NULL,
  Applicant_ID    BIGINT        NOT NULL,
  Net_Premium     DECIMAL(18,2) NOT NULL,
  Loading_Factor  DECIMAL(8,4)  NOT NULL,
  Calc_Date       DATE          NOT NULL,
  Proceed_Date    DATETIME      NOT NULL,
  Reserved        VARCHAR(100)  NULL,

  CONSTRAINT PK_T3_Premium_Calc
    PRIMARY KEY (Premium_Calc_ID),

  CONSTRAINT FK_T3_Premium_Applicant
    FOREIGN KEY (Applicant_ID)
    REFERENCES T1_Applicant (Applicant_ID),

  CONSTRAINT UK_T3_Premium_AppDate
    UNIQUE (Applicant_ID, Calc_Date)
);

/* =========================================================
   4. Policy
   - Contract table
   - One customer can hold multiple policies
   - One application results in one policy
   ========================================================= */
CREATE TABLE T4_Policy (
  Policy_No           VARCHAR(30) NOT NULL,
  Customer_ID         BIGINT      NOT NULL,
  Applicant_ID        BIGINT      NOT NULL,
  Issue_Date          DATE        NOT NULL,
  Coverage_Code       CHAR(2)     NULL,
  Policy_Status_Code  CHAR(2)     NOT NULL,
  Policy_Document_ID  VARCHAR(50) NOT NULL,
  Proceed_Date        DATETIME    NOT NULL,
  Reserved            VARCHAR(100) NULL,

  CONSTRAINT PK_T4_Policy
    PRIMARY KEY (Policy_No),

  CONSTRAINT UK_T4_Policy_Document
    UNIQUE (Policy_Document_ID),

  CONSTRAINT UK_T4_Policy_Applicant
    UNIQUE (Applicant_ID),

  CONSTRAINT FK_T4_Policy_Customer
    FOREIGN KEY (Customer_ID)
    REFERENCES T0_Customer (Customer_ID),

  CONSTRAINT FK_T4_Policy_Applicant
    FOREIGN KEY (Applicant_ID)
    REFERENCES T1_Applicant (Applicant_ID)
);

/* =========================================================
   5. Reject
   - Rejected applications
   ========================================================= */
CREATE TABLE T5_Reject (
  Reject_ID                BIGINT      NOT NULL,
  Applicant_ID             BIGINT      NOT NULL,
  Underwriting_Result_Code CHAR(2)     NOT NULL,
  Reject_Reason_Code       CHAR(2)     NOT NULL,
  Notice_Date              DATE        NULL,
  Notice_Template_Code     CHAR(2)     NULL,
  Language_Code            CHAR(2)     NULL,
  Proceed_Date             DATETIME    NOT NULL,
  Reserved                 VARCHAR(100) NULL,

  CONSTRAINT PK_T5_Reject
    PRIMARY KEY (Reject_ID),

  CONSTRAINT FK_T5_Reject_Applicant
    FOREIGN KEY (Applicant_ID)
    REFERENCES T1_Applicant (Applicant_ID)
);

/* =========================================================
   Indexes used for policy retrieval logic
   (Policy batch and contract lookup process)
   ========================================================= */
CREATE INDEX IX_T1_Applicant_Customer ON T1_Applicant (Customer_ID);
CREATE INDEX IX_T4_Policy_Customer    ON T4_Policy (Customer_ID);
CREATE INDEX IX_T4_Policy_Applicant   ON T4_Policy (Applicant_ID);
CREATE INDEX IX_T3_Premium_Applicant  ON T3_Premium_Calc (Applicant_ID);
CREATE INDEX IX_T2_UW_Applicant       ON T2_Underwriting (Applicant_ID);
CREATE INDEX IX_T5_Reject_Applicant   ON T5_Reject (Applicant_ID);


```
