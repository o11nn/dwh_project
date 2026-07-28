INSERT INTO silver.crm_prd_info(
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)
select 
	prd_id,
	REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') as cat_id,
	SUBSTRING(prd_key, 7, LENGTH(prd_key)) as prd_key,
	prd_nm,
	coalesce(prd_cost, 0) as prd_cost,
	case 
		WHEN UPPER(TRIM(prd_line))='M' THEN 'Mountain'
		WHEN UPPER(TRIM(prd_line))='R' THEN 'Road'
		WHEN UPPER(TRIM(prd_line))='S' THEN 'Other sales'
		WHEN UPPER(TRIM(prd_line))='T' THEN 'Touring'
		ELSE 'n/a'
	end as prd_line,
	prd_start_dt, 
	LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt) - 1 as prd_end_dt
from bronze.crm_prd_info

-- Check for duplicates in prd_id
SELECT 
	prd_id,
	COUNT(*)
FROM bronze.crm_prd_info cpi 
GROUP BY cpi.prd_id 
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Check fo NULLs or negative number
SELECT prd_cost
FROM bronze.crm_prd_info cpi 
WHERE prd_cost < 0 OR prd_cost is null

-- Data standartization
SELECT distinct(prd_line) as prd_line
from bronze.crm_prd_info cpi

-- Check for Invalid Dates
SELECT * 
FROM crm_prd_info cpi 
WHERE cpi.prd_end_dt  < cpi.prd_start_dt 

