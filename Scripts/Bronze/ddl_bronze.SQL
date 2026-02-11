/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

/*
==============================================================================
Stored Procedure : Load broze layer (Source -> Broze layer)
===============================================================================
This Stored Procedure Load Data into the 'bronze' Shcema from external .csv files.
It Performs the following actions.
-- Truncate the bronze table before loading data
-- uses BULK INSERT command to load data from csv files to bronze tables

Parameters:
None 
--This Stored Procedure does'nt store and parameters or return any value.

USE Example: EXEC bronze.load_bronze;
 

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY
	    SET @batch_start_time = GETDATE();
		PRINT('============================================');
		PRINT('Loading Bronze Layer');
		PRINT('============================================');

		PRINT('--------------------------------------------');
		PRINT('Loading CRM files');
		PRINT('--------------------------------------------');

		SET @start_time = GETDATE();
		PRINT '>> Truncating Tables: bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info

		PRINT '>> Inserting Data Into: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\projects\Project-1\DataWarehouseProject\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Loading Time: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS VARCHAR)+ ' seconds';
		PRINT'---------------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Tables: bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info

		PRINT '>> Inserting Data Into: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\projects\Project-1\DataWarehouseProject\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Loading Time: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS VARCHAR)+ ' seconds';
		PRINT'---------------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Tables: bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details

		PRINT '>> Inserting Data Into: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\projects\Project-1\DataWarehouseProject\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Loading Time: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS VARCHAR)+ ' seconds';
		PRINT'---------------------------'

		PRINT('--------------------------------------------');
		PRINT('Loading ERP files');
		PRINT('--------------------------------------------');

		SET @start_time = GETDATE();
		PRINT '>> Truncating Tables: bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12

		PRINT '>> Inserting Data Into: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\projects\Project-1\DataWarehouseProject\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Loading Time: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS VARCHAR)+ ' seconds';
		PRINT'---------------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Tables: bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101

		PRINT '>> Inserting Data Into: bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\projects\Project-1\DataWarehouseProject\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Loading Time: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS VARCHAR)+ ' seconds';
		PRINT'---------------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Tables: bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\projects\Project-1\DataWarehouseProject\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Loading Time: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS VARCHAR)+ ' seconds';
		PRINT'---------------------------'
		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
		PRINT 'Total Load Duration; '+ CAST(DATEDIFF(second,@batch_start_time, @batch_end_time) AS NVARCHAR) +' seconds';
		PRINT '=========================================='
		END TRY
		BEGIN CATCH
			PRINT'==============================================';
			PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER'
			PRINT'ERROR Message'+ ERROR_MESSAGE();
			PRINT'ERROR Number'+ CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT'ERROR State' + CAST(ERROR_STATE() AS NVARCHAR);
			PRINT'==============================================';
		END CATCH
END
