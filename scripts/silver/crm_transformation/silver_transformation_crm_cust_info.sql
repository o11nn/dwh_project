-- In this script we implement data cleaning such as deduplication,
-- normalisation, handling NULL values, remove unnecessary spaces and gaps
CREATE OR REPLACE PROCEDURE silver.transform_crm_cust_info()
LANGUAGE plpgsql
AS $$

DECLARE
	ts_start_time timestamp;
	ts_end_time timestamp;
BEGIN
	BEGIN
		TRUNCATE silver.crm_cust_info;

		ts_start_time := clock_timestamp();
		RAISE NOTICE 'Start transforming and inserting data into silver.crm_cust_info';
		
		INSERT INTO silver.crm_cust_info
		(
			cst_id,
			cst_key,
			cst_firstname,
			cst_lastname,
			cst_material_status,
			cst_gndr,
			cst_create_date
			
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
		
		RAISE NOTICE 'Transforming and inserting crm_cust_info is end';
		ts_end_time := clock_timestamp();
		RAISE NOTICE 'Duration time: duration=%', ts_end_time - ts_start_time;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE NOTICE 'crm_cust_info transformation failed: SQLSTATE=% SQLERRM=%', SQLSTATE, SQLERRM;
	END;
END;
$$;

call transform_crm_cust_info()
		