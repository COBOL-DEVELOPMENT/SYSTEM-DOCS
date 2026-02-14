### Code Book
-----------------------------------------------------------------------


This document defines the standardized 2-Byte code system used in the Insurance Platform.
-   Active Flag: Y / N
-   Effective Date: 2026-01-01
-----------------------------------------------------------------------
Governance Rules
-  All codes must be 2 bytes.
-  Codes must be uppercase.
-  No duplicates within same Code_Type.
-  Deprecated codes must be marked Is_Active = 'N'.

------------------------------------------------------------------------

## Table of contents
- [GENDER](#gender)
- [LANGUAGE](#language)
- [CHANNEL](#channel)
- [BILL_FREQ](#bill_freq)
- [PAY_METHOD](#pay_method)
- [UW_DECISION](#uw_decision)
- [UW_RESULT](#uw_result)
- [REJECT_REASON](#reject_reason)
- [POSTPONE_REASON](#postpone_reason)
- [EXCLUSION](#exclusion)
- [RISK_CLASS](#risk_class)
- [DELIVERY_CHANNEL](#delivery_channel)
- [SEND_STATUS](#send_status)
- [FAIL_REASON](#fail_reason)
- [DELIVERY_STATUS](#delivery_status)
- [DISCOUNT](#discount)
- [SURCHARGE](#surcharge)
- [PRODUCT](#product)
- [PLAN](#plan)
- [COVERAGE](#coverage)

---

## GENDER

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| M1 | Male | Y | 2026-01-01 |  |
| F1 | Female | Y | 2026-01-01 |  |
| U1 | Unknown / Other | Y | 2026-01-01 |  |

---

## LANGUAGE

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| EN | English | Y | 2026-01-01 |  |
| KR | Korean | Y | 2026-01-01 |  |
| ES | Spanish | Y | 2026-01-01 |  |
| VI | Vietnamese | Y | 2026-01-01 |  |

---

## CHANNEL

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| WB | Web | Y | 2026-01-01 |  |
| AG | Agent | Y | 2026-01-01 |  |
| CC | Call Center | Y | 2026-01-01 |  |
| BR | Branch | Y | 2026-01-01 |  |
| PT | Partner | Y | 2026-01-01 |  |

---

## BILL_FREQ

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| MO | Monthly | Y | 2026-01-01 |  |
| QT | Quarterly | Y | 2026-01-01 |  |
| SA | Semi-Annual | Y | 2026-01-01 |  |
| AN | Annual | Y | 2026-01-01 |  |

---

## PAY_METHOD

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| EF | Bank Transfer (EFT/ACH) | Y | 2026-01-01 |  |
| CD | Credit / Debit Card | Y | 2026-01-01 |  |
| CK | Check | Y | 2026-01-01 |  |
| CA | Cash | Y | 2026-01-01 |  |
| BI | Bill / Invoice | Y | 2026-01-01 |  |

---

## UW_DECISION

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| AP | Approve | Y | 2026-01-01 |  |
| RJ | Reject | Y | 2026-01-01 |  |
| PS | Postpone | Y | 2026-01-01 |  |
| RU | Rate Up | Y | 2026-01-01 |  |
| EX | Exclusion | Y | 2026-01-01 |  |

---

## UW_RESULT

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| RJ | Rejected | Y | 2026-01-01 |  |

---

## REJECT_REASON

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| MH | Medical History | Y | 2026-01-01 |  |
| HR | High Risk Occupation | Y | 2026-01-01 |  |
| FR | Fraud / Suspicion | Y | 2026-01-01 |  |
| FU | Financial Underwriting | Y | 2026-01-01 |  |
| ID | Incomplete Documents | Y | 2026-01-01 |  |
| EC | External Check Fail | Y | 2026-01-01 |  |

---

## POSTPONE_REASON

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| MR | Awaiting Medical Records | Y | 2026-01-01 |  |
| LB | Pending Lab / Test | Y | 2026-01-01 |  |
| AI | Need Additional Info | Y | 2026-01-01 |  |

---

## EXCLUSION

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| BS | Exclude Back / Spine | Y | 2026-01-01 |  |
| CD | Exclude Cardiac | Y | 2026-01-01 |  |
| CN | Exclude Cancer | Y | 2026-01-01 |  |

---

## RISK_CLASS

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| P1 | Preferred | Y | 2026-01-01 |  |
| ST | Standard | Y | 2026-01-01 |  |
| SB | Substandard | Y | 2026-01-01 |  |
| HR | High Risk | Y | 2026-01-01 |  |

---

## DELIVERY_CHANNEL

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| ML | Postal Mail | Y | 2026-01-01 |  |
| EM | Email | Y | 2026-01-01 |  |
| SM | SMS | Y | 2026-01-01 |  |
| PO | Customer Portal | Y | 2026-01-01 |  |

---

## SEND_STATUS

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| RD | Ready | Y | 2026-01-01 |  |
| ST | Sent | Y | 2026-01-01 |  |
| FL | Failed | Y | 2026-01-01 |  |

---

## FAIL_REASON

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| IA | Invalid Address | Y | 2026-01-01 |  |
| IE | Invalid Email | Y | 2026-01-01 |  |
| MR | Mail Returned | Y | 2026-01-01 |  |
| SE | SMTP Error | Y | 2026-01-01 |  |
| SG | SMS Gateway Error | Y | 2026-01-01 |  |

---

## DELIVERY_STATUS

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| RD | Ready | Y | 2026-01-01 |  |
| DL | Delivered | Y | 2026-01-01 |  |
| RT | Returned | Y | 2026-01-01 |  |
| FL | Failed | Y | 2026-01-01 |  |

---

## DISCOUNT

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| NS | Non-Smoker | Y | 2026-01-01 |  |
| MP | Multi-Policy | Y | 2026-01-01 |  |
| ED | EFT Discount | Y | 2026-01-01 |  |

---

## SURCHARGE

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| SM | Smoker | Y | 2026-01-01 |  |
| HB | High BMI | Y | 2026-01-01 |  |
| HO | Hazard Occupation | Y | 2026-01-01 |  |

---

## PRODUCT

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| TL | Term Life | Y | 2026-01-01 |  |
| WL | Whole Life | Y | 2026-01-01 |  |
| HM | Medical | Y | 2026-01-01 |  |

---

## PLAN

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| BS | Basic | Y | 2026-01-01 |  |
| ST | Standard | Y | 2026-01-01 |  |
| PR | Premium | Y | 2026-01-01 |  |

---

## COVERAGE

| Code | EN_Description | Is_Active | Proceed_Date | Remark |
| --- | --- | --- | --- | --- |
| MC | Main Coverage | Y | 2026-01-01 |  |
| AD | Accidental Death | Y | 2026-01-01 |  |
| CI | Critical Illness | Y | 2026-01-01 |  |
