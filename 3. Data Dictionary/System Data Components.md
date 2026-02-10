## **System Data Components**

This section outlines the primary data stores and information flows within the insurance management system.

---

#### **1. Applicant Information**
* **Type:** Data Flow
* **Description:** Contains comprehensive data submitted by the insurance applicant, including personal details, medical history, and selected coverage.
* **Key Fields:** Applicant_ID, Name, Address, Occupation_Code, Reserved_01~03.

---

#### **2. Reject Customer D/B**
* **Type:** Data Store (Repository)
* **Description:** A dedicated database storing records of applicants who were refused a policy after the underwriting process.
* **Key Fields:** Reject_ID, Applicant_ID, Underwriting_Result, Reject_Reason_Code.

---

#### **3. Reject Customer Information**
* **Type:** Data Flow
* **Description:** Specific data extracted for rejected applicants, used for generating refusal notices or managing compliance records.
* **Key Fields:** Reject_ID, Full_Name, Reject_Reason, Notice_Date.

---

#### **4. Customer D/B**
* **Type:** Data Store (Master Repository)
* **Description:** The master database containing all applicant records. Once an application is approved, it serves as the primary source for policyholder management.
* **Key Fields:** Customer_ID, Policy_No, Current_Status, Premium_Amount.

---

#### **5. Underwriting Information**
* **Type:** Data Flow
* **Description:** Data generated during the inspection phase. It captures the final decision and risk assessment made by the Underwriting department.
* **Key Fields:** UW_Case_No, Underwriting_Decision_Code, Inspector_ID, Proceed_Date.

---

#### **6. Customer Information**
* **Type:** Data Flow
* **Description:** A subset of the Customer D/B used specifically for operational processes, such as contract amendments or claim processing.
* **Key Fields:** Customer_ID, Applied_Product_Code, Policy_Status.

---

#### **7. Premium Information**
* **Type:** Data Flow
* **Description:** Output from the Actuarial department. It contains the calculated premium amounts based on the applicant's risk profile and product selection.
* **Key Fields:** Premium_Calc_ID, Net_Premium, Loading_Factor, Calc_Date.

---

#### **8. Insurance Policy**
* **Type:** Final Output (Post-Batch)
* **Description:** The formal contract document generated after the batch cycle. This information is delivered to the applicant to signify the commencement of coverage.
* **Key Fields:** Policy_No, Issue_Date, Coverage_Details, Policy_Document_ID.
