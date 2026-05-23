
CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4,2)
);


INSERT INTO salesman (salesman_id, name, city, commission)
VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT NULL,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id)
VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006),
(3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007),
(3001, 'Brad Guzan', 'London', NULL, 5005);

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.40, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007),
(70013, 3045.60, '2012-04-25', 3002, 5001);

----1.	From the above tables write a SQL query to find the salesperson and customer who reside in the same city.
--Return Salesman, cust_name and city.

select * from customer

select s.salesman_id , s.name as salesmanName  , c.cust_name as cutomerName , c.city
from salesman s join customer c on s.salesman_id = c.salesman_id

----2.	From the above tables write a SQL query to find salespeople who received commissions of more than 12 percent
--from the company. Return Customer Name, customer city, Salesman, commission.

select s.salesman_id , s.name as salesmanName , c.cust_name as cutomerName , s.commission
from salesman s 
join customer c 
on s.salesman_id = c.salesman_id where s.commission > 0.12

----3.	From the above tables write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt,
--Customer Name, grade, Salesman, commission.

select o.ord_no , o.purch_amt , o.ord_date  , c.cust_name as customerName , c.grade , s.name as salesMan , s.commission
from Orders o 
join customer c on o.customer_id = c.customer_id 
join salesman s on o.salesman_id = s.salesman_id

----4.	From the above tables write a SQL query to find those orders where the order amount exists between 500 and 2000.
--Return ord_no, purch_amt, cust_name, city.

select o.ord_no , o.purch_amt , c.cust_name , c.city
from orders o 
join customer c on o.customer_id = c.customer_id
where o.purch_amt between 500 and 2000


----5.	From the above tables write a SQL query to display the customer name, customer city, grade, salesman, salesman city. 
--The results should be sorted by ascending customer_id.

select c.customer_id, c.cust_name as Name , c.city , c.grade , s.salesman_id , s.name as salesmanName , s.city as salesmanCity
from customer c
join salesman s on c.salesman_id = s.salesman_id 
order by c.customer_id