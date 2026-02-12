<div style="font-size:8px;">
 
Insurance Core System
DB Components Data Dictionary 

---

Ver 6.0: version and policy change management
1. 8_insurance-Policy table 
   - Add policy version and previous version change reason code and change memo.
   - Add previous and current version number.
   - Add policy change code and reason

2. Code book 
   - Add policy change and reason code.
   
---   
 
> Key Legend: 🔑PK (Primary Key) / 🔗FK (Foreign Key)
---

 1_Applicant_Information

| Field Name | Description | Data Type | Length | Key | Remarks |
|------------|------------|-----------|--------|-----|---------|
| Applicant_ID | Unique applicant identifier | BIGINT | 19 | 🔑PK | NOT NULL |
| Name | Applicant full name | VARCHAR(100) | 100 |  | NOT NULL |
| DOB | Date of birth | DATE | - |  | NOT NULL |
| Gender_Code | Gender code | CHAR(2) | 2 |  | Refer to Code Book (GENDER) \| NOT NULL |
| Address_Line1 | Address line 1 | VARCHAR(120) | 120 |  | NOT NULL |
| Address_Line2 | Address line 2 | VARCHAR(120) | 120 |  |  |
| City | City | VARCHAR(60) | 60 |  | NOT NULL |
| State_Code | State code | CHAR(2) | 2 |  | NOT NULL |
| Zip_Code | Postal code | VARCHAR(10) | 10 |  | NOT NULL |
| Phone_No | Phone number | VARCHAR(30) | 30 |  |  |
| Email | Email address | VARCHAR(120) | 120 |  |  |
| Occupation_Code | Occupation code | CHAR(2) | 2 |  | Refer to Code Book (OCCUPATION) \| NOT NULL |
| Applied_Product_Code | Applied product code | CHAR(2) | 2 |  | Refer to Code Book (PRODUCT) \| NOT NULL |
| Coverage_Code | Coverage / main rider code | CHAR(2) | 2 |  | Refer to Code Book (COVERAGE) |
| Proceed_Date | Application finalization timestamp | DATETIME | - |  | System Timestamp \| NOT NULL |
| Reserved | Reserved (for future extension) | VARCHAR(100) | 100 |  | Alphanumeric only |

---

 2_Reject_Customer

| Field Name | Description | Data Type | Length | Key | Remarks |
|------------|------------|-----------|--------|-----|---------|
| Reject_ID | Unique reject record identifier | BIGINT | 19 | 🔑PK | NOT NULL |
| Applicant_ID | Unique applicant identifier | BIGINT | 19 | 🔗FK | Ref: 1_Applicant_Information(Applicant_ID) \| NOT NULL |
| Underwriting_Result_Code | Final underwriting result code | CHAR(2) | 2 |  | Refer to Code Book (UW_RESULT) \| NOT NULL |
| Reject_Reason_Code | Reject reason code | CHAR(2) | 2 |  | Refer to Code Book (REJECT_REASON) \| NOT NULL |
| Proceed_Date | Reject processing finalization timestamp | DATETIME | - |  | System Timestamp \| NOT NULL |
| Reserved | Reserved (for future extension) | VARCHAR(100) | 100 |  | Alphanumeric only |

---

 3_Reject_Customer_Information

| Field Name | Description | Data Type | Length | Key | Remarks |
|------------|------------|-----------|--------|-----|---------|
| Reject_ID | Unique reject record identifier | BIGINT | 19 | 🔑PK/🔗FK | Ref: 2_Reject_Customer_DB(Reject_ID) \| NOT NULL |
| Full_Name | Rejected customer name (snapshot) | VARCHAR(100) | 100 |  | NOT NULL |
| Reject_Reason_Code | Reject reason code (customer-facing display) | CHAR(2) | 2 |  | Refer to Code Book (REJECT_REASON) \| NOT NULL |
| Notice_Date | Notice reference date | DATE | - |  | NOT NULL |
| Notice_Template_Code | Notice template code | CHAR(2) | 2 |  | Refer to Code Book (NOTICE_TEMPLATE) |
| Language_Code | Language code | CHAR(2) | 2 |  | Refer to Code Book (LANGUAGE) |
| Proceed_Date | Notice information finalization timestamp | DATETIME | - |  | System Timestamp \| NOT NULL |
| Reserved | Reserved (for future extension) | VARCHAR(100) | 100 |  | Alphanumeric only |

---

 4_Customer

| Field Name | Description | Data Type | Length | Key | Remarks |
|------------|------------|-----------|--------|-----|---------|
| Customer_ID | Unique customer identifier | BIGINT | 19 | 🔑PK | NOT NULL |
| Applicant_ID | Original applicant identifier | BIGINT | 19 | 🔗FK | Ref: 1_Applicant_Information(Applicant_ID) \| NOT NULL |
| Policy_No | Policy number | VARCHAR(30) | 30 | AK | NOT NULL |
| Current_Status_Code | Current policy status code | CHAR(2) | 2 |  | Refer to Code Book (POLICY_STATUS) \| NOT NULL |
| Premium_Amount | Confirmed premium amount | DECIMAL(18,2) | 18,2 |  | NOT NULL |
| Proceed_Date | Customer conversion finalization timestamp | DATETIME | - |  | System Timestamp \| NOT NULL |
| Reserved | Reserved (for future extension) | VARCHAR(100) | 100 |  | Alphanumeric only |

---

 5_Underwriting_Information

| Field Name | Description | Data Type | Length | Key | Remarks |
|------------|------------|-----------|--------|-----|---------|
| UW_Case_No | Underwriting case number | VARCHAR(30) | 30 | 🔑PK | NOT NULL |
| Applicant_ID | Unique applicant identifier | BIGINT | 19 | 🔗FK | Ref: 1_Applicant_Information(Applicant_ID) \| NOT NULL |
| Underwriting_Decision_Code | Underwriting decision code | CHAR(2) | 2 |  | Refer to Code Book (UW_DECISION) \| NOT NULL |
| Risk_Class_Code | Risk classification code | CHAR(2) | 2 |  | Refer to Code Book (RISK_CLASS) |
| Inspector_ID | Inspector / investigator ID | VARCHAR(20) | 20 |  |  |
| Proceed_Date | Underwriting decision finalization timestamp | DATETIME | - |  | System Timestamp \| NOT NULL |
| Reserved | Reserved (for future extension) | VARCHAR(100) | 100 |  | Alphanumeric only |

---

6_Customer_Information

| Field Name | Description | Data Type | Length | Key | Remarks |
|------------|------------|-----------|--------|-----|---------|
| Customer_ID | Unique customer identifier | BIGINT | 19 | 🔑PK/🔗FK | Ref: 4_Customer_DB(Customer_ID) \| NOT NULL |
| Applied_Product_Code | Applied product code | CHAR(2) | 2 |  | Refer to Code Book (PRODUCT) \| NOT NULL |
| Policy_Status_Code | Policy status code | CHAR(2) | 2 |  | Refer to Code Book (POLICY_STATUS) \| NOT NULL |
| Proceed_Date | Operational information finalization timestamp | DATETIME | - |  | System Timestamp \| NOT NULL |
| Reserved | Reserved (for future extension) | VARCHAR(100) | 100 |  | Alphanumeric only |

---


 7_Premium_Information

| Field Name | Description | Data Type | Length | Key | Remarks |
|------------|------------|-----------|--------|-----|---------|
| Premium_Calc_ID | Premium calculation ID | BIGINT | 19 | 🔑PK | NOT NULL |
| Applicant_ID | Unique applicant identifier | BIGINT | 19 | 🔗FK | Ref: 1_Applicant_Information(Applicant_ID) \| NOT NULL |
| Net_Premium | Net premium amount | DECIMAL(18,2) | 18,2 |  | NOT NULL |
| Loading_Factor | Loading / discount factor | DECIMAL(8,4) | 8,4 |  | NOT NULL |
| Calc_Date | Calculation date | DATE | - |  | NOT NULL |
| Proceed_Date | Premium calculation finalization timestamp | DATETIME | - |  | System Timestamp \| NOT NULL |
| Reserved | Reserved (for future extension) | VARCHAR(100) | 100 |  | Alphanumeric only |

---

 8_Insurance_Policy

| Field Name          | Data Type       | Length | Key   | Remarks |
|--------------------|----------------|--------|-------|---------|
| Policy_No          | VARCHAR(30)    | 30     | PK/FK | Ref: 4_Customer_DB(Policy_No) \| NOT NULL |
| Policy_Version_No  | INT            | 10     | PK    | NOT NULL |
| Change_Type_Code   | CHAR(2)        | 2      |       | Refer to Code Book (POLICY_CHANGE_TYPE) \| NOT NULL \| Include 'OT' (Other) for manual entry |
| Change_Reason_Code | CHAR(2)        | 2      |       | Refer to Code Book (POLICY_CHANGE_REASON) \| Required when Change_Type_Code = 'OT' |
| Change_Memo        | VARCHAR(200)   | 200    |       | Required when Change_Type_Code = 'OT' |
| Prev_Version_No    | INT            | 10     |       |  |
| Issue_Date         | DATE           | -      |       | NOT NULL |
| Effective_Date     | DATE           | -      |       | NOT NULL |
| End_Date           | DATE           | -      |       |  |
| Coverage_Code      | CHAR(2)        | 2      |       | Refer to Code Book (COVERAGE) |
| Policy_Document_ID | VARCHAR(50)    | 50     |       | NOT NULL |
| Proceed_Date       | DATETIME       | -      |       | System Timestamp \| NOT NULL |
| Reserved           | VARCHAR(100)   | 100    |       | Alphanumeric only |

</div>

<div>
 /* ============================================================
   8_Insurance_Policy
   - PK: (Policy_No, Policy_Version_No)
   - FK: Policy_No -> 4_Customer(Policy_No)
   - Rule: If Change_Type_Code='OT' then Change_Reason_Code & Change_Memo required
   ============================================================ */

CREATE TABLE `8_Insurance_Policy` (
  `Policy_No`          VARCHAR(30)  NOT NULL,
  `Policy_Version_No`  INT          NOT NULL,
  `Change_Type_Code`   CHAR(2)      NOT NULL,
  `Change_Reason_Code` CHAR(2)      NULL,
  `Change_Memo`        VARCHAR(200) NULL,
  `Prev_Version_No`    INT          NULL,
  `Issue_Date`         DATE         NOT NULL,
  `Effective_Date`     DATE         NOT NULL,
  `End_Date`           DATE         NULL,
  `Coverage_Code`      CHAR(2)      NULL,
  `Policy_Document_ID` VARCHAR(50)  NOT NULL,
  `Proceed_Date`       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Reserved`           VARCHAR(100) NULL,

  CONSTRAINT `PK_Insurance_Policy`
    PRIMARY KEY (`Policy_No`, `Policy_Version_No`),

  CONSTRAINT `FK_Policy_To_Customer`
    FOREIGN KEY (`Policy_No`)
    REFERENCES `4_Customer` (`Policy_No`),

  CONSTRAINT `CK_Policy_OT_Required`
    CHECK (
      `Change_Type_Code` <> 'OT'
      OR (
        `Change_Reason_Code` IS NOT NULL
        AND `Change_Memo` IS NOT NULL
        AND CHAR_LENGTH(`Change_Memo`) > 0
      )
    )
) ENGINE=InnoDB;

</div>
