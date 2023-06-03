# Part I - Functions

# 1) Calculate the time remaining until the midterm exam (June 5, 2023 at 6:00 pm) using a function that utilizes the current time.
SELECT @midtermExamTime := str_to_date('June 5, 2023 at 6:00 pm', '%M %d, %Y at %h:%i %p') AS midtermExamTime, 
@currentTime := NOW() AS currentTime, 
@diffDate := 24*datediff(@midtermExamTime, @currentTime) AS diffDateInHours,
@diffTime := SUBTIME(CAST(@midtermExamTime AS TIME), CAST(@currentTime AS TIME)) AS diffTime,
(EXTRACT(HOUR FROM @diffTime) + @diffDate) DIV 24 AS numDaysLeft, 
(EXTRACT(HOUR FROM @diffTime) + @diffDate) % 24 AS numHoursLeft, 
EXTRACT(MINUTE FROM @diffTime) AS numMinLeft, 
EXTRACT(SECOND FROM @diffTime) AS numSecLeft;
# Question for Professor: Is there a way to have these intermediate local variables not show up in the table? I.e., diffDate and diffTime. 

# 2) Using the country table in the text database, list all of the country names (in all capital letters), the capital’s population, 
#    and the appropriate value (either “High” or “Low”) depending on whether the population is above/below 500,000 people.  
USE text;
SELECT UPPER(cName), capitalPop, IF(capitalPop > 500000, "High", "Low") AS popLevel
FROM country;

# Part II – 1:1 and Recursive
USE text;

# 1) List monarch type, name, and number of the predecessor of King George VI.
SELECT n.montype, m.premonname, m.premonnum
FROM Monarch m, Monarch n
WHERE (m.montype, m.monname, m.monnum) = (n.montype, n.monname, n.monnum) AND
(m.monname, m.monnum) = ('George', 'VI');

# 2) List monarch type, name, and number of the successor of Queen Victoria I.
SELECT n.montype, m.monname, m.monnum
FROM Monarch m, Monarch n
WHERE (m.montype, m.monname, m.monnum) = (n.montype, n.monname, n.monnum) AND
(m.premonname, m.premonnum) = ('Victoria', 'I');

# Part III – 1:M Recursive
USE text;

# 1) List the first names and salaries of employees who are a boss.
SELECT DISTINCT m.empfname, m.empsalary 
FROM emp m, emp n
WHERE m.empno = n.bossno;

# 2) List all the employees (name and salary) who are managed by Alice.
SELECT empfname, empsalary 
FROM emp
WHERE bossno = 1;

# 3) For each boss, list the average salary of the employees who work for him or her. Include the first name of the boss.
SELECT m.empfname AS bossName, 
AVG(n.empsalary) AS avgEmpSalary
FROM emp m, emp n
WHERE m.empno = n.bossno
GROUP BY n.bossno;

# Part IV – M:M Recursive
USE patent;

# 1) Find out which patents are citing patent No. 3992014.
SELECT patentno, cited
FROM citation
WHERE cited = '3992014';

# 2) Find out which patents are citing patent No. 3992014. List the category and applied year of the citing patents.
SELECT c.patentno, p.category, p.yearofapply
FROM citation c, patents p
WHERE c.cited = '3992014'
AND c.patentno = p.patent;

# 3) Find out which patents are citing patent No. 3992014. List the category and applied year of both cited and citing patents.
SELECT c.patentno AS citingPatentNo,
p.category AS citingPatentCategory, 
p.yearofapply AS citingPatentYearOfApply, 
c.cited AS citedPatentNo,
q.category AS citedPatentNo, 
q.yearofapply AS citedPatentYearOfApply
FROM citation c, citation d, patents p, patents q
WHERE c.patentno = d.patentno
AND c.patentno = p.patent
AND d.cited = q.patent
AND c.cited = '3992014';
