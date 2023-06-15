USE text;

# 1) Copy the person table from the text schema to your personal schema (i.e., [your username]_database) 
#    using the appropriate INSERT command as demonstrated in the DML Examples video lecture.  
#	 Execute the command and show the SQL command statement as your answer.
CREATE TABLE bhall52_database.person LIKE text.person;

INSERT INTO bhall52_database.person
SELECT * FROM text.person;

SELECT * FROM bhall52_database.person;

# 2) Insert a record into the person table for yourself. Include your first name, last name, and add 
#    a unique personid for yourself using the appropriate SQL command.  
#    Execute the command and show the SQL command statement as your answer.
INSERT INTO bhall52_database.person (personid, `person first`, `person last`)
VALUES (69, 'Brad', 'Hall');

# 3) Insert three records into the person table for Elon Musk, Bill Gates, and Jeff Bezos respectively 
#    using only one SQL statement for all three. Again, include the first name, last name, and add a 
#    unique personid for each person using only one SQL command to solve this question.  
#    Execute the command and show the SQL command statement as your answer.
INSERT INTO bhall52_database.person (personid, `person first`, `person last`)
VALUES (3, 'Elon', 'Musk'),
	   (4, 'Bill', 'Gates'),
	   (5, 'Jeff', 'Bezos');

# 4) Remove all records of people in the person table who have last names beginning with “H” using the using the appropriate SQL command.
DELETE FROM bhall52_database.person 
WHERE `person last` LIKE 'H%';

# 5) Two of the records in the person table were entered incorrectly by the data entry specialist.  
#    Bruce Capelli and Barbara Bush’s names were misentered as Bruce Bush and Barbara Capelli. 
#    Correct these entries using SQL and show the SQL code that you executed to make the correction.  (This may be more than one SQL command.)
UPDATE bhall52_database.person
SET `person first` = 'Barbara'
WHERE `person last` = 'Bush';

UPDATE bhall52_database.person
SET `person first` = 'Bruce'
WHERE `person last` = 'Capelli';

# 6) Copy the car table from the text schema to your personal schema (i.e., [your username]_database) using the appropriate INSERT command.  
#    Execute the command and show the SQL command statement as your answer.
CREATE TABLE bhall52_database.car LIKE text.car;

INSERT INTO bhall52_database.car
SELECT * FROM text.car;

SELECT * FROM bhall52_database.car;

# 7) Insert three records into the car table that represent your top three favorite vehicles using a single SQL command.  
#    Only leave the carsell values as NULL values.  Add a reasonable fair market price for the carcost field.  
#    For the personid fields, use the personid that you assigned yourself in Question #2 above. 
#    Execute the command and show the SQL command statement as your answer.
INSERT INTO bhall52_database.car (carid, carcost, carsell, cartype, personid)
VALUES (11, 6450, null, 'sports', 69),
	   (12, 2375, null, 'sedan', 69),
	   (13, 9390, null, 'sports', 69);

# 8) For the 3 records created in Question #7, add a carsell price that is 130% of the carcost using a calculation that 
#    updates the null value to the calculated one. 
#    Execute the commands and show the SQL command statements as your answer. (This may be more than one SQL command.)
UPDATE bhall52_database.car 
SET carsell = 1.3 * carcost
WHERE carsell IS NULL;

# 9) Remove all records from the car table that have car types of “coupe”. 
#    Execute the commands and show the SQL command statements as your answer.
DELETE FROM bhall52_database.car 
WHERE cartype = 'coupe';

# 10)Revise all existing values in the car table’s cartype column so that they are in all capitalized letters.
UPDATE bhall52_database.car 
set cartype = upper(cartype);
