```sql
/* ============================================================
   DDL_SQL.md (v6) - Insurance Core System
   Target: MySQL 8.x / MariaDB 10.x (InnoDB)
   Notes:
   - Proceed_Date: System Timestamp (DEFAULT CURRENT_TIMESTAMP)
   - AK: implemented as UNIQUE
   - Reserved: VARCHAR(100) (Alphanumeric only - app validation)
   ============================================================ */

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `8_Insurance_Policy`;
DROP TABLE IF EXISTS `7_Premium_Information`;
DROP TABLE IF EXISTS `6_Customer_Information`;
DROP TABLE IF EXISTS `5_Underwriting_Information`;
DROP TABLE IF EXISTS `4_Customer`;
DROP TABLE IF EXISTS `3_Reject_Customer_Information`;
DROP TABLE IF EXISTS `2_Reject_Customer`;
DROP TABLE IF EXISTS `1_Applicant_Information`;

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- 1_Applicant_Information
-- ============================================================
CREATE TABLE `1_Applicant_Information` (
  `Applicant_ID`         BIGINT       NOT NULL,
  `Name`                 VARCHAR(100) NOT NULL,
  `DOB`                  DATE         NOT NULL,
  `Gender_Code`          CHAR(2)      NOT NULL,
  `Address_Line1`        VARCHAR(120) NOT NULL,
  `Address_Line2`        VARCHAR(120) NULL,
  `City`                 VARCHAR(60)  NOT NULL,
  `State_Code`           CHAR(2)      NOT NULL,
  `Zip_Code`             VARCHAR(10)  NOT NULL,
  `Phone_No`             VARCHAR(30)  NULL,
  `Email`                VARCHAR(120) NULL,
  `Occupation_Code`      CHAR(2)      NOT NULL,
  `Applied_Product_Code` CHAR(2)      NOT NULL,
  `Coverage_Code`        CHAR(2)      NULL,
  `Proceed_Date`         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Reserved`             VARCHAR(100) NULL,
  CONSTRAINT `PK_Applicant` PRIMARY KEY (`Applicant_ID`)
) ENGINE=InnoDB;

-- ============================================================
-- 2_Reject_Customer
-- ============================================================
CREATE TABLE `2_Reject_Customer` (
  `Reject_ID`                BIGINT      NOT NULL,
  `Applicant_ID`             BIGINT      NOT NULL,
  `Underwriting_Result_Code` CHAR(2)     NOT NULL,
  `Reject_Reason_Code`       CHAR(2)     NOT NULL,
  `Proceed_Date`             DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Reserved`                 VARCHAR(100) NULL,

  CONSTRAINT `PK_Reject_Customer` PRIMARY KEY (`Reject_ID`),
  CONSTRAINT `FK_Reject_to_Applicant`
    FOREIGN KEY (`Applicant_ID`)
    REFERENCES `1_Applicant_Information` (`Applicant_ID`)
) ENGINE=InnoDB;

CREATE INDEX `IX_Reject_Applicant_ID`
  ON `2_Reject_Customer` (`Applicant_ID`);

-- ============================================================
-- 3_Reject_Customer_Information
-- ============================================================
CREATE TABLE `3_Reject_Customer_Information` (
  `Reject_ID`            BIGINT       NOT NULL,
  `Full_Name`            VARCHAR(100) NOT NULL,
  `Reject_Reason_Code`   CHAR(2)      NOT NULL,
  `Notice_Date`          DATE         NOT NULL,
  `Notice_Template_Code` CHAR(2)      NULL,
  `Language_Code`        CHAR(2)      NULL,
  `Proceed_Date`         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Reserved`             VARCHAR(100) NULL,

  CONSTRAINT `PK_Reject_Customer_Info` PRIMARY KEY (`Reject_ID`),
  CONSTRAINT `FK_RejectInfo_to_RejectCustomer`
    FOREIGN KEY (`Reject_ID`)
    REFERENCES `2_Reject_Customer` (`Reject_ID`)
) ENGINE=InnoDB;

-- ============================================================
-- 4_Customer
-- ============================================================
CREATE TABLE `4_Customer` (
  `Customer_ID`          BIGINT        NOT NULL,
  `Applicant_ID`         BIGINT        NOT NULL,
  `Policy_No`            VARCHAR(30)   NOT NULL,
  `Current_Status_Code`  CHAR(2)       NOT NULL,
  `Premium_Amount`       DECIMAL(18,2) NOT NULL,
  `Proceed_Date`         DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Reserved`             VARCHAR(100)  NULL,

  CONSTRAINT `PK_Customer` PRIMARY KEY (`Customer_ID`),
  CONSTRAINT `UQ_Customer_Policy_No` UNIQUE (`Policy_No`),
  CONSTRAINT `FK_Customer_to_Applicant`
    FOREIGN KEY (`Applicant_ID`)
    REFERENCES `1_Applicant_Information` (`Applicant_ID`)
) ENGINE=InnoDB;

CREATE INDEX `IX_Customer_Applicant_ID`
  ON `4_Customer` (`Applicant_ID`);

-- ============================================================
-- 5_Underwriting_Information
-- ============================================================
CREATE TABLE `5_Underwriting_Information` (
  `UW_Case_No`                 VARCHAR(30)  NOT NULL,
  `Applicant_ID`               BIGINT       NOT NULL,
  `Underwriting_Decision_Code` CHAR(2)      NOT NULL,
  `Risk_Class_Code`            CHAR(2)      NULL,
  `Inspector_ID`               VARCHAR(20)  NULL,
  `Proceed_Date`               DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Reserved`                   VARCHAR(100) NULL,

  CONSTRAINT `PK_UW` PRIMARY KEY (`UW_Case_No`),
  CONSTRAINT `FK_UW_to_Applicant`
    FOREIGN KEY (`Applicant_ID`)
    REFERENCES `1_Applicant_Information` (`Applicant_ID`)
) ENGINE=InnoDB;

CREATE INDEX `IX_UW_Applicant_ID`
  ON `5_Underwriting_Information` (`Applicant_ID`);

-- ============================================================
-- 6_Customer_Information
-- ============================================================
CREATE TABLE `6_Customer_Information` (
  `Customer_ID`          BIGINT       NOT NULL,
  `Applied_Product_Code` CHAR(2)      NOT NULL,
  `Policy_Status_Code`   CHAR(2)      NOT NULL,
  `Proceed_Date`         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Reserved`             VARCHAR(100) NULL,

  CONSTRAINT `PK_Customer_Information` PRIMARY KEY (`Customer_ID`),
  CONSTRAINT `FK_CustomerInfo_to_Customer`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `4_Customer` (`Customer_ID`)
) ENGINE=InnoDB;

-- ============================================================
-- 7_Premium_Information
-- ============================================================
CREATE TABLE `7_Premium_Information` (
  `Premium_Calc_ID` BIGINT        NOT NULL,
  `Applicant_ID`    BIGINT        NOT NULL,
  `Net_Premium`     DECIMAL(18,2) NOT NULL,
  `Loading_Factor`  DECIMAL(8,4)  NOT NULL,
  `Calc_Date`       DATE          NOT NULL,
  `Proceed_Date`    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Reserved`        VARCHAR(100)  NULL,

  CONSTRAINT `PK_Premium` PRIMARY KEY (`Premium_Calc_ID`),
  CONSTRAINT `FK_Premium_to_Applicant`
    FOREIGN KEY (`Applicant_ID`)
    REFERENCES `1_Applicant_Information` (`Applicant_ID`)
) ENGINE=InnoDB;

CREATE INDEX `IX_Premium_Applicant_ID`
  ON `7_Premium_Information` (`Applicant_ID`);

-- ============================================================
-- 8_Insurance_Policy
--   PK: (Policy_No, Policy_Version_No)
--   FK: Policy_No -> 4_Customer(Policy_No)
--   Rule: If Change_Type_Code='OT' then Change_Reason_Code & Change_Memo required
-- ============================================================
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

  CONSTRAINT `FK_Policy_to_Customer_PolicyNo`
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
```

CREATE INDEX `IX_Policy_Effective_Date`
  ON `8_Insurance_Policy` (`Effective_Date`);
