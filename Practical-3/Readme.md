# Practical 3: Hospital Management System

## Objective

Implement a normalized schema for a hospital management system including patients, doctors, appointments, prescriptions, and billing. The schema follows strict naming conventions and indexing.

## Tools / Software Required

- MySQL Workbench / MySQL Server  
- VS Code or PyCharm  
- dbdiagram.io  

## Theory / Background

Hospital data management requires accurate record-keeping with relational integrity.  

- **1NF** ensures atomic data  
- **2NF** avoids partial dependencies  
- **3NF** removes transitive dependencies  

Tables include Patients, Doctors, Appointments, Prescriptions, and Bills. Indexes improve search efficiency, and naming conventions (e.g., `tbl_` prefix) maintain clarity.

## Procedure

- Identify key entities and their attributes  

- Establish relationships:  
  - Patients ↔ Appointments ↔ Doctors  
  - Appointments ↔ Prescriptions ↔ Bills  

- Apply normalization up to 3NF  

- Define indexes on frequently searched columns  

- Write SQL CREATE TABLE statements with proper naming conventions  

- Validate schema using sample data and queries  

## Result

The hospital database schema was successfully implemented, normalized, and tested. Relationships between patients, doctors, appointments, prescriptions, and bills were verified. Indexes improved query performance.

## Conclusion

This practical enhanced understanding of designing normalized schemas, enforcing relationships, and creating indexes in a healthcare context. Proper naming conventions and normalization principles were applied successfully.
