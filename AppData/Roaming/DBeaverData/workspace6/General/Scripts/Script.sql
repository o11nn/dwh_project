--here we check if our DB is exists
SELECT datname
FROM pg_database
WHERE datname = 'mydb';

--and if not, jsut create database
CREATE DATABASE datawarehouse;

--create the bronze schema
create schema bronze;

--create the silver schema
create schema silver;

--create the gold schema
create schema gold;