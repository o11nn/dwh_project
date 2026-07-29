CREATE OR REPLACE PROCEDURE silver.erp_px_cat_g1v2_trnsf()
LANGUAGE plpgsql
AS $$

DECLARE 
	ts_start_time timestamp;
	ts_end_time timestamp;
BEGIN
	BEGIN
		TRUNCATE silver.erp_px_cat_g1v2;
		
		ts_start_time := clock_timestamp();
		RAISE NOTICE 'Start transforming and inserting data into silver.erp_px_cat_g1v2';

		INSERT INTO silver.erp_px_cat_g1v2 (
			id,
			cat,
			subcat,
			maintenance
		)
		
		select
			id,
			cat,
			subcat,
			maintenance
		from bronze.erp_px_cat_g1v2 epcgv;
		
		RAISE NOTICE 'Transforming and inserting silver.erp_px_cat_g1v2 is end';
		ts_end_time := clock_timestamp();
		RAISE NOTICE 'Duration time: duration=%', ts_end_time - ts_start_time;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE NOTICE 'crm_cust_info transformation failed: SQLSTATE=% SQLERRM=%', SQLSTATE, SQLERRM;
	END;
END;
$$;


call erp_px_cat_g1v2_trnsf()
		
-- Check for unwanted spaces
select
*
from bronze.erp_px_cat_g1v2 epcgv 
where 
	cat != TRIM(cat) 
	or epcgv.subcat != TRIM(epcgv.subcat)
	or epcgv.maintenance != TRIM(epcgv.maintenance )
			
-- Data standartization & Consistency
select
	DISTINCT maintenance
from erp_px_cat_g1v2 epcgv 