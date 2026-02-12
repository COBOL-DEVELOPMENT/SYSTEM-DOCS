### Insurance Core System
#### Ver 1.0 Table list

---

### 1. TB_APPLICANT_APPLICATION

| No | Column Name |
|----|------------|
| 1  | APPLICANT_ID |
| 2  | APPLICATION_NO |
| 3  | FULL_NAME |
| 4  | DOB |
| 5  | GENDER_CODE |
| 6  | ADDRESS |
| 7  | PHONE |
| 8  | EMAIL |
| 9  | OCCUPATION_CODE |
| 10 | APPLIED_PRODUCT |
| 11 | PLAN_CODE |
| 12 | CHANNEL_CODE |
| 13 | AGENT_ID |
| 14 | PROCEED_DATE |
| 15 | RESERVED_01 |
| 16 | RESERVED_02 |
| 17 | RESERVED_03 |
| 18 | CREATED_DATE |
| 19 | UPDATED_DATE |
| 20 | CREATED_BY |
| 21 | UPDATED_BY |

---

### 2. TB_REJECT_CUSTOMER

| No | Column Name |
|----|------------|
| 1  | REJECT_ID |
| 2  | APPLICANT_ID |
| 3  | REJECT_REASON_CODE |
| 4  | REJECT_DETAIL |
| 5  | REJECT_DATE |
| 6  | CREATED_DATE |
| 7  | UPDATED_DATE |

---

### 3. TB_REJECT_NOTICE

| No | Column Name |
|----|------------|
| 1  | NOTICE_ID |
| 2  | REJECT_ID |
| 3  | NOTICE_TYPE |
| 4  | SENT_DATE |
| 5  | DELIVERY_STATUS |
| 6  | CREATED_DATE |
| 7  | UPDATED_DATE |

---

### 4. TB_CUSTOMER_MASTER

| No | Column Name |
|----|------------|
| 1  | CUSTOMER_ID |
| 2  | FULL_NAME |
| 3  | DOB |
| 4  | GENDER_CODE |
| 5  | ADDRESS |
| 6  | PHONE |
| 7  | EMAIL |
| 8  | CUSTOMER_STATUS |
| 9  | CREATED_DATE |
| 10 | UPDATED_DATE |

---

### 5. TB_UW_CASE

| No | Column Name |
|----|------------|
| 1  | UW_CASE_ID |
| 2  | APPLICANT_ID |
| 3  | UW_STATUS |
| 4  | UW_RESULT |
| 5  | RISK_GRADE |
| 6  | APPROVAL_DATE |
| 7  | CREATED_DATE |
| 8  | UPDATED_DATE |

---

### 6. TB_CUSTOMER_OP_SNAPSHOT

| No | Column Name |
|----|------------|
| 1  | SNAPSHOT_ID |
| 2  | CUSTOMER_ID |
| 3  | SNAPSHOT_DATE |
| 4  | STATUS |
| 5  | TOTAL_PREMIUM |
| 6  | TOTAL_POLICY_COUNT |
| 7  | CREATED_DATE |

---

### 7. TB_PREMIUM_CALC_RESULT

| No | Column Name |
|----|------------|
| 1  | CALC_ID |
| 2  | APPLICANT_ID |
| 3  | PRODUCT_CODE |
| 4  | BASE_PREMIUM |
| 5  | RIDER_PREMIUM |
| 6  | TOTAL_PREMIUM |
| 7  | CALC_DATE |
| 8  | CREATED_DATE |

---

### 8. TB_POLICY_ISSUE

| No | Column Name |
|----|------------|
| 1  | POLICY_ID |
| 2  | CUSTOMER_ID |
| 3  | PRODUCT_CODE |
| 4  | POLICY_NUMBER |
| 5  | ISSUE_DATE |
| 6  | EFFECTIVE_DATE |
| 7  | EXPIRY_DATE |
| 8  | POLICY_STATUS |
| 9  | CREATED_DATE |
| 10 | UPDATED_DATE |
