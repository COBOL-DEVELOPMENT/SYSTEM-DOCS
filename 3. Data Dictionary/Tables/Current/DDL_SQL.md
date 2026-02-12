### Insurance System Database DDL

#### Overview

#### This document contains the DDL_SQL scripts for the Insurance System database.
#### SQL List
1. Applicant Information
2. Reject Customer DB
3. Reject Customer Information
4. Customer DB
5. Underwriting Information
6. Customer Information
7. Premium Information
8. Insurance Policy


#### DDL 
```sql
-- ============================================
-- 1. Applicant Information
-- ============================================

CREATE TABLE 1_Applicant_Information (
  Applicant_ID BIGINT NOT NULL,
  Name VARCHAR(100) NOT NULL,
  DOB DATE NOT NULL,
  Gender_Code CHAR(2) NOT NULL,
  Address_Line1 VARCHAR(120) NOT NULL,
  Address_Line2 VARCHAR(120) NULL,
  City VARCHAR(60) NOT NULL,
  State_Code CHAR(2) NOT NULL,
  Zip_Code VARCHAR(10) NOT NULL,
  Phone_No VARCHAR(30) NULL,
  Email VARCHAR(120) NULL,
  Occupation_Code CHAR(2) NOT NULL,
  Applied_Product_Code CHAR(2) NOT NULL,
  Coverage_Code CHAR(2) NULL,
  Proceed_Date DATETIME NOT NULL,
  Reserved VARCHAR(100) NULL,
  CONSTRAINT PK_1_Applicant_Information PRIMARY KEY (Applicant_ID)
);

-- ============================================
-- 2. Reject Customer DB
-- ============================================

CREATE TABLE 2_Reject_Customer_DB (
  Reject_ID BIGINT NOT NULL,
  Applicant_ID BIGINT NOT NULL,
  Underwriting_Result_Code CHAR(2) NOT NULL,
  Reject_Reason_Code CHAR(2) NOT NULL,
  Proceed_Date DATETIME NOT NULL,
  Reserved VARCHAR(100) NULL,
  CONSTRAINT PK_2_Reject_Customer_DB PRIMARY KEY (Reject_ID)
);

-- ============================================
-- 3. Reject Customer Information
-- ============================================

CREATE TABLE 3_Reject_Customer_Information (
  Reject_ID BIGINT NOT NULL,
  Full_Name VARCHAR(100) NOT NULL,
  Reject_Reason_Code CHAR(2) NOT NULL,
  Notice_Date DATE NOT NULL,
  Notice_Template_Code CHAR(2) NULL,
  Language_Code CHAR(2) NULL,
  Proceed_Date DATETIME NOT NULL,
  Reserved VARCHAR(100) NULL,
  CONSTRAINT PK_3_Reject_Customer_Information PRIMARY KEY (Reject_ID)
);

-- ============================================
-- 4. Customer DB
-- ============================================

CREATE TABLE 4_Customer_DB (
  Customer_ID BIGINT NOT NULL,
  Applicant_ID BIGINT NOT NULL,
  Policy_No VARCHAR(30) NOT NULL,
  Current_Status_Code CHAR(2) NOT NULL,
  Premium_Amount DECIMAL(18,2) NOT NULL,
  Proceed_Date DATETIME NOT NULL,
  Reserved VARCHAR(100) NULL,
  CONSTRAINT PK_4_Customer_DB PRIMARY KEY (Customer_ID)
);

-- ============================================
-- 5. Underwriting Information
-- ============================================

CREATE TABLE 5_Underwriting_Information (
  UW_Case_No VARCHAR(30) NOT NULL,
  Applicant_ID BIGINT NOT NULL,
  Underwriting_Decision_Code CHAR(2) NOT NULL,
  Risk_Class_Code CHAR(2) NULL,
  Inspector_ID VARCHAR(20) NULL,
  Proceed_Date DATETIME NOT NULL,
  Reserved VARCHAR(100) NULL,
  CONSTRAINT PK_5_Underwriting_Information PRIMARY KEY (UW_Case_No)
);

-- ============================================
-- 6. Customer Information
-- ============================================

CREATE TABLE 6_Customer_Information (
  Customer_ID BIGINT NOT NULL,
  Applied_Product_Code CHAR(2) NOT NULL,
  Policy_Status_Code CHAR(2) NOT NULL,
  Proceed_Date DATETIME NOT NULL,
  Reserved VARCHAR(100) NULL,
  CONSTRAINT PK_6_Customer_Information PRIMARY KEY (Customer_ID)
);

-- ============================================
-- 7. Premium Information
-- ============================================

CREATE TABLE 7_Premium_Information (
  Premium_Calc_ID BIGINT NOT NULL,
  Applicant_ID BIGINT NOT NULL,
  Net_Premium DECIMAL(18,2) NOT NULL,
  Loading_Factor DECIMAL(8,4) NOT NULL,
  Calc_Date DATE NOT NULL,
  Proceed_Date DATETIME NOT NULL,
  Reserved VARCHAR(100) NULL,
  CONSTRAINT PK_7_Premium_Information PRIMARY KEY (Premium_Calc_ID)
);

-- ============================================
-- 8. Insurance Policy
-- ============================================

CREATE TABLE 8_Insurance_Policy (
  Policy_No VARCHAR(30) NOT NULL,
  Issue_Date DATE NOT NULL,
  Coverage_Code CHAR(2) NULL,
  Policy_Document_ID VARCHAR(50) NOT NULL,
  Proceed_Date DATETIME NOT NULL,
  Reserved VARCHAR(100) NULL,
  CONSTRAINT PK_8_Insurance_Policy PRIMARY KEY (Policy_No)
);
```
