CREATE OR REPLACE PROCEDURE silver.erp_cust_az12_trnsf()
LANGUAGE plpgsql
AS $$

DECLARE 
	ts_start_time timestamp;
	ts_end_time timestamp;
BEGIN
	BEGIN
		TRUNCATE silver.erp_cust_az12;
		
		ts_start_time := clock_timestamp();
		RAISE NOTICE 'Start transforming and inserting data into silver.erp_cust_az12';
		
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
		from bronze.erp_cust_az12 eca;
		
		RAISE NOTICE 'Transforming and inserting silver.erp_cust_az12 is end';
		ts_end_time := clock_timestamp();
		RAISE NOTICE 'Duration time: duration=%', ts_end_time - ts_start_time;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE NOTICE 'crm_cust_info transformation failed: SQLSTATE=% SQLERRM=%', SQLSTATE, SQLERRM;
	END;
END;
$$;

call erp_cust_az12_trnsf()

-- Check if the date out of range 
select 
bdate 
from bronze.erp_cust_az12 eca 
where bdate > current_date  or bdate < '1926-01-01'

-- Data standartization & Consistency
select distinct gen
from bronze.erp_cust_az12 eca 