/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Raw_source)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'staging' schema from external CSV files. 
    It performs the following actions:
    - Truncates the staging tables before loading data.
    - Uses the `COPY` command to load data from csv Files to raw_source tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    CALL raw_source.load_raw();
===============================================================================
*/
CREATE or replace PROCEDURE raw_source.load_raw()
    LANGUAGE plpgsql
AS
$$
DECLARE
start_time timestamp;
end_time timestamp;
batch_start_time timestamp;
batch_end_time timestamp;
row_count int;
BEGIN
		batch_start_time := now();
		RAISE NOTICE '================================================';
		RAISE NOTICE '>> Loading Raw_Source Layer';
		RAISE NOTICE '================================================';

		RAISE NOTICE '------------------------------------------------';
		RAISE NOTICE '>> Loading In Store Table';
		RAISE NOTICE '------------------------------------------------';

		start_time := now();
		RAISE NOTICE '>> Truncating Table: raw_source.in_store_data';
		TRUNCATE TABLE raw_source.in_store_data;
		RAISE NOTICE '>> Inserting Data Into: raw_source.in_store_data';
		SET DATESTYLE = 'DMY'; --convert date format to DD/MM/YY for postgres to understand before loading the data
		COPY raw_source.in_store_data
		FROM '/Users/macos/Documents/GitHub/datasolve_dw_sql/datawarehouse_postgres/source/csv/in_store_dummy_data.csv'
		WITH (
			FORMAT CSV,
			HEADER TRUE
		);
	    -- Get the number of rows affected by the COPY command
		GET DIAGNOSTICS row_count = ROW_COUNT;
		end_time := now();
		RAISE NOTICE '>> Load Duration: %',concat((EXTRACT(EPOCH FROM end_time - start_time)),' seconds');
		RAISE NOTICE '>> Row inserted: %',row_count;
		RAISE NOTICE '>> -------------';

        RAISE NOTICE '------------------------------------------------';
		RAISE NOTICE '>> Loading Ecommerce Table';
		RAISE NOTICE '------------------------------------------------';

		start_time := now();
		RAISE NOTICE '>> Truncating Table: raw_source.crm_prd_info';
		TRUNCATE TABLE raw_source.ecommerce_data;

		RAISE NOTICE '>> Inserting Data Into: raw_source.ecommerce_data';
		COPY raw_source.ecommerce_data
		FROM '/Users/macos/Documents/GitHub/datasolve_dw_sql/datawarehouse_postgres/source/csv/eCommerceDummyData.csv'
		WITH (
			FORMAT CSV,
			HEADER TRUE
		);
		-- Get the number of rows affected by the COPY command
		GET DIAGNOSTICS row_count = ROW_COUNT;
		end_time := now();
		RAISE NOTICE '>> Load Duration: %',concat((EXTRACT(EPOCH FROM end_time - start_time)),' seconds');
		RAISE NOTICE '>> Row inserted: %',row_count;
		RAISE NOTICE '>> -------------';

		batch_end_time := now();
		RAISE NOTICE '==========================================';
		RAISE NOTICE 'Loading Raw_Source Layer is Completed';
        RAISE NOTICE '   - Total Load Duration: %', concat((EXTRACT(EPOCH FROM batch_end_time - batch_start_time)),' seconds');
		RAISE NOTICE '==========================================';
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE '==========================================';
        RAISE NOTICE 'ERROR OCCURRED DURING LOADING RAW_SOURCE LAYER';
        RAISE NOTICE 'Error Message: %', SQLERRM;
        RAISE NOTICE 'Error Code: %', SQLSTATE;
        RAISE NOTICE '==========================================';
        RAISE EXCEPTION 'Procedure failed'; -- Re-raise the exception to mark procedure as failed

END
$$;
