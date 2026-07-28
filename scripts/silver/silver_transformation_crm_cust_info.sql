-- In this script we implement data cleaning such as deduplication,
-- normalisation, handling NULL values, remove unnecessary spaces and gaps

INSERT INTO silver.crm_cust_info
(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_material_status,
	cst_gndr,
	cst_create_date,
	
)
SELECT 
cst_id,
cst_key,
TRIM(t.cst_firstname) as cst_firstname,
TRIM(t.cst_lastname) as cst_lastname,
CASE
	WHEN TRIM(UPPER(t.cst_material_status))='S' THEN 'Single'
	WHEN TRIM(UPPER(t.cst_material_status))='M' THEN 'Married'
	ELSE 'n/a'
END as cst_material_status,
CASE
	WHEN TRIM(UPPER(t.cst_gndr))='M' THEN 'Male'
	WHEN TRIM(UPPER(t.cst_gndr))='F' THEN 'Female'
	ELSE 'n/a'
END as cst_gndr,
t.cst_create_date 
FROM
(SELECT *,
ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
FROM bronze.crm_cust_info cci) t
WHERE flag_last = 1;