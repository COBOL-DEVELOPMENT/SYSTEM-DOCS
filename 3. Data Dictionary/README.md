
# Data Design Principles

To ensure long-term maintainability and system robustness, the following architectural principles have been applied to the database design:

---

#### 1. Normalization & Code-Based Storage
* **Strategy:** We strictly store only Code values (e.g., Char 1) within transactional tables. 
* **Rationale:** Storing raw text descriptions leads to data redundancy and inconsistency. By decoupling data from its labels, we maintain a **Single Source of Truth**. 
* **Implementation:** All human-readable descriptions must be dynamically retrieved from the Code Book via JOIN or Lookup operations during data inquiry.

---

#### 2. Standardized Timeline Management (`Proceed_Date`)
* **Strategy:** Every Data Store and Data Flow utilizes a unified timestamp field: `Proceed_Date`.
* **Rationale:** In insurance systems, tracking the exact moment a status changes is critical for **Audit Trails** and legal compliance.
* **Implementation:** This field records the finalization of each specific process, ensuring consistent time-series analysis across the entire lifecycle.

---

#### 3. Future-Proofing via Reserved Fields
* **Strategy:** Every table is pre-allocated with three Reserved Fields (`Reserved_01` ~ `03`).
* **Rationale:** Database schema migrations and data conversions are costly and risky. Reserved fields allow for **"on-the-fly"** data expansion.
* **Specification:** Each field is defined as **100-byte Alpha-Numeric**, providing enough flexibility to handle new codes, flags, or identifiers without modifying the physical table structure.

#### 4. Key Design Decisions

- **Customer and Applicant are separated** to support multiple applications per customer.
- **Premium and Underwriting are application-based**, not policy-based.
- **Policy issuance is status-driven**, enabling controlled batch processing.
- **One application generates at most one policy**, enforced by a unique constraint on `Applicant_ID`.

---

#### 5. Policy Issuance Flow (Batch Logic)

1. Select policies where `Policy_Status_Code = 'RD'`
2. Load related Applicant, Premium, and Underwriting records
3. Generate policy document
4. Update policy status to `IS` (Issued)

---

#### 6. Index Strategy

Indexes are designed primarily to support:

- Status-based policy retrieval  
- Customer-level contract lookup  
- Applicant-level joins (Premium / Underwriting)  
- Batch issuance processing  

---

#### Author

Designed as part of Insurance Core System modeling practice.




