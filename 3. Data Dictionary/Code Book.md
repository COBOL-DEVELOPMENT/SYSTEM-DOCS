#### Code Mapping

| code_type | Original Code | New Code | is_active | proceed_date | Remark |
|------------|---------------|----------------|-----------|--------------|--------|
| GENDER | M | M1 | Y | 2026-01-01 | Male |
| GENDER | F | F1 | Y | 2026-01-01 | Female |
| GENDER | U | U1 | Y | 2026-01-01 | Unknown |
| LANGUAGE | EN | EN | Y | 2026-01-01 | English |
| LANGUAGE | KR | KR | Y | 2026-01-01 | Korean |
| LANGUAGE | ES | ES | Y | 2026-01-01 | Spanish |
| LANGUAGE | VI | VI | Y | 2026-01-01 | Vietnamese |
| CHANNEL | WEB | WB | Y | 2026-01-01 | Web |
| CHANNEL | AGENT | AG | Y | 2026-01-01 | Agent |
| CHANNEL | CALL | CL | Y | 2026-01-01 | Call Center |
| CHANNEL | BRANCH | BR | Y | 2026-01-01 | Branch |
| CHANNEL | PARTNER | PT | Y | 2026-01-01 | Partner |
| ETC | M | M2 | Y | 2026-01-01 | Duplicate M |
| ETC | Q | Q1 | Y | 2026-01-01 |  |
| ETC | S | S1 | Y | 2026-01-01 |  |
| ETC | A | A1 | Y | 2026-01-01 |  |
| PAYMENT | EFT | EF | Y | 2026-01-01 | Electronic Fund Transfer |
| PAYMENT | CARD | CD | Y | 2026-01-01 | Card Payment |
| PAYMENT | CHECK | CK | Y | 2026-01-01 | Check |
| PAYMENT | CASH | CS | Y | 2026-01-01 | Cash |
| PAYMENT | BILL | BL | Y | 2026-01-01 | Billing |
| STATUS | APPROVE | AP | Y | 2026-01-01 | Approved |
| STATUS | REJECT | RJ | Y | 2026-01-01 | Rejected |
| STATUS | POSTPONE | PP | Y | 2026-01-01 | Postponed |
| STATUS | RATEUP | RU | Y | 2026-01-01 | Rate Increase |
| STATUS | EXCLUDE | EX | Y | 2026-01-01 | Excluded |
| POLICY_CHANAGE | NEW | NW | Y | 2026-01-01 | Excluded |
| POLICY_CHANAGE |Endorsement| EN   | Y | 2026-01-01 | Excluded |
| POLICY_CHANAGE |Cancel| CN   | Y | 2026-01-01 | Excluded |
| POLICY_CHANAGE |Reinstate| RS  | Y | 2026-01-01 | Excluded |
| POLICY_CHANAGE |Other| OT   | Y | 2026-01-01 | Excluded |  | Manual entry allowed; specify details in Change_Memo |
| POLICY_CHANAGE_REASON |Address| 01  | Y | 2026-01-01  | Address Change           |
| POLICY_CHANAGE_REASON |Beneficiary| 02  | Y | 2026-01-01  | Beneficiary Change       |
| POLICY_CHANAGE_REASON |Coverage| 03  | Y | 2026-01-01  | Coverage Change          |
| POLICY_CHANAGE_REASON |Health| 04  | Y | 2026-01-01  | Health Info Update       |
| POLICY_CHANAGE_REASON |Payment| 05  | Y | 2026-01-01  | Payment Method Change    |
| POLICY_CHANAGE_REASON |Billing| 06  | Y | 2026-01-01  | Billing Frequency Change   |
| POLICY_CHANAGE_REASON |Other| OT   | Y | 2026-01-01 | Other                  | Use Change_Memo for details |

```sql
CREATE TABLE code_mapping (
    id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code_type     VARCHAR(30) NOT NULL,   -- 예: GENDER, LANGUAGE, CHANNEL, PAYMENT, STATUS
    original_code VARCHAR(30) NOT NULL,
    new_code      CHAR(2)     NOT NULL,
    is_active     CHAR(1)     NOT NULL DEFAULT 'Y',
    proceed_date  DATE        NOT NULL DEFAULT DATE '2026-01-01',
    remark        VARCHAR(200),

    -- 동일 유형(code_type) 내에서만 코드 중복 방지
    CONSTRAINT uq_code_mapping UNIQUE (code_type, original_code, proceed_date),

    -- 동일 유형 내 new_code 충돌 방지 (2자리 코드 보호)
    CONSTRAINT uq_code_mapping_newcode UNIQUE (code_type, new_code, proceed_date),

    CONSTRAINT ck_code_mapping_active CHECK (is_active IN ('Y','N'))
);
```
