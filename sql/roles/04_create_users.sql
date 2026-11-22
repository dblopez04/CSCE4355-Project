-- Manager
CREATE ROLE james_wilson  LOGIN PASSWORD 'change_me';

-- Employees
CREATE ROLE sarah_davis   LOGIN PASSWORD 'change_me';
CREATE ROLE michael_brown LOGIN PASSWORD 'change_me';
CREATE ROLE emily_johnson LOGIN PASSWORD 'change_me';
CREATE ROLE david_miller  LOGIN PASSWORD 'change_me';

-- Viewer
CREATE ROLE report_viewer LOGIN PASSWORD 'change_me';

-- Role membership
GRANT manager  TO james_wilson;
GRANT employee TO sarah_davis, michael_brown, emily_johnson, david_miller;
GRANT viewer   TO report_viewer;