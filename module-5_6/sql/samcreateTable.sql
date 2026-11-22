-- Sam Dirr | CSD430 | Modules 5.2 and 6.2 | November 22, 2026
-- Source: Generated with assistance from OpenAI ChatGPT, November 22, 2026.
-- https://chatgpt.com/
-- Run first using an administrator account. Creates an empty movie table.
-- IF NOT EXISTS preserves existing records; it does not repair an older schema.
CREATE DATABASE IF NOT EXISTS CSD430
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE CSD430;

CREATE TABLE IF NOT EXISTS sammoviesdata (
    movie_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    director VARCHAR(100) NOT NULL,
    release_year SMALLINT UNSIGNED NOT NULL,
    genre VARCHAR(50) NOT NULL,
    runtime_minutes SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (movie_id)
) ENGINE=InnoDB;

-- Required course account for local JDBC access.
-- Existing accounts are preserved; their passwords are not overwritten.
CREATE USER IF NOT EXISTS 'student1'@'localhost' IDENTIFIED BY 'pass';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP
    ON CSD430.* TO 'student1'@'localhost';

-- Capture the database, table definition, and granted permissions.
SELECT DATABASE() AS database_name;
SHOW CREATE TABLE sammoviesdata;
SHOW GRANTS FOR 'student1'@'localhost';
