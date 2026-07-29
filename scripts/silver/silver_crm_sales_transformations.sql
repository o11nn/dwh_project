INSERT INTO silver.crm_sales_details (
	sls_order_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
)

select 
	sls_order_num,
	sls_prd_key,
	sls_cust_id,
CASE
	WHEN sls_order_dt = 0 or
	LENGTH(sls_order_dt::text) != 8 THEN NULL
	ELSE (sls_order_dt::VARCHAR)::date
	-- here we cast sls_order_dt initially to VARCHAR, then 
	-- to date, because we can't transform INT to DATE directly
END as sls_order_dt,
CASE
	WHEN sls_ship_dt = 0 or
	LENGTH(sls_ship_dt::text) != 8 THEN NULL
	ELSE (sls_ship_dt::VARCHAR)::date
END as sls_ship_dt,
CASE
	WHEN sls_due_dt = 0 or
	LENGTH(sls_due_dt::text) != 8 THEN NULL
	ELSE (sls_due_dt::VARCHAR)::date
END as sls_due_dt,
case 
	WHEN sls_sales IS NULL 
	OR sls_sales <= 0 
	OR sls_sales != sls_quantity * ABS(sls_price)
	THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
end as sls_sales,
	sls_quantity,
CASE 
	WHEN sls_price IS NULL OR sls_price <= 0
	THEN sls_sales / NULLIF(sls_quantity, 0)
	ELSE sls_price
END as sls_price
FROM bronze.crm_sales_details csd 



-- check for invalid date in sls_order_dt
select
NULLIF(sls_order_dt, 0) as sls_order_dt
FROM bronze.crm_sales_details csd 
WHERE 
	sls_order_dt <= 0 
	or LENGTH(sls_order_dt::text) != 8 
	OR sls_order_dt > 20500101
	OR sls_order_dt < 19000101

-- check for invalid date in sls_ship_dt
select
NULLIF(sls_ship_dt, 0) as sls_ship_dt
FROM bronze.crm_sales_details csd 
WHERE 
	sls_ship_dt <= 0 
	or LENGTH(sls_ship_dt::text) != 8
	OR sls_ship_dt > 20500101
	OR sls_ship_dt < 19000101
	
	
-- check for invalid date in sls_ship_dt
select
NULLIF(sls_due_dt, 0) as sls_due_dt
FROM bronze.crm_sales_details csd 
WHERE 
	sls_due_dt <= 0 
	or LENGTH(sls_due_dt::text) != 8
	OR sls_due_dt > 20500101
	OR sls_due_dt < 19000101

	
-- checking for INVALID order date
SELECT 
*
FROM bronze.crm_sales_details  
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_ship_dt

-- check data consistency: Between sales, quantity, and price
	
SELECT DISTINCT
sls_sales as old_sls_sales,
sls_quantity,
sls_price AS old_sls_price,
case 
	WHEN sls_sales IS NULL 
		OR sls_sales <= 0 
		OR sls_sales != sls_quantity * ABS(sls_price)
	THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
end as sls_sales,
CASE 
	WHEN sls_price IS NULL OR sls_price <= 0
	THEN sls_sales / NULLIF(sls_quantity, 0)
	ELSE sls_price
END as sls_price
FROM bronze.crm_sales_details csd 
WHERE sls_sales != sls_quantity * sls_price 
	OR sls_sales IS NULL 
	OR sls_quantity IS NULL 
	OR sls_price is NULL
	OR sls_sales <= 0
	OR sls_quantity <= 0 
	OR sls_price <= 0
ORDER BY 
	sls_sales,
	sls_quantity,
	sls_price	

