select * from categories;
select * from customers;
select * from employees;
select * from orders;
select * from order_items;
select * from products;
select * from sales;
select * from salary_log;
select * from reviews;
select * from stock_log;
select * from suppliers;

 use assignment;
# 1 . Write a query to find the top 5 customers with
# the highest total order amount.
# Dataset : Customers(Customer_id,Customer_name), Orders (order_id,customer_id,order_date)

SELECT C.customer_id,C.customer_name,
sum(O.order_amount) AS total_order_amount
FROM customers AS C 
JOIN orders AS O 
ON C.customer_id=O.customer_id 
GROUP BY C.customer_id,C.customer_name
ORDER BY total_order_amount DESC LIMIT 5;

## 2.  Retrieve the name of Customers who have placed orders in the past 30 days.
# Dataset : Customers(customer_id,customer_name),Orders (Order_id,customer_id,order_date)

select  C.customer_name from orders as O join customers as C
on O.customer_id=C.customer_id
where O.order_date>=DATE_ADD(curdate(),interval -30 day);

select * from orders where order_date >= (now()-interval 30 day);
select * from orders where datediff(curdate(),order_date)<60;

## 3.  Find the products that have been ordered at least three times.
## Dataset : Products(Product_id,product_name),Order_Items(order_id,product_id,quantity)

select P.product_name from products as P join order_items as O 
on P.product_id=O.product_id group by P.product_name
having count(P.product_id)>=3;

## 4.  Retrieve the order details for orders placed by customers from a specific city.
## Dataset : Customers(customer_id,customer name,city) Orders(order_id,customer_id,order_date)
## Order_details(order_id,product_id,quantity)
  
select C.customer_id,C.customer_name,C.city,OI.order_id,OI.product_id,OI.quantity 
from customers as C join orders as O on C.customer_id=O.customer_id
join order_items as OI on O.order_id=OI.order_id where C.city="Chicago";


##  5.  Write a query to find the customer who have placed orders for products with
## a price greater the $100.
## Dataset : Customers(customer_id,customer_name),Orders(order_id,customer_id,
## order_date),Products (product_id,product_name,price),Order_details(order_id,
## product_id,quantity)


select C.customer_id,C.customer_name,OI.order_id from 
customers as C join orders as O on C.customer_id=O.customer_id
join order_items as OI on OI.order_id=O.order_id
join products as P on P.product_id=OI.product_id
where 100<((P.price)*(OI.quantity));


## 6  .Get the average order amount for each customer.
## Dataset: Customers(Customer_id,customer_name),Orders(order_id,
## customer_id,order_date,order_amount)

select C.customer_id,C.customer_name,avg(O.order_amount) as Average_Order_Amount
from customers as C join orders as O
on C.customer_id=O.customer_id
group by C.customer_id,C.customer_name ;


## 7. Find the products that have never been ordered.
## dataset : products(product_id,product_name),Order_items(order_id,product_id,quantity)

select * from products as P  left join order_items as O 
on P.product_id=O.product_id where O.product_id is null;

## 8. Retrieve the names of customers who have placed orders on weekends. (Saturday or Sunday).
## Dataset : Customers(customer_id,customer_name),orders(order_id,customer_id,order_date)

select * from orders where dayname(order_date)="Saturday" or dayname(order_date)="Sunday";
 
select * from orders where dayname(order_date) in ("Sunday","Saturday");

select C.customer_name,O.order_id,O.order_date
from customers as C join orders as O 
on C.customer_id=O.customer_id
where dayname(O.order_date) in ("Sunday","Saturday");




## 9. Get the total order amount for each month.
## Dataset : Orders(order_id,order_date,order_amount)


select * from orders;
select monthname(order_date)as months,sum(order_amount) as total_order_amount_for_each_month 
from orders group by months ;


## 10.  Write a query to find the customers who have placed orders for more than two 
#different products.
## Dataset: Customers(Customer_id,customer_name),Orders(order_id,customer_id,order_date),
## Order_items(order_id,product_id,quantity)

select C.customer_id,C.customer_name as Count_of_Product  
from customers as C join orders as O 
on C.customer_id=O.customer_id
join order_items as OI
on O.order_id=OI.order_id
group by C.customer_id,C.customer_name having count(distinct OI.product_id)>2;

## 11. Retrieve the order details along with the customer name and product name for each order.
## Dataset: Customers(customer_id,customer_name),Orders(order_id,customer_d,order_date),
## order_items(order_id,product_id,quantity)

select C.customer_name,OI.product_id,O.order_id
from customers as C join orders as O
on C.customer_id=O.customer_id 
join order_items as OI
on O.order_id=OI.order_id;

## 12.  Find the products and their corresponding suppliers names.
## dataset: Products(product_id,product_name,supplier_id),Suppliers(supplier_id,supplier_name)

select P.product_name,S.supplier_name from products as P join Suppliers as S 
on P.supplier_id=S.supplier_id;

##13. Get a list of customers who have never placed an order.
## Dataset : Customers(customer_id,customer_name),Orders(order_id,customer_id)

select * from customers as C left join orders as O
on C.customer_id=O.customer_id
where O.customer_id is null;



## 14. Retrieve the names of customers along with the total quantity of products they ordererd.
## dataset: Customers(customer_id,customer_name),Orders(order_id,customer_id),Order_items(order_id,
## product_id,quantity)

select C.customer_name,sum(OI.quantity)as Total_Quantity_of_Products
from customers as C join orders as O
on O.customer_id=C.customer_id
join order_items as OI
on OI.order_id=O.order_id
group by C.customer_name;


##15. Find the Products that have been ordered by customers from a specific country.
## Dataset: Products(product_id,product_name),Orders(order_id,customer_id),
## Customers(customer_id,country),order_items(order_id,product_id,quantity) *********

select P.product_id,P.product_name 
from products as P join order_items as OI
on P.product_id=OI.product_id
join orders as O 
on OI.order_id=O.order_id
join customers as C
on C.customer_id=O.customer_id 
where C.country="USA";

## 16 Get the total order amount for each customer,including those who have not placed any orders.
## dataset : Customers(customer_id,customer_name), Orders(Order_id,custmer_id,order_amount)

select C.customer_id,C.customer_name,sum(O.order_amount) as Total_order_amount 
from customers as C left join orders as O
on C.customer_id=O.customer_id
group by C.customer_id,C.customer_name;


## 17  Retrieve the order details for orders placed by customers with a specific occupation.
## Dataset: Customers(customer_id,customer_name,occupation),Orders(order_id,customer_id,order_date),
## Order_items(order_id,product_id,quantity)

select OI.order_id,OI.product_id,OI.quantity,O.customer_id,O.order_amount,O.order_date
from customers as C join orders as O
on O.customer_id=C.customer_id
join order_items as OI
where C.occupation="Engineer";

## 18 Find the customers who have placed orders for products with a price 
## higher than the average price of all products.
## dataset: Customers(customer_id,customer_name),Orders(order_id,customer_id,order_date),
## products(product_id,product_name,price),Order_items(order_id,product_id,quantity)

select C.customer_name
from products as P join order_items as OI
on P.product_id=OI.product_id
join orders as O 
on OI.order_id=O.order_id
join customers as C
on C.customer_id=O.customer_id 
where ((P.price)*(OI.quantity))>(select avg(price) from products);

## 19 Retrieve the names of customers along with the total number of orders they have placed. 
## Dataset: Custoers(customer_id,customer_name),Orders(Order_id,customer_id)


select C.customer_name,count(O.order_id) as Total_number_of_orders
from customers as C join orders as O 
on C.customer_id=O.customer_id
group by C.customer_name;

## 20 Get list of products and the total quantity ordered for each product.
## dataset : products(product_id,product_name),Order_items(order_id,product_id,quantity)

select P.product_name,sum(OI.quantity)as Totl_quantity_order 
from products as P join order_items as OI
on P.product_id=OI.product_id 
group by P.product_name;

## 21 Retrieve all customers with names starting with 'A' and ending with 'n'
## Dataset: Customers(customer_id,customer_name)

select customer_id,customer_name from customers where customer_name like "A%n";

## 22 Find the products with names containig at least one digit.
## dataset : products(product_id,product_name)

select * from products 
where product_name like "%0%"
or product_name like "%1%"
or product_name like "%2%"
or product_name like "%3%"
or product_name like "%4%"
or product_name like "%5%"
or product_name like "%6%"
or product_name like "%7%"
or product_name like "%8%"
or product_name like "%9%"
;

#23 Get the list of employees sorted by their salary in ascending order.Null values should appear at the end.
## Dataset:Employees(employee_id,employee_name,salary)

select employee_id,employee_name,salary from employees order by salary asc;
SELECT employee_id, employee_name, salary
FROM Employees
ORDER BY salary IS NULL, salary ASC; 

# 24 Retrieve the customers whose names contain exactly five characters.
# dataset: Customers(customer_id,customer_name)

select customer_id,customer_name from customers where length(customer_name)=5;


# 25 Find the products with names starting with 'S' and ending with 'e'.
# dataset:   products(product_id,product_name)

select product_id,product_name from products where product_name like "S%e";

# 26 Get the list of employees sorted by their last name and then by their
# first name. DataSet : Employees(employee_id,first_name,last_name,salary)

select employee_id,first_name,last_name,salary from employees 
order by last_name,first_name;

# 27 Retrieve the orders placed on a specific date and sort them by the customer name in alphabetical
#order. Dataset : Customers(customer_id,customer_name),Orders(order_id,customer_id,order_date) inssufficient data

select C.customer_id,C.customer_name,O.order_id,O.order_date 
from customers as C join orders as O
on C.customer_id=O.customer_id
where O.order_date="2023-05-05"
order by C.customer_name asc;

# 28 Find the products with names conatianing exactly three letter.
# dataset: products(product_id,product_name)

select product_id,product_name from products where length(product_name)=3;

# 29 Get the list of employees sorted by their salary in descending order. 
# Null values should appear at the beginning.
# dataset : Employees(employee_id,employee_name,salary)

select employee_id,employee_name,salary
from employees order by salary is not null,salary desc;

# 30 Retrieve the customers whose names contain a space character.
# Dataset :  Customers(customer_id,customer_name)

select customer_id,customer_name from customers where customer_name like "% %";

# 31  Calculate the total quantity and total amount for each order.
# dataset:  Orders(order_id,order_date),Order_items(order_id,product_id,quantity,amount)

select O.order_id,sum(O.order_amount) as Total_Amount,sum(OI.quantity) as Total_Quantity 
from orders as O join order_items as OI
on O.order_id=OI.order_id
group by O.order_id;

# 32 find the average age and the number of employees for each jpb title. 
# dataset: Employees(employee_id,employee_name,age,job_title)

select job_title,count(employee_id) as Number_of_employees,avg(age) as Average_age 
from employees group by job_title;

# 33 Get the total number of products in each category. 
# Dataset : products(product_id,product_name,category_id),
# Categories(category_id,category_name)

select P.category_id,C.category_name,count(P.product_id) as Number_of_Products 
from products as P join categories as C
on P.category_id=C.category_id
group by P.category_id,C.category_name;

# 34 Calculate the average rating and the number of reviews for each product. 
# dataset :  products(product_id,product_name), Reviews(product_id,rating)

select P.product_name,avg(R.rating)as Average_Rating,
count(R.product_id) as Number_of_Reviews 
from products as P join reviews as R
on P.product_id=R.product_id
group by P.product_name;



# 35 Find Customers with the highest and lowest total order amounts. 
# Dataset: Customers(customer_id,customer_name),Orders(order_id,customer_id,order_amount) -----Very Difficult one 
with customerTotal as (
select C.customer_id,C.customer_name,sum(O.order_amount)as total_amount
from customers as C join orders as O
on C.customer_id=O.customer_id
group by C.customer_id,C.customer_name)
select * from customerTotal
where total_amount=(select max(total_amount) from customerTotal) 
or total_amount=(select min(total_amount)from customerTotal);



# 36  Get the maximum and minimum ages for each department.
# dataset: Employees(employee_id,employee_name,age,department)

select department,max(age)as max_age,min(age)as min_age 
from employees group by department;

#37 Calculate the total sales amount and the number of orders for each month.
# dataset : Orders(order_id,order_date,order_amount)

select monthname(order_date)as Months,
count(order_id) as Number_of_orders,
sum(order_amount) as Total_sales_amount 
from orders group by monthname(order_date);


# 38 Find the average price and the number of products for each supplier.
# dataset : products(product_id,product_name,price,supplier_id),
# Suppliers(supplier_id,supplier_name)

select S.supplier_name,avg(P.price) as Average_Price,
count(P.product_id) as Number_of_Products
from products as P join suppliers as S
on P.supplier_id=S.supplier_id
group by S.supplier_name;

# 39 Get the maximum and minimum prices for each product category. insuffiecient dataset
# Dataset : products(product_id,product_name,category_id,price),
# Categories(category_id,category_name)

select C.category_id,C.category_name,
max(P.price) as Max_Price, min(P.price) as Min_Price
from products as P join categories as C
on P.category_id=C.category_id
group by C.category_id,C.category_name;

# 40 Calculate the average rating and the number of reviews for each product category.
# dataset: products(product_id,product_name,category_id),Reviews(product_id,rating)

select P.category_id,count(P.product_id) as Number_of_reviews,
avg(R.rating) as Average_Rating_based_on_Product_Category
from products as P join reviews as R
on P.product_id=R.product_id
group by P.category_id;

# 41 Increase the salary of all employees by 10% .
# Dataset: Employees(employee_id,employee_name,salary)

update employees set salary=salary+(salary*0.1);


# 42 Delete all orders older than 1 year and their associated order items.
# dataset : Orders(order_id,order_date), Order_items(order_id,product_id,quantity)  need to ask sir

 # delete orders, order_items 
# from orders as O join order_items as OI 
# on  O.order_id=OI.order_id 
# where O.order_date > (now()- interval 1 year );


# 43 Insert a new category into the database and update all products of a specific category
# to the new category in single transaction.
# dataset : products(product_id,product_name,category_id),
# Categories(category_id,category_name)

start transaction;
use assignment;
insert into categories (category_id, category_name)
values (100, 'New Electronics');
update products SET category_id = 100 where category_id = 1;
commit;



# 44 update the discount percentage for all products in a specific price range.
# dataset : products(product_id,product_name,price,discount_percentage)

update products set discount_percentage=12 where price between 500 and 1000;

# 45 Delete all reviews with a rating lower than 3.
# dataset : Reviews(product_id,

delete from reviews where rating<3;

# 46 Insert a new customer into the database along with their associated orders and 
# order items in single transaction.
# Dataset :  Customers(customer_id,customer_name),Orders(order_id,customer_id,order_date),
## Order_items(order_id,product_id,quantity)

start transaction;
insert into Customers (customer_id,customer_name) values 
(33, 'Prashant Sonawane', 'Mumbai', 'India', 'Engineer');
insert into Orders (order_id,customer_id,order_date) values 
(39, 33, '2023-05-05', 240.00, 3);
insert into Order_Items (order_id,product_id,quantity) values 
(39, 1, 100);
commit;

# 47 Increase the salary of all employees in specific department by 15%.
# dataset: Employees(employee_id,employee_name,department)

update employees set salary=(salary+(salary*0.15))
where department="IT";

# 48 Delete all products that have not been ordered.
# Dataset :products(product_id,product_name),Order_items(order_id,product_id,quantity) need to ask sir 

delete P from products as P left join order_items as O 
on P.product_id=O.product_id where O.order_id is null; 

# 49 Insert a new supplier into the database along with their 
# associated products and ensure that all the records are inserted or none at all.
# Dataset : products(product_id,product_name,price,supplier_id),
# Suppliers(supplier_id,supplier_name)

start transaction;
use assignment;
insert into suppliers(supplier_id,supplier_name) values
(16,"Khushi Garments");
insert into products(product_id,product_name,supplier_id) values
(31,"Cotton",16),
(32,"Silk",16),
(33,"Lycra",16);
commit;


# 50 update the order dates for all orders placed on weekends to the following Monday.
# dataset : orders(order_id,order_date) need to ask sir 

select * from orders where dayname(order_date)="Sunday" or dayname(order_date)="Saturday";

select ("2023-01-15" + interval 1 day);
set autocommit = 0;
update orders set order_date=case 
when dayname(order_date)="Sunday" then order_date + interval 1 day
when dayname(order_date)="Saturday" then order_date + interval 2 day
end where dayname(order_date)="Sunday" or dayname(order_date)="Saturday";
# update orders set order_date=(order_date + interval 1 day) 
# where dayname(order_date)="Sunday";


# *DAY 6*
# 51. Create a view to display the total sales amount for each product.
# Dataset: Products (product_id, product_name), Order_Items (order_id, product_id, quantity, amount)

select P.product_name,sum(O.amount) as Total_Sales_Amount from Products as P join order_items as O 
on P.product_id=O.product_id 
group by P.product_name;

/*  CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `assignment`.`the total sales amount for each product` AS
    SELECT 
        `p`.`product_name` AS `product_name`,
        SUM(`o`.`amount`) AS `Total_Sales_Amount`
    FROM
        (`assignment`.`products` `p`
        JOIN `assignment`.`order_items` `o` ON ((`p`.`product_id` = `o`.`product_id`)))
    GROUP BY `p`.`product_name`
*/
# 52. Optimize a query that retrieves the order details for a specific customer, sorting them by the order date in descending order.
# Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id, order_date, order_amount)

select C.customer_id,O.order_id,O.order_date,O.order_amount 
from Customers as C join Orders as O
on O.customer_id=C.customer_id 
where C.customer_id=2 
order by order_date desc; 

# 53. Create an index on the "last_name" column of the "Employees" table and measure the performance improvement on a specific
# Dataset: Employees (employee_id, first_name, last_name, salary)

CREATE INDEX idx_last_name ON Employees(last_name);

# 54. Create a view to display the average rating and the number of reviews for each product.
# Dataset: Products (product_id, product_name), Reviews (product_id, rating)

select P.product_id,P.product_name,
avg(R.rating) as Average_rating , count(R.rating) as Number_of_Reviews
from products as P join Reviews as R 
on P.product_id=R.product_id
group by P.product_id,P.product_name;

select * from `average rating and the number of reviews for each product`;
/*
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `assignment`.`average rating and the number of reviews for each product` AS
    SELECT 
        `p`.`product_id` AS `product_id`,
        `p`.`product_name` AS `product_name`,
        AVG(`r`.`rating`) AS `Average_rating`,
        COUNT(`r`.`rating`) AS `Number_of_Reviews`
    FROM
        (`assignment`.`products` `p`
        JOIN `assignment`.`reviews` `r` ON ((`p`.`product_id` = `r`.`product_id`)))
    GROUP BY `p`.`product_id` , `p`.`product_name`
*/


# 55. Optimize a query that retrieves the top 10 customers with the highest total order amounts.
# Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id, order_amount)

select C.customer_id,C.customer_name, sum(O.order_amount)as Total_Order_Amount from Customers as C join Orders as O 
on C.customer_id= O.customer_id
group by C.customer_id,C.customer_name order by Total_Order_Amount desc limit 10;



# 56. Create an index on the "order_date" column of the "Orders" table and analyze the query performance for a specific date range.
# Dataset: Orders (order_id, order_date, order_amount)

CREATE INDEX idx_order_date ON Orders(order_date);

# 57. Create a view to display the average salary for each department.
# Dataset: Employees (employee_id, employee_name, salary, department)

select department, avg(salary) from employees
group by department;

select * from `average salary for each department`;

/*

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `assignment`.`average salary for each department` AS
    SELECT 
        `assignment`.`employees`.`department` AS `department`,
        AVG(`assignment`.`employees`.`salary`) AS `avg(salary)`
    FROM
        `assignment`.`employees`
    GROUP BY `assignment`.`employees`.`department`
*/



# 58. Optimize a query that retrieves the list of products with their respective categories, filtering them by a specific category.
# Dataset: Products (product_id, product_name, category_id),
# Categories (category_id, category_name)

select C.category_id,C.category_name,P.product_name from Products as P join Categories as C 
on P.category_id=C.category_id
group by C.category_id,C.category_name,P.product_name
having C.category_id=3;


# 59. Create an index on the "product_name" column of the "Products" table and analyze the query performance for a specific search term.
# Dataset: Products (product_id, product_name, category_id)

CREATE INDEX idx_product_name ON Products(product_name);

# 60. Create a view to display the total order amount for each customer.
# Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id, order_amount)

select C.customer_id,C.customer_name,sum(O.order_amount) as Total_Order_Amount from Customers as C join Orders as O 
on C.customer_id=O.customer_id
group by C.customer_id,C.customer_name;

select * from `total order amount for each customer`;

/*

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `assignment`.`total order amount for each customer` AS
    SELECT 
        `c`.`customer_id` AS `customer_id`,
        `c`.`customer_name` AS `customer_name`,
        SUM(`o`.`order_amount`) AS `Total_Order_Amount`
    FROM
        (`assignment`.`customers` `c`
        JOIN `assignment`.`orders` `o` ON ((`c`.`customer_id` = `o`.`customer_id`)))
    GROUP BY `c`.`customer_id` , `c`.`customer_name`

*/


#  *DAY 7*
# 61. Retrieve the top 3 customers based on their total order amounts, and calculate the percentage of each customer's order amount compared to the total.
# Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id, order_amount)




SELECT c.customer_id, c.customer_name, customer_total.total_order_amount,
(ROUND(100.0 * customer_total.total_order_amount / total_orders.total_amount, 2)) AS percentage_of_total
FROM Customers c JOIN ( SELECT customer_id, SUM(order_amount) AS total_order_amount FROM Orders
GROUP BY customer_id) AS customer_total ON c.customer_id = customer_total.customer_id
CROSS JOIN (SELECT SUM(order_amount) AS total_amount FROM Orders) AS total_orders
ORDER BY customer_total.total_order_amount DESC LIMIT 3;



# 62. Create a stored procedure to update the salary of an employee and log the change in a separate table.
# Dataset: Employees (employee_id, employee_name, salary), Salary_Log (log_id, employee_id, old _salary, new_salary, modified_date)

USE `assignment`;
DROP procedure IF EXISTS `Update_Salary`;

DELIMITER $$
USE `assignment`$$
CREATE PROCEDURE `Update_Salary` ( in new_sal decimal(10,2) ,in emp_id int)
BEGIN
	declare old_sal decimal(10,2);
    
    select salary into old_sal
    from employees where employee_id = emp_id;
    
    update employees set salary=new_sal
    where employee_id=emp_id;
    
    insert into salary_log (employee_id,old_salary,new_salary,modified_date) 
    values(emp_id,old_sal,new_sal,now());
    
END$$

DELIMITER ;
select * from employees;
call Update_Salary(10000,1);
select * from salary_log;

#63. Calculate the average rating for each product and assign a rank based on the rating using a window function.
#Dataset: Products (product_id, product_name), Ratings (product_id, rating)

SELECT
    p.product_id,
    p.product_name,
    AVG(r.rating) AS average_rating,
    RANK() OVER (ORDER BY AVG(r.rating) DESC) AS rating_rank
FROM
    Products p
JOIN
    Ratings r ON p.product_id = r.product_id
GROUP BY
    p.product_id, p.product_name;

#64. Implement a stored procedure to insert a new order along with its order items into the database.
#Dataset: Orders (order_id, order_date), Order_Items (order_id, product_id, quantity, amount)  need to ask Sir for more specific approach

DELIMITER $$

CREATE PROCEDURE InsertOrderWithItems (
    IN p_order_date DATE,
    IN p_product_ids JSON,     
    IN p_quantities JSON,      
    IN p_amounts JSON          
)
BEGIN
    DECLARE v_order_id INT;
    DECLARE i INT DEFAULT 0;
    DECLARE total_items INT;

 
    INSERT INTO Orders (order_date) VALUES (p_order_date);
    SET v_order_id = LAST_INSERT_ID();  
    
    
    SET total_items = JSON_LENGTH(p_product_ids);

    
    WHILE i < total_items DO
        INSERT INTO Order_Items (order_id, product_id, quantity, amount)
        VALUES (
            v_order_id,
            JSON_EXTRACT(p_product_ids, CONCAT('$[', i, ']')),
            JSON_EXTRACT(p_quantities, CONCAT('$[', i, ']')),
            JSON_EXTRACT(p_amounts, CONCAT('$[', i, ']'))
        );
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;


#65. Retrieve the top 5 products based on the cumulative sales amount using a window function.
#Dataset: Products (product_id, product_name), Order_Items (order_id, product_id, quantity, amount)

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.amount) AS total_sales,
    RANK() OVER (ORDER BY SUM(oi.amount) DESC) AS sales_rank
FROM
    Products p
JOIN
    Order_Items oi ON p.product_id = oi.product_id
GROUP BY
    p.product_id, p.product_name
ORDER BY
    total_sales DESC
LIMIT 5;

#66. Create a stored procedure to calculate the total order amount for a specific customer and return the result.
#Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id, order_amount)

USE `assignment`;
DROP procedure IF EXISTS `total_order_amount`;

DELIMITER $$
USE `assignment`$$
CREATE PROCEDURE `total_order_amount` (in c_id int)
BEGIN
select C.customer_id,C.customer_name,sum(O.order_amount) as Total_order_amount
from Customers as C join Orders as O
on C.customer_id=O.customer_id
group by 1,2 having  C.customer_id=c_id;
END$$

DELIMITER ;

call total_order_amount(2);

#67. Calculate the average rating for each product category and assign a rank based on the rating using a window function.
#Dataset: Products (product_id, product_name, category_id),
#Ratings (product_id, rating), Categories (category_id, category_name)

SELECT
    c.category_id,
    c.category_name,
    AVG(r.rating) AS average_rating,
    RANK() OVER (ORDER BY AVG(r.rating) DESC) AS rating_rank
FROM
    Categories c
JOIN
    Products p ON c.category_id = p.category_id
JOIN
    Ratings r ON p.product_id = r.product_id
GROUP BY
    c.category_id, c.category_name
ORDER BY
    rating_rank;

#68. Implement a stored procedure to delete a customer and all associated orders and order items from the database.
#Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id), Order_Items (order_id, product_id, quantity)
 DELIMITER $$

CREATE PROCEDURE DeleteCustomerAndOrders (
    IN p_customer_id INT
)
BEGIN
    -- Step 1: Delete order items associated with the customer's orders
    DELETE FROM Order_Items
    WHERE order_id IN (
        SELECT order_id FROM Orders WHERE customer_id = p_customer_id
    );

    -- Step 2: Delete orders of the customer
    DELETE FROM Orders
    WHERE customer_id = p_customer_id;

    -- Step 3: Delete the customer
    DELETE FROM Customers
    WHERE customer_id = p_customer_id;
END $$

DELIMITER ;


#69. Retrieve the top 3 employees based on their total sales amounts using a window function.
#Dataset: Employees (employee_id, employee_name), Orders (order_id, employee_id, order_amount)


WITH ranked_employees AS (
    SELECT
        e.employee_id,
        e.employee_name,
        SUM(o.order_amount) AS total_sales,
        RANK() OVER (ORDER BY SUM(o.order_amount) DESC) AS sales_rank
    FROM
        Employees e
    JOIN
        Orders o ON e.employee_id = o.employee_id
    GROUP BY
        e.employee_id, e.employee_name
)
SELECT *
FROM ranked_employees
WHERE sales_rank <= 3
ORDER BY sales_rank;




#70. Create a stored procedure to update the quantity in stock for a specific product and log the change in a separate table.
#Dataset: Products (product_id, product_name, quantity_in_stock), Stock_Log (log_id, product_id, old_quantity, new_quantity, modified_date)
USE `assignment`;
DROP procedure IF EXISTS `Update_stock_quantity`;

DELIMITER $$
USE `assignment`$$
CREATE PROCEDURE `Update_stock_quantity` (in p_id int,in p_quantity int )
BEGIN
	declare o_quantity int;
    select quantitiy_in_stock into o_quantity from products 
    where product_id=p_id;
    
    update products set quantitiy_in_stock=p_quantity
    where product_id=p_id;
    
    insert into stock_log (product_id,old_quantity,new_quantity,modified_date) values(p_id,o_quantity,p_quantity,now());
    
END$$

DELIMITER ;


call Update_stock_quantity(1,45);


select * from stock_log;



#71. Normalize the given unnormalized table into 3rd normal form (3NF).
#Dataset: Employees (employee_id, employee_name, department, city, country)

#72. Write a recursive SQL query to find all ancestors of a specific employee in a hierarchical employee table.
#Dataset: Employees (employee_id, employee_name, manager_id)

#73. Use advanced SQL techniques to pivot the given table and transform rows into columns.
#Dataset: Sales (product_id, month, amount)

#74. Design a database schema for a university system using entity-relationship modeling.
#Dataset: Students (student_id, student_name), Courses (course_id, course_name), Enrollments (enrollment_id, student_id, course_id)

#75. Write a recursive SQL query to find all dependent employees under a specific manager in a hierarchical organization structure.
#Dataset: Employees (employee_id, employee_name, manager_id)

#76. Use advanced SQL techniques to unpivot the given table and transform columns into rows.
#Dataset: Sales (product_id, month_amount, month2_amount, month3_amount)

#77. Design a database schema for an online marketplace using entity-relationship modeling.
#Dataset: Customers (customer_id, customer_name), Products (product_id, product_name), Orders (order_id, customer_id, product_id)

#78. Write a recursive SQL query to find all categories and their subcategories in a hierarchical category table.
#Dataset: Categories (category_id, category_name, parent_category_id)


#79. Use advanced SQL techniques to perform a cross join between two tables.
#Dataset: Table1 (column1), Table2 (column2)

#80. Design a database schema for a music streaming service using entity-relationship modeling.
#Dataset: Users (user_id, username), Songs (song_id, song_name),
#Playlists (playlist_id, user_id, song_id)


#81. Optimize a query that retrieves customer details along with their total order amounts for a specific date range.
#Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id, order_date, order_amount)

select C.customer_id,C.customer_name, sum(O.order_amount) as `Total order Amount` from customers as C join orders as O on C.customer_id=O.customer_id
group by C.customer_id,C.customer_name,O.order_date having O.order_date between '2023-01-05' and '2023-05-05';

#82. Identify and eliminate unnecessary joins in a query that retrieves product details and their corresponding categories.
#Dataset: Products (product_id, product_name, category_id),
#Categories (category_id, category_name)

SELECT
    p.product_id,
    p.product_name,
    c.category_name
FROM
    Products p
JOIN
    Categories c ON p.category_id = c.category_id;

#83. Rewrite a subquery as a join in a query that retrieves the order details along with the customer names for all orders.
#Dataset: Orders (order_id, customer_id, order_date), Customers (customer_id, customer_name)

SELECT
    o.order_id,
    o.order_date,
    c.customer_name
FROM
    Orders o
JOIN
    Customers c ON o.customer_id = c.customer_id;


#84. Optimize a query that calculates the average rating for each product by using appropriate indexes.
#Dataset: Products (product_id, product_name), Ratings (product_id, rating)

SELECT
    p.product_id,
    p.product_name,
    AVG(r.rating) AS average_rating
FROM
    Products p
JOIN
    Ratings r ON p.product_id = r.product_id
GROUP BY
    p.product_id, p.product_name;
    
    # use indexing the optimizing
    CREATE INDEX idx_ratings_product_id ON Ratings(product_id);
    CREATE INDEX idx_products_product_id ON Products(product_id);

#85. Identify and eliminate redundant joins in a query that retrieves employee details along with their department information.
#Dataset: Employees (employee_id, employee_name, department_id), Departments (department_id, department_name)

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name
FROM
    Employees e
JOIN
    Departments d ON e.department_id = d.department_id;

#86. Rewrite a subquery as a join in a query that retrieves the names of customers who have placed at least two orders.
#Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id)

SELECT DISTINCT c.customer_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) >= 2;


#87. Optimize a query that calculates the total sales amount for each month by using appropriate indexes.
#Dataset: Orders (order_id, order_date, order_amount)
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    SUM(order_amount) AS total_sales
FROM
    Orders
GROUP BY
    DATE_FORMAT(order_date, '%Y-%m')
ORDER BY
    order_month;
    
    CREATE INDEX idx_orders_date_amount ON Orders(order_date, order_amount);


#88. Identify and eliminate unnecessary joins in a query that retrieves product details and their corresponding suppliers' names.
#Dataset: Products (product_id, product_name, supplier_id),
#Suppliers (supplier_id, supplier_name)

SELECT
    p.product_id,
    p.product_name,
    s.supplier_name
FROM
    Products p
JOIN
    Suppliers s ON p.supplier_id = s.supplier_id;

#89. Rewrite a subquery as a join in a query that retrieves the names of customers who have placed orders in the past 30 days.
#Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id, order_date)

SELECT DISTINCT c.customer_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= CURRENT_DATE - INTERVAL 30 DAY;

#90. Optimize a query that retrieves the top 5 products with the highest sales amounts by using appropriate indexes.
#Dataset: Products (product_id, product_name), Order_Items (order_id, product_id, quantity, amount)
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.amount) AS total_sales
FROM
    Products p
JOIN
    Order_Items oi ON p.product_id = oi.product_id
GROUP BY
    p.product_id, p.product_name
ORDER BY
    total_sales DESC
LIMIT 5;

CREATE INDEX idx_order_items_product_id_amount ON Order_Items(product_id, amount);

CREATE INDEX idx_products_product_id ON Products(product_id);

#91. Write a recursive SQL query to find all categories and their subcategories in a hierarchical category table.
#Dataset: Categories (category_id, category_name, parent_category_id)



#92. Use a common table expression to calculate the running total of order amounts for each customer.
#Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id, order_amount)

WITH OrderTotals AS (
    SELECT 
        o.order_id,
        o.customer_id,
        c.customer_name,
        o.order_amount,
        SUM(o.order_amount) OVER (
            PARTITION BY o.customer_id 
            ORDER BY o.order_id
        ) AS running_total
    FROM 
        Orders o
    JOIN 
        Customers c ON o.customer_id = c.customer_id
)
SELECT * FROM OrderTotals;

#93. Apply window functions to calculate the average rating and the maximum rating for each product.
#Dataset: Products (product_id, product_name), Ratings (product_id, rating)

SELECT
    p.product_id,
    p.product_name,
    r.rating,
    AVG(r.rating) OVER (PARTITION BY p.product_id) AS average_rating,
    MAX(r.rating) OVER (PARTITION BY p.product_id) AS max_rating
FROM
    Products p
JOIN
    Ratings r ON p.product_id = r.product_id
ORDER BY
    p.product_id;

#94. Write a recursive SQL query to find all employees and their direct reports in a hierarchical employee table.
#Dataset: Employees (employee_id, employee_name, manager_id)

#95. Use a common table expression to calculate the cumulative sum of quantities for each product.
#Dataset: Products (product_id, product_name), Order_Items (order_id, product_id, quantity)
WITH ProductQuantities AS (
    SELECT
        oi.order_id,
        oi.product_id,
        p.product_name,
        oi.quantity
    FROM
        Order_Items oi
    JOIN
        Products p ON oi.product_id = p.product_id
)
SELECT
    order_id,
    product_id,
    product_name,
    quantity,
    SUM(quantity) OVER (
        PARTITION BY product_id
        ORDER BY order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_quantity
FROM
    ProductQuantities
ORDER BY
    product_id, order_id;

#96. Apply window functions to calculate the minimum and maximum order amounts for each month.
#Dataset: Orders (order_id, order_date, order_amount)
SELECT
    order_id,
    order_date,
    order_amount,
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,  -- For MySQL (use EXTRACT in others)
    MIN(order_amount) OVER (PARTITION BY DATE_FORMAT(order_date, '%Y-%m')) AS min_order_amount,
    MAX(order_amount) OVER (PARTITION BY DATE_FORMAT(order_date, '%Y-%m')) AS max_order_amount
FROM
    Orders
ORDER BY
    order_month, order_date;

#97. Write a recursive SQL query to find all ancestors of a specific employee in a hierarchical employee table.
#Dataset: Employees (employee_id, employee_name, manager_id)


#98. Use a common table expression to calculate the average rating and the number of reviews for each product.
#Dataset: Products (product_id, product_name), Reviews (product_id, rating)

with abs as
(select P.* from products as P join reviews as R 
on P.product_id=R.product_id)
select * from  abs as a;


#99. Apply window functions to calculate the rank and dense rank of sales amounts for each product.
#Dataset: Products (product_id, product_name), Order_Items (order_id, product_id, amount)

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.amount) AS total_sales,
    RANK() OVER (ORDER BY SUM(oi.amount) DESC) AS sales_rank,
    DENSE_RANK() OVER (ORDER BY SUM(oi.amount) DESC) AS dense_sales_rank
FROM
    Products p
JOIN
    Order_Items oi ON p.product_id = oi.product_id
GROUP BY
    p.product_id, p.product_name
ORDER BY
    total_sales DESC;

#100. Write a recursive SQL query to find all dependent employees under a specific manager in a hierarchical organization structure.
#Dataset: Employees (employee_id, employee_name, manager_id)
