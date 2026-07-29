INSERT INTO silver.erp_loc_a12 (
	cid,
	cntry
)
select 
	REPLACE(cid, '-','') as cid, 
	-- Use replace, becuse we will JOIN thi table with crm_cust_info
	case 
		WHEN TRIM(cntry) ='DE' THEN 'Germany'
		WHEN TRIM(cntry)='US' THEN 'United States'
		WHEN TRIM(cntry)='USA' THEN 'United States'
		WHEN TRIM(cntry) = '' or cntry IS NULL THEN 'n/a'
		ELSE TRIM(cntry)
	end as cntry	
from bronze.erp_loc_a12 ela 


-- Data normalization & Consistency
SELECT
	DISTINCT cntry
from bronze.erp_loc_a12 ela 