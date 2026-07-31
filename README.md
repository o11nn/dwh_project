# SQL Data Warehouse from Scratch

This repository contains a small end‑to‑end SQL data warehouse and analytics project built from scratch on PostgreSQL, designed to demonstrate data modeling, ETL/ELT patterns, and query design using a layered architecture.[cite:2]  
The project is developed and tested using the DBeaver IDE, but any PostgreSQL‑compatible client can be used.

## Project Overview

The goal of this project is to showcase how to design and implement a simple data warehouse from raw operational data to analytics‑ready tables using only SQL.[cite:2]  
You can use it as a learning resource, interview portfolio project, or a starting point for your own data warehouse implementation.

## Tech Stack

- Database: PostgreSQL (SQL language)[cite:2]
- IDE / Client: DBeaver
- Version control: Git / GitHub

## Architecture

The warehouse follows a layered approach:

- Bronze layer: Raw/staging tables that mirror source systems and store ingested data with minimal transformation.[cite:6]  
- Silver layer: Cleaned and transformed tables aligned to CRM and ERP subject areas, suitable for analytics and reporting.[cite:7]

This structure makes it easy to reason about data quality, lineage, and the flow from operational sources to analytical models.

## Repository Structure

Top‑level layout:

- `README.md` – High‑level description of the project and usage instructions.[cite:3]
- `docs/` – Documentation and data catalog for the warehouse tables.[cite:4]
- `scripts/` – SQL scripts to create the database and populate each layer.[cite:5]
- `tests/` – Placeholder for tests and validation scripts.[cite:8]

Details:

### `docs/`

- `docs/data_catalog.md` – Data catalog describing the main tables and their roles in the warehouse.[cite:4]  
- `docs/placeholder` – Reserved for future documentation assets.[cite:4]

### `scripts/`

- `scripts/create_database.sql` – Script to create the core database and schema objects used in the project.[cite:5]

#### Bronze layer (`scripts/bronze`)

- `bronze_create_table_script.sql` – DDL script to create bronze (staging) tables that receive raw CRM/ERP data.[cite:6]  
- `bronze_insert_data.sql` – Sample INSERT statements to populate bronze tables with demo data.[cite:6]

#### Silver layer (`scripts/silver`)

- `silver_create_table_scrpt.sql` – DDL script to create silver layer tables used for reporting and analytics.[cite:7]  
- `scripts/silver/crm_transformation/` – Transformation scripts for CRM‑related entities (customers, interactions, etc.).[cite:7]  
- `scripts/silver/erp_transformation/` – Transformation scripts for ERP‑related entities (orders, invoices, etc.).[cite:7]

### `tests/`

- `tests/placeholder` – Placeholder file for future test queries, data quality checks, or validation routines.[cite:8]

## Getting Started

### Prerequisites

- PostgreSQL installed locally or available on a server.
- DBeaver installed and configured with a PostgreSQL connection.
- Git (optional but recommended) to clone the repository.

### Setup Steps (DBeaver)

1. **Clone the repository**

   ```bash
   git clone https://github.com/o11nn/dwh_project.git
   cd dwh_project
   ```

2. **Create the database and schemas**

   - Open DBeaver and connect to your PostgreSQL instance.
   - Open `scripts/create_database.sql` and execute it to create the database and required schemas.[cite:5]

3. **Create bronze tables and load data**

   - Open `scripts/bronze/bronze_create_table_script.sql` and execute it to create bronze layer tables.[cite:6]
   - Open `scripts/bronze/bronze_insert_data.sql` and execute it to insert sample data into the bronze tables.[cite:6]

4. **Create silver tables and run transformations**

   - Open `scripts/silver/silver_create_table_scrpt.sql` and execute it to create silver layer tables.[cite:7]
   - Run the transformation scripts under `scripts/silver/crm_transformation` and `scripts/silver/erp_transformation` in a logical order (e.g., dimension tables first, then fact‑like tables).[cite:7]

After these steps, you will have a working mini data warehouse ready for analytics queries.

## Usage

Once the warehouse is set up:

- Explore table definitions and relationships using DBeaver's database navigator.  
- Use the `docs/data_catalog.md` file as a reference for table semantics and column descriptions.[cite:4]
- Write analytical SQL queries directly against the silver layer to answer business questions, build reports, or practice interview‑style SQL exercises.

Typical use cases:

- Joining CRM and ERP tables to analyze customer behavior and revenue.
- Creating aggregate views (daily/weekly/monthly) based on silver tables.
- Practicing dimensional modeling and query optimization on PostgreSQL.

## Extending the Project

You can extend this project by:

- Adding new source systems and corresponding bronze tables.
- Designing additional silver‑layer tables (e.g., fact tables, slowly changing dimensions).
- Implementing data quality checks and tests under the `tests/` directory.[cite:8]
- Integrating scheduling/orchestration tools (e.g., cron, Airflow) to run the SQL scripts automatically.

## Contributing

Contributions, suggestions, and issue reports are welcome.  
Feel free to:

- Open issues describing bugs or improvement ideas.
- Submit pull requests with new transformations, documentation, or tests.

## License

This project is shared for learning and portfolio purposes.  
Add a specific license (e.g., MIT) here if you plan to reuse or distribute it more broadly.
