create table salesman (
salesman_id int primary key , 
name varchar(30) , 
city varchar(30),
commission decimal(3,2) 
)
INSERT INTO salesman (salesman_id, name, city, commission)
VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12);

create table customer(
customer_id int primary key , 
customer_name varchar(30) , 
city varchar(30) , 
grade char(3) , 
salesman_id int,
foreign key(salesman_id) references salesman(salesman_id) 
)

INSERT INTO customer (customer_id, customer_name, city, grade, salesman_id)
VALUES
(3002, 'Nick Rimando', 'New York', '100', 5001),
(3007, 'Brad Davis', 'New York', '200', 5001),
(3005, 'Graham Zusi', 'California', '200', 5002),
(3008, 'Julian Green', 'London', '300', 5002),
(3004, 'Fabian Johnson', 'Paris', '300', 5006),
(3009, 'Geoff Cameron', 'Berlin', '100', 5003),
(3003, 'Jozy Altidor', 'Moscow', '200', 5007),
(3001, 'Brad Guzan', 'London', NULL, 5005);


create table orders(
order_id int primary key , 
amount decimal(10,2) , 
order_date datetime , 
customer_id int , 
salesman_id int , 
foreign key(customer_id) references customer(customer_id) , 
foreign key(salesman_id) references salesman(salesman_id)
)

INSERT INTO orders (order_id, amount, order_date, customer_id, salesman_id)
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
(70011, 75.29, '2012-08-17', 3003, 5007);

INSERT INTO orders (order_id, amount, order_date, customer_id, salesman_id)
VALUES
(70013, 3045.60, '2012-04-25', 3002, 5001);


--questions
--1.	From the above tables write a SQL query to find the salesperson and customer who reside in the same city. Return Salesman, cust_name and city.

select s.name ,s.city, c.customer_name , c.city from salesman s join customer c on s.salesman_id = c.salesman_id where s.city = c.city ; 

--2.	From the above tables write a SQL query to find salespeople who received commissions of more than 12 percent from the company.
--Return Customer Name, customer city, Salesman, commission.
select c.customer_name , c.city , s.name , s.commission from salesman s join customer c on s.salesman_id = c.salesman_id where s.commission > 0.12


--3.	From the above tables write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission.

select  o.order_id , o.order_date , o.amount , c.customer_name , c.grade , s.name , s.commission  from salesman s join customer c 
on s.salesman_id = c.salesman_id join orders o on c.customer_id = o.customer_id ; 

--4.	From the above tables write a SQL query to find those orders where the order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.
select o.order_id , o.amount , c.customer_name , c.city from orders o join customer c on o.customer_id = c.customer_id where o.amount between 500 and 2000 ; 

--5.	From the above tables write a SQL query to display the customer name, customer city, grade, salesman, salesman city. 
--The results should be sorted by ascending customer_id. 
select c.customer_id , c.customer_name , c.city , c.grade , s.name , s.city from customer c join salesman s on c.salesman_id = s.salesman_id order by c.customer_id