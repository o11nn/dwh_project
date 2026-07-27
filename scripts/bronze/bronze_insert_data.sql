
CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$ 

DECLARE 
	ts_start_time timestamp;
	ts_end_time timestamp;

BEGIN
	BEGIN
		ts_start_time := clock_timestamp();
		
		RAISE NOTICE 'Loading CRM system';
		RAISE NOTICE '===================================================';
		RAISE NOTICE 'Loading bronze layer';
		-- CRM source system
		-- bulk insert into crm_cust_info
		RAISE NOTICE '>> Trancating crm_cust_info';
		TRUNCATE bronze.crm_cust_info;
		
		
		LOCK TABLE bronze.crm_cust_info IN ACCESS EXCLUSIVE MODE;
		
		RAISE NOTICE '>> Inserting data into crm_cust_info';
	
		COPY bronze.crm_cust_info 
		FROM 'D:\data_with_Baara_project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			HEADER True,
			FORMAT csv,
			DELIMITER ','
			);

		ts_end_time := clock_timestamp();
		RAISE NOTICE 'Duration time: duration=%', ts_end_bronze - ts_start_bronze;
		
		
		
		
		-- bulk insert into crm_prd_info
		RAISE NOTICE '>> Trancating crm_prd_info';

		ts_start_time := clock_timestamp();

		TRUNCATE bronze.crm_prd_info;
		LOCK TABLE bronze.crm_prd_info IN ACCESS EXCLUSIVE MODE;
	
		RAISE NOTICE '>> Inserting data into crm_prd_info';	
	
		COPY bronze.crm_prd_info 
		FROM 'D:\data_with_Baara_project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			HEADER True,
			FORMAT csv,
			DELIMITER ','
			);
		ts_end_time := clock_timestamp();
		RAISE NOTICE 'Duration time: duration=%', ts_end_bronze - ts_start_bronze;
		
		
		
		
		-- bulk insert into crm_sales_details
		RAISE NOTICE '>> Trancating crm_sales_details';

		ts_start_time := clock_timestamp();
	
		TRUNCATE bronze.crm_sales_details;
		LOCK TABLE bronze.crm_sales_details IN ACCESS EXCLUSIVE MODE;
		
		RAISE NOTICE '>> Inserting data into crm_sales_details';
	
		COPY bronze.crm_sales_details 
		FROM 'D:\data_with_Baara_project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			HEADER True,
			FORMAT csv,
			DELIMITER ','
			);
		ts_end_time := clock_timestamp();
		RAISE NOTICE 'Duration time: duration=%', ts_end_bronze - ts_start_bronze;
		
		
		RAISE NOTICE 'Loading ERP system';
		RAISE NOTICE '===================================================';
		RAISE NOTICE 'Loading bronze layer';
		
		-- ERP source system 
		-- bulk insert into erp_cust_az12
		
		RAISE NOTICE '>> Trancating erp_cust_az12';

		ts_start_time := clock_timestamp();
	
		TRUNCATE bronze.erp_cust_az12;
		
		RAISE NOTICE '>> Inserting data into erp_cust_az12';	
	
		LOCK TABLE bronze.erp_cust_az12 IN ACCESS EXCLUSIVE MODE;
		
		COPY bronze.erp_cust_az12 
		FROM 'D:\data_with_Baara_project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			HEADER True,
			FORMAT csv,
			DELIMITER ','
			);
		ts_end_time := clock_timestamp();
		RAISE NOTICE 'Duration time: duration=%', ts_end_bronze - ts_start_bronze;
		
		
		
		-- bulk insert into erp_loc_a12
		RAISE NOTICE '>> Trancating erp_loc_a12';	
	
		ts_start_time := clock_timestamp();
		TRUNCATE bronze.erp_loc_a12;
		
		
		LOCK TABLE bronze.erp_loc_a12 IN ACCESS EXCLUSIVE MODE;
		
		RAISE NOTICE '>> Inserting data into erp_loc_a12';
	
		COPY bronze.erp_loc_a12 
		FROM 'D:\data_with_Baara_project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			HEADER True,
			FORMAT csv,
			DELIMITER ','
			);
		ts_end_time := clock_timestamp();
		RAISE NOTICE 'Duration time: duration=%', ts_end_bronze - ts_start_bronze;
		
		
		
		
		-- bulk insert into erp_px_cat_g1v2
		RAISE NOTICE '>> Trancating erp_px_cat_g1v2';
		ts_start_time := clock_timestamp();
		
		TRUNCATE bronze.erp_px_cat_g1v2;
		
		
		LOCK TABLE bronze.erp_px_cat_g1v2 IN ACCESS EXCLUSIVE MODE;
		
		RAISE NOTICE '>> Inserting data into erp_px_cat_g1v2';
	
		COPY bronze.erp_px_cat_g1v2
		FROM 'D:\data_with_Baara_project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			HEADER True,
			FORMAT csv,
			DELIMITER ','
			);

		ts_end_time := clock_timestamp();
		RAISE NOTICE 'Duration time: duration=%', ts_end_bronze - ts_start_bronze;

	EXCEPTION 
		WHEN OTHERS THEN
			RAISE NOTICE 'Bronze layer load failed: SQLSTATE=% SQLERRM=%', SQLSTATE, SQLERRM;
	END;
END;
$$;

--CALL bronze.load_bronze();




