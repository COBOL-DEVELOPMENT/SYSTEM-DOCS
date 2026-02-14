# Insurance System Database

## Overview

This project defines the core database structure for an Insurance System.

The design follows a standard insurance flow:

Customer → Applicant → Policy

- A customer may submit multiple applications.
- One application may result in one policy.
- Underwriting and premium calculation are handled at the application level.
- Policy issuance is controlled by status-based batch processing.

---

## ERD (Entity Relationship Diagram)

```mermaid
erDiagram
  T0_Customer {
    BIGINT   Customer_ID PK
    VARCHAR  Full_Name
    DATE     DOB
    CHAR(2)  Gender_Code
    VARCHAR  Phone_No
    VARCHAR  Email
    DATETIME Proceed_Date
  }

  T1_Applicant {
    BIGINT   Applicant_ID PK
    BIGINT   Customer_ID FK
    CHAR(2)  Application_Status_Code
    CHAR(2)  Applied_Product_Code
    CHAR(2)  Coverage_Code
    DATETIME Proceed_Date
  }

  T2_Underwriting {
    VARCHAR  UW_Case_No PK
    BIGINT   Applicant_ID FK
    CHAR(2)  Underwriting_Decision_Code
    CHAR(2)  Risk_Class_Code
    DATETIME Proceed_Date
  }

  T3_Premium_Calc {
    BIGINT   Premium_Calc_ID PK
    BIGINT   Applicant_ID FK
    DECIMAL  Net_Premium
    DATE     Calc_Date
  }

  T4_Policy {
    VARCHAR  Policy_No PK
    BIGINT   Customer_ID FK
    BIGINT   Applicant_ID FK
    CHAR(2)  Policy_Status_Code
    DATE     Issue_Date
    VARCHAR  Policy_Document_ID UK
  }

  T5_Reject {
    BIGINT   Reject_ID PK
    BIGINT   Applicant_ID FK
    CHAR(2)  Reject_Reason_Code
    DATE     Notice_Date
  }

  T0_Customer ||--o{ T1_Applicant : submits
  T0_Customer ||--o{ T4_Policy    : owns
  T1_Applicant ||--o{ T2_Underwriting : has
  T1_Applicant ||--o{ T3_Premium_Calc : has
  T1_Applicant ||--o{ T5_Reject       : may_have
  T1_Applicant ||--o| T4_Policy       : results_in
