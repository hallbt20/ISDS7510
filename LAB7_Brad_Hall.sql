# 1) Verify at least one table currently exists in your personal schema (e.g. username_database) that contains records in it.  If none exist, copy a table such as one in the 
#    classicmodels schema or a table from your team project’s schema.  List the name(s) of the table(s) here.
USE bhall52_database;
SHOW tables; # Tables are car, claim, and person

# 2) Allow the members of your project team to have ‘select’ access to your username_database schema using the appropriate SQL Data Control Language Command.  Enter the SQL code here.
GRANT SELECT ON bhall52_database.* TO 'raskin1'; # Grant select access to Rion Askin
GRANT SELECT ON bhall52_database.* TO 'jholm69'; # Grant select access to Justin Holmes

# 3) Select a team member’s schema and query all records from a table in that person’s schema.  List the following information: the team member’s name, schema name, 
#    SQL command to activate their schema, the SQL query, and number of records in the result set.   
USE raskin1_database; # Rion Askin's schema
SELECT * FROM person;
SELECT COUNT(*) FROM person; # There are 11 records in the person table

# 4) Remove the ‘select’ access to your personal schema from one member of your project team. Check with that team member to verify that he or she know longer 
#    can select data from your personal schema.  List the team member’s name and ‘verified’ in a commented line for your answer once completed.  (i.e., Add a 
#    line to the SQL file such as “# Question 4 – [team member name] – verified.”)
REVOKE SELECT ON bhall52_database.* FROM 'raskin1'; # Removing select access from Rion Askin
# Question 4 - Rion Askin - verified

# 5) Can the team members that continue to have ‘select’ access to your schema give access to that schema to others?  Why or why not?
#  - Users with 'select' access cannot give access to others, as this is a DML type of access. The ability to 'grant' others access requires a
#    DDL type of access. By reverse engineering using 'SHOW GRANTS;', I saw that you gave me all privileges to the bhall52_database db 'WITH GRANT OPTION'. 
#    That's how I was able to share a schema that you created to my group members. 