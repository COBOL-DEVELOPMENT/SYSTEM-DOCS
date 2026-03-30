# COBOL CICS Employee Management System

## Overview

This program is a CICS-based COBOL application designed to manage basic employee (insurance subscriber) information.
It supports full CRUD operations (Create, Read, Update, Delete) using BMS map screens.

---

The system uses:
* Uses CICS BMS MAPSET (`EMPSET`)
* Uses COMMAREA for data transfer
* Uses VSAM/DB2 backend for persistence

* **EMPMAP1**: Main CRUD screen
* **EMPMAP2**: Delete confirmation screen

---

## MAP Usage Summary

| Function | Code | Input Screen | Confirmation / Result |
| -------- | ---- | ------------ | --------------------- |
| Create   | A    | EMPMAP1      | EMPMAP1               |
| Read     | I    | EMPMAP1      | EMPMAP1               |
| Update   | U    | EMPMAP1      | EMPMAP1               |
| Delete   | D    | EMPMAP1      | EMPMAP2 → EMPMAP1     |

---

## Input Fields (Based on MAPSET)

### EMPMAP1 – Main Screen

| Field  | Description   | Length | Usage         |
| ------ | ------------- | -----: | ------------- |
| M1FUNC | Function code |      1 | A / I / U / D |
| M1EID  | Employee ID   |     10 | Key field     |
| M1FN   | First Name    |     50 | Input         |
| M1LN   | Last Name     |     50 | Input         |
| M1DP   | Department    |     50 | Input         |
| M1JT   | Job Title     |     50 | Input         |
| M1HD   | Hire Date     |     10 | YYYY-MM-DD    |
| M1SL   | Salary        |      9 | Numeric       |
| M1MSG  | Message       |     70 | Output        |

---

### EMPMAP2 – Delete Confirmation Screen

| Field | Description    | Length | Usage   |
| ----- | -------------- | -----: | ------- |
| M2EID | Employee ID    |     10 | Display |
| M2FN  | First Name     |     50 | Display |
| M2LN  | Last Name      |     50 | Display |
| M2DP  | Department     |     50 | Display |
| M2JT  | Job Title      |     50 | Display |
| M2HD  | Hire Date      |     10 | Display |
| M2SL  | Salary         |      9 | Display |
| M2CFM | Confirm Delete |      1 | Y / N   |
| M2MSG | Message        |     70 | Output  |

---

## CRUD Processing Flow

### 1. Create (A)

* Screen: **EMPMAP1**
* User inputs all fields
* System writes data to VSAM/DB
* Result message displayed on same screen

---

### 2. Read / Inquiry (I)

* Screen: **EMPMAP1**
* User enters Employee ID
* System retrieves record
* Data displayed on same screen

---

### 3. Update (U)

* Screen: **EMPMAP1**
* Step 1: Input ID → fetch existing data
* Step 2: Modify fields → submit
* System updates record
* Result displayed on same screen

---

### 4. Delete (D)

* Step 1: **EMPMAP1** – input ID
* Step 2: **EMPMAP2** – confirm deletion (Y/N)
* Step 3: Perform delete
* Step 4: Return to EMPMAP1 with result message

---

## Screen Design Concept

### EMPMAP1

* Main entry screen
* Handles:

  * Input
  * Display
  * Update
  * Messages

### EMPMAP2

* Used only for delete confirmation
* Prevents accidental deletion



