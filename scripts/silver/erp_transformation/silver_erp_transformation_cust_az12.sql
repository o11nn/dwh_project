INSERT into  silver.erp_cust_az12(
	cid,
	bdate,
	gen
)
SELECT 
	CASE
		WHEN cid LIKE 'NAS%'
		THEN substring(cid, 4, length(cid))
		ELSE cid
	END as cid,	
	case 
		WHEN bdate > current_date THEN NULL
		WHEN bdate < '1926-01-01' THEN null 
		else bdate
	end as bdate,
	case 
		WHEN UPPER(TRIM(gen)) IN ('F', UPPER('Female')) THEN 'Female'
		WHEN UPPER(TRIM(gen)) IN ('M', UPPER('Male')) THEN 'Male'
		else 'n/a'
	end as gen
from bronze.erp_cust_az12 eca



-- Check if the date out of range 
select 
bdate 
from bronze.erp_cust_az12 eca 
where bdate > current_date  or bdate < '1926-01-01'

-- Data standartization & Consistency
select distinct gen
from bronze.erp_cust_az12 eca 