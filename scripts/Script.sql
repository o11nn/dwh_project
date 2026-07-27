-- here we cheeck if out db exists 
SELECT datname 
FROM pg_database
WHERE datname = 'datawarehouse';

-- if query is negative
CREATE DATABASE datawarehouse;

--creating schemas for our database
create schema bronze;
create schema silver;
create schema gold;