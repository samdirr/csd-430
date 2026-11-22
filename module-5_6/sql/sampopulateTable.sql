-- Sam Dirr | CSD430 | Modules 5.2 and 6.2 | November 22, 2026
-- Source: Generated with assistance from OpenAI ChatGPT, November 22, 2026.
-- https://chatgpt.com/
-- Run after samcreateTable.sql. Adds ten movies in one transaction.
-- Rerunning with the same IDs fails rather than silently changing existing data.
USE CSD430;
START TRANSACTION;
INSERT INTO sammoviesdata
    (movie_id, title, director, release_year, genre, runtime_minutes)
VALUES
    (1, 'Toy Story', 'John Lasseter', 1995, 'Animation', 81),
    (2, 'Finding Nemo', 'Andrew Stanton', 2003, 'Animation', 100),
    (3, 'The Incredibles', 'Brad Bird', 2004, 'Animation', 115),
    (4, 'Ratatouille', 'Brad Bird', 2007, 'Animation', 111),
    (5, 'WALL-E', 'Andrew Stanton', 2008, 'Science Fiction', 98),
    (6, 'Up', 'Pete Docter', 2009, 'Adventure', 96),
    (7, 'Inside Out', 'Pete Docter', 2015, 'Animation', 95),
    (8, 'Coco', 'Lee Unkrich', 2017, 'Fantasy', 105),
    (9, 'Soul', 'Pete Docter', 2020, 'Fantasy', 100),
    (10, 'Luca', 'Enrico Casarosa', 2021, 'Adventure', 95);
COMMIT;

-- Capture all ten records and the record count for assignment evidence.
SELECT * FROM sammoviesdata ORDER BY movie_id;
SELECT COUNT(*) AS record_count FROM sammoviesdata;
