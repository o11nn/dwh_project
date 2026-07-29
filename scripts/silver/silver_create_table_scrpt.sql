--create tables for CRM system
--create crm_cust_info table
DROP TABLE IF EXISTS silver.crm_cust_info;

create table silver.crm_cust_info (
	cst_id INT,
	cst_key VARCHAR(50),
	cst_firstname VARCHAR(50),
	cst_lastname VARCHAR(50),
	cst_material_status VARCHAR(50),
	cst_gndr VARCHAR(50),
	cst_create_date DATE,
	dwh_create_date TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP
);

--create crm_prd_info table
DROP TABLE IF EXISTS silver.crm_prd_info;

create table silver.crm_prd_info (
	prd_id INT,
	cat_id VARCHAR(50),
	prd_key VARCHAR(50),
	prd_nm VARCHAR(50),
	prd_cost INT,
	prd_line VARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE,
	dwh_create_date TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP
);

--create crm_sales_details
DROP TABLE IF EXISTS silver.crm_sales_details;

create table silver.crm_sales_details (
	sls_order_num VARCHAR(50),
	sls_prd_key VARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT,
	dwh_create_date TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP
);

--create table for ERP source system

--create table erp_cust_az12

DROP TABLE IF EXISTS silver.erp_cust_az12;

create table silver.erp_cust_az12 (
	cid VARCHAR(50),
	bdate DATE,
	gen VARCHAR(50),
	dwh_create_date TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP
);

--create table erp_loc_a12
DROP TABLE IF EXISTS silver.erp_loc_a12;

create table silver.erp_loc_a12 (
	cid VARCHAR(50),
	cntry VARCHAR(50),
	dwh_create_date TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP
);

--create table erp_px_cat_g1v2
DROP TABLE IF EXISTS silver.erp_px_cat_g1v2; 

create table silver.erp_px_cat_g1v2 (
	id VARCHAR(50),
	cat VARCHAR(50),
	subcat VARCHAR(50),
	maintenance VARCHAR(50),
	dwh_create_date TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP
);