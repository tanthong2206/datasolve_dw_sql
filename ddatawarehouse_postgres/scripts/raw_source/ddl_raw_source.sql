/*
===============================================================================
DDL Script: Create raw_source Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'raw_source' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'raw_source' Tables
===============================================================================
*/

CREATE OR REPLACE PROCEDURE raw_source.ddl_raw()
    LANGUAGE plpgsql
AS
$$
BEGIN
    RAISE NOTICE '======================================';
    RAISE NOTICE 'CREATE RAW_SOURCE IN STORE TABLE';
    RAISE NOTICE '======================================';

    DROP TABLE IF EXISTS raw_source.in_store_data;
    CREATE TABLE raw_source.in_store_data
    (
        FirstName       VARCHAR(100)   NULL,
        LastName        VARCHAR(100)   NULL,
        Email           VARCHAR(255)   NULL,
        Phone           VARCHAR(20)    NULL,
        Address         VARCHAR(255)   NULL,
        City            VARCHAR(100)   NULL,
        State           VARCHAR(100)   NULL,
        ZipCode         VARCHAR(20)    NULL,
        Country         VARCHAR(100)   NULL,
        OrderDate       DATE           NULL,
        Time            TIME           NULL,
        ShippingAddress VARCHAR(255)   NULL,
        OrderStatus     VARCHAR(50)    NULL,
        ProductName     VARCHAR(255)   NULL,
        ProductPrice    DECIMAL(10, 2) NULL,
        Category        VARCHAR(100)   NULL,
        Quantity        INT            NULL,
        TransactionID   UUID           NULL,
        StoreLocation   VARCHAR(100)   NULL
    );

    RAISE NOTICE '======================================';
    RAISE NOTICE 'CREATE RAW_SOURCE ECOMMERCE TABLE';
    RAISE NOTICE '======================================';

    DROP TABLE IF EXISTS raw_source.ecommerce_data;
    CREATE TABLE raw_source.ecommerce_data
    (
        FirstName       VARCHAR(100)   NULL,
        LastName        VARCHAR(100)   NULL,
        Email           VARCHAR(255)   NULL,
        Phone           VARCHAR(20)    NULL,
        Address         VARCHAR(255)   NULL,
        City            VARCHAR(100)   NULL,
        State           VARCHAR(100)   NULL,
        ZipCode         VARCHAR(20)    NULL,
        Country         VARCHAR(100)   NULL,
        OrderDate       DATE           NULL,
        Time            TIME           NULL,
        ShippingAddress VARCHAR(255)   NULL,
        OrderStatus     VARCHAR(50)    NULL,
        ProductName     VARCHAR(255)   NULL,
        ProductPrice    DECIMAL(10, 2) NULL,
        Category        VARCHAR(100)   NULL,
        Quantity        INT            NULL,
        TransactionID   UUID           NULL
    );

    RAISE NOTICE '======================================';
    RAISE NOTICE '>> SUCCESSFULLY CREATE RAW TABLE';
    RAISE NOTICE '======================================';
END;
$$
