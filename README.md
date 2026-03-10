# Hospital Financial and Clinical Data Analysis

## Project Overview
This project involves the creation and analysis of a hospital database designed to reflect the complete patient journey from clinical care and billing to insurance payments and accounts receivable adjustments. The system is built using a Star Schema architecture consisting of one central fact table and eight dimension tables.

## Objectives
The primary goals of this project are
 To design and implement a relational database structure for healthcare data.
 To manage data integrity through the use of Primary and Foreign Keys.
 To perform advanced data exploration and aggregation using SQL.
 To analyze financial workflows including gross charges, insurance claims, and payment adjustments.

## Project Structure

### Phase 1 Database Setup and Integration
 Database Creation Initialized the environment in SQL Server.
 Table Definition Defined schemas for the Fact Table and 8 Dimension Tables.
 Data Migration Imported raw data from Excel files and verified record counts.
 Integrity Constraints Applied Primary Keys to dimension tables and established Foreign Key relationships within the Fact Table.

### Phase 2 Data Exploration and Join Logic
Reconstructed the clinical and financial workflow by joining tables to associate
 Patient demographics and location.
 Physician specialties and associated charges.
 Diagnostic codes (ICD) and procedural codes (CPT).
 Transactional data including payments and adjustments.

### Phase 3 Business Logic and SQL Queries
The analysis focuses on answering nine specific business questions
1.  High-Value Charges Identifying records with a gross charge exceeding $100.
2.  Patient Volume Calculating the total count of unique patients.
3.  CPT Distribution Aggregating CPT codes by their respective groups.
4.  Medicare Analysis Identifying physicians who have submitted Medicare claims.
5.  Operational Volume Identifying CPT codes with high utilization (over 100 units).
6.  Revenue by Specialty Determining the highest-earning medical specialty and tracking its monthly payment trends.
7.  Diagnostic Correlation Analyzing CPT units assigned to specific diagnostic categories (e.g., codes starting with 'J').
8.  Demographic Reporting Segmenting the patient population into age brackets (18, 18-65, 65) with detailed contact information.
9.  Credentialing Adjustments Auditing financial write-offs caused by credentialing issues and identifying the affected clinics and physicians.

## Technical Stack
 Database Engine Microsoft SQL Server
 Language T-SQL (Common Table Expressions, Aggregations, Window Functions)
 Tools Excel, Git, GitHub

## Author
 Name Youssef
 GitHub [ussef37](httpsgithub.comussef37)