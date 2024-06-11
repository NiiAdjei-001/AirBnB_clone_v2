-- Setup MySQL setup for test
-- Create database hbnb_test_db
CREATE DATABASE IF NOT EXISTS hbnb_test_db;
-- Create user hbnb_dev
CREATE USER IF NOT EXISTS 'hbnb_test'@'localhost'
IDENTIFIED BY 'hbnb_test_pwd';
-- Grant all privileges to user on hbnb_test_db
GRANT ALL PRIVILEGES
ON hbnb_test_db.*
TO 'hbnb_test'@'localhost';
-- Grant all privileges to user on hbnb_test_db
GRANT SELECT
ON performance_schema.*
TO 'hbnb_test'@'localhost';
-- Flush privileges
FLUSH PRIVILEGES
