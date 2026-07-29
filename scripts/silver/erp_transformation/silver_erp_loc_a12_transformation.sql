CREATE OR REPLACE PROCEDURE silver.erp_loc_a12_trnsf()
LANGUAGE plpgsql
AS $$

DECLARE 
	ts_start_time timestamp;
	ts_end_time timestamp;
BEGIN
	BEGIN
		TRUNCATE silver.erp_loc_a12;
		
		ts_start_time := clock_timestamp();
		RAISE NOTICE 'Start transforming and inserting data into silver.erp_loc_a12';
		
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
		from bronze.erp_loc_a12 ela;
		
		RAISE NOTICE 'Transforming and inserting silver.erp_loc_a12 is end';
		ts_end_time := clock_timestamp();
		RAISE NOTICE 'Duration time: duration=%', ts_end_time - ts_start_time;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE NOTICE 'crm_cust_info transformation failed: SQLSTATE=% SQLERRM=%', SQLSTATE, SQLERRM;
	END;
END;
$$;

call erp_loc_a12_trnsf()


-- Data normalization & Consistency
SELECT
	DISTINCT cntry
from bronze.erp_loc_a12 ela