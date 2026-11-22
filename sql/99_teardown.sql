-- 1. Drop the database
DROP DATABASE IF EXISTS retail_db WITH (FORCE);

-- 2. Drop login users
DROP ROLE IF EXISTS james_wilson, sarah_davis, michael_brown, emily_johnson, david_miller, report_viewer;

-- 3. Drop group roles
DROP ROLE IF EXISTS manager, employee, viewer;