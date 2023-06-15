# 1) Create tables and insert data for DreamHome Property Agency Company using the script: create_dreamhomerental_db.sql in MySQL Workbench in your personal schema.
# - Check

# 2) Create a view to list property owners who have a house for rent. USE [username]_database; <- Use your own database to execute the CREATE VIEW command;
USE bhall52_database;

CREATE VIEW HouseForRentOwners AS
SELECT DISTINCT po.fName, po.lName
FROM propertyforrent pr, privateowner po
WHERE pr.ownerNo = po.ownerNo;

# 3) Create a view to list the staff members first and last names along with their branch address information (i.e., street, city, postcode).
CREATE VIEW StaffMembers AS
SELECT s.fName, s.lName, b.street, b.city, b.postcode
FROM staff s, branch b
WHERE s.branchNo = b.branchNo;

# 4) In your [username]_database, create a stored database object to update the branch’s street address to ‘123 Main Street’  BEFORE a branchno of ‘B006’ is inserted.  
#    Insert a new record having ‘B006’ (and values for other fields) to test the trigger.



# 5) Create a trigger to update staff members’ salaries to be increased by 10% if their position is promoted to ‘Associate’.  Update a staff with position of 
#    ‘Assistant’ to ‘Associate’ to test.  Show code and report before and after salary.
CREATE TABLE pay_raise_log(
	fName CHAR(20), 
    fLast CHAR(20), 
    old_salary DECIMAL(10, 0), 
    new_salary DECIMAL(10, 0)
);

delimiter $
CREATE TRIGGER pay_raise
AFTER UPDATE ON staff
FOR EACH ROW BEGIN
INSERT INTO pay_raise_log VALUES(old.fName, old.lName, old.salary, new.salary);
END; $

UPDATE staff
SET position = 'Associate'
WHERE staffNo = 'SA9';

DROP TABLE pay_raise_log;
DROP TRIGGER pay_raise;
SHOW TRIGGERS;

