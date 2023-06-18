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
CREATE TABLE update_address_log( # Create table for log
	branchNo CHAR(10),
	old_street CHAR(20), 
    new_street CHAR(20), 
    update_time TIMESTAMP NOT NULL,
    PRIMARY KEY(update_time)
);

delimiter $ 
CREATE TRIGGER update_address # Create trigger
BEFORE INSERT ON branch
FOR EACH ROW 
BEGIN
	IF (new.branchNo = 'B006') THEN
		INSERT INTO update_address_log VALUES(new.branchNo, new.street, '123 Main Street', CURRENT_TIMESTAMP);
		SET new.street = '123 Main Street';
    END IF;
END; $

delimiter ;
INSERT INTO branch (branchNo, street, city, postcode) VALUES ('B006', '456 Peachtree Dr', 'Liverpool', 'L2 2DP'); # Testing trigger with insert statement

# 5) Create a trigger to update staff members’ salaries to be increased by 10% if their position is promoted to ‘Associate’.  Update a staff with position of 
#    ‘Assistant’ to ‘Associate’ to test.  Show code and report before and after salary.
CREATE TABLE pay_raise_log( # Create table for log
	staffNo CHAR(10),
	fName CHAR(20), 
    fLast CHAR(20), 
    old_salary DECIMAL(10, 0), 
    new_salary DECIMAL(10, 0), 
    update_time TIMESTAMP NOT NULL,
    PRIMARY KEY(update_time)
);

delimiter $ 
CREATE TRIGGER pay_raise # Create trigger
BEFORE UPDATE ON staff
FOR EACH ROW 
BEGIN
	IF (old.position = 'Assistant' and new.position = 'Associate') THEN
		SET new.salary = old.salary * 1.1;
		INSERT INTO pay_raise_log VALUES(old.staffNo, old.fName, old.lName, old.salary, new.salary, CURRENT_TIMESTAMP);
    END IF;
END; $

delimiter ;
UPDATE staff # Checking trigger by updating SA9 to Associate from Assistant
SET position = 'Associate'
WHERE staffNo = 'SA9';

SELECT * from pay_raise_log; # Reporting old salary and new salary for staff member
