## Insurance Code Book

#### Overview

#### This document defines the standardized 2-Byte code system used in the Insurance Platform.
-   Code Size: `CHAR(2)` (2 Bytes Standard)
-   Active Flag: Y / N
-   Effective Date: 2026-01-01

#### Governance Rules
-  All codes must be 2 bytes.
-  Codes must be uppercase.
-  No duplicates within same Code_Type.
-  Deprecated codes must be marked Is_Active = 'N'.

------------------------------------------------------------------------

## Code Categories

#### GENDER

  Code   Description
  ------ -----------------
  M      Male
  F      Female
  U      Unknown / Other

#### LANGUAGE

  Code   Description
  ------ -------------
  EN     English
  KR     Korean
  ES     Spanish
  VI     Vietnamese

#### CHANNEL

  Code   Description
  ------ -------------
  WB     Web
  AG     Agent
  CC     Call Center
  BR     Branch
  PT     Partner

#### BILL_FREQ

  Code   Description
  ------ -------------
  M      Monthly
  Q      Quarterly
  S      Semi-Annual
  A      Annual

#### PAY_METHOD

  Code   Description
  ------ -------------------
  EF     Bank Transfer
  CD     Credit/Debit Card
  CK     Check
  CA     Cash
  BL     Bill/Invoice

#### UW_DECISION

  Code   Description
  ------ -------------
  AP     Approve
  RJ     Reject
  PP     Postpone
  RU     Rate Up
  EX     Exclusion

#### RISK_CLASS

  Code   Description
  ------ -------------
  P1     Preferred
  S1     Standard
  S2     Substandard
  HR     High Risk

------------------------------------------------------------------------




