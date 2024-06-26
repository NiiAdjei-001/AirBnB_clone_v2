-- Setup MySQL setup for development
-- Create database hbnb_dev_db
CREATE DATABASE IF NOT EXISTS hbnb_dev_db;
-- Create user hbnb_dev
CREATE USER IF NOT EXISTS 'hbnb_dev'@'localhost'
IDENTIFIED BY 'hbnb_dev_pwd';
-- Grant all privileges to user on hbnb_dev_db
GRANT ALL PRIVILEGES
ON hbnb_dev_db.*
TO 'hbnb_dev'@'localhost';
-- Grant all privileges to user on hbnb_dev_db
GRANT SELECT
ON performance_schema.*
TO 'hbnb_dev'@'localhost';
-- Flush privileges
FLUSH PRIVILEGES
