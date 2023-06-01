# Part 1

USE classicmodels;

# 1) Report only the customer’s name, customer’s number, 
#    and phone number for those who live in San Diego
SELECT customerName, customerNumber, phone 
FROM customers 
WHERE city = 'San Diego';

# 2) What is the total amount paid by all customers, in total?
SELECT SUM(amount) AS totalamt
FROM payments;

# 3) Report those payments greater than $100,000 or less 
#    than $2,000, ordered by amount from highest to lowest.
SELECT * 
FROM payments 
WHERE amount > 100000 OR amount < 2000
ORDER BY amount DESC;

# 4) Report customer number and payments for customers with 
#    payments greater than $100,000, ordered ascending by 
#    customer number.
SELECT customerNumber, amount
FROM payments
WHERE amount > 100000
ORDER BY customerNumber;

# 5) List all customers containing ‘Network’ in their name.
SELECT customerName 
FROM customers
WHERE customerName like '%Network%';

# Part 2

USE text;

# 1) How many different types of cars are in the car table?
SELECT cartype, 
COUNT(*) AS numcartype
FROM car
GROUP BY cartype;

# 2) What is the average sales price of each type of car in the table?
SELECT cartype, 
AVG(carsell) AS avgcarsell
FROM car
GROUP BY cartype;

# 3) List the cost and car id of all cars that cost GREATER THAN the 
#    average cost of all cars. (HINT: use a nested query).
SELECT carcost, carid 
FROM car
WHERE carcost > (SELECT AVG(carcost) FROM car);

# 4) Report the gross profit made, number of cars sold, first name 
#    and last name by each salesperson.
SELECT SUM(c.carsell - c.carcost) AS grossprofit,
COUNT(c.personid) AS numcarsold, 
p.`person first`,
p.`person last`
FROM car c, person p
WHERE c.personid = p.personid
GROUP BY p.personid;

# 5) What is the average selling price of cars and number of cars 
#    sold by Sue Lim? Important:  Use her first and last name, not 
#    id, to filter your results.
SELECT AVG(c.carsell) AS avgcarsell, 
COUNT(c.personid) AS numcarsold
FROM car c, person p
WHERE c.personid = p.personid AND (p.`person first`, p.`person last`) = ('Sue', 'Lim')
GROUP BY p.personid;


