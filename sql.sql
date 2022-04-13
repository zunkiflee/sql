--create table
 CREATE TABLE employee (
	id int UNIQUE, 
  	name text, 
  	department text,
  	position text,
  	salary real)

--Insert Data
INSERT INTO employee VALUES
	(1, 'David', 'Marketing', 'CEO', 100000),
	(2,'John','Marketing', 'VP',50000),
    (3,'Marry','Sales','Manager', 60000)
    
INSERT INTO employee VALUES
	(4, 'Max', 'Database', 'IT', 30000)

--select data
select 
	id,
    name, 
    salary
from employee

SELECT * from employee

--Transform Column
SELECT 
	name,
    salary,
    salary * 1.5 as newSalary,
    name || '@gmail.com' as email,
    lower(name) || '@gmail.com' as email,
    upper(name) || '@gmail.com' as email
from employee

--Filter data 
SELECT * from employee 
where department = 'Marketing' 
and salary > 30000

SELECT * from employee 
where department in ('Marketing', 'IT') 

SELECT * from employee 
where salary >= 50000

-- update data 
UPDATE employee 
set salary = 200000
where id = 2

--delete data 
DELETE from employee
where name = 'Max'
 
DELETE FROM employee
where id = 1

--SELECT * FROM MyEmployee
ALTER TABLE employee RENAME to myEmployee

alter table myEmployee
add email text 

UPDATE myEmployee 
set email = 'admin@company.com'

SELECT * from myEmployee

-- Copy and Drop Table
CREATE table myEmployee_backup as 
	SELECT * from myEmployee

drop TABLE myEmployee_backup

/* Filter  */
select 
	contactFirstName,
    addressLine1,
    city,
    country
from customers 
where country IN ('Norway', 'USA', 'Spain')

select 
	contactFirstName,
    addressLine1,
    city,
    country
from customers 
where country NOT IN ('Norway', 'USA', 'Spain')

select *
from customers
where customerNumber >= 100 and customerNumber <=130
order by customerNumber 

select *
from orders 
where orderDate between '2003-01-01' and '2003-12-31'

/*  Null  */
select *
from customers
where state is null

select *
from customers
where state is not null

/*  parttern matching  */
select 
	contactFirstName,
    contactLastName,
    phone
from customers
where contactFirstName like 'P%'

select 
	contactFirstName,
    contactLastName,
    phone
from customers
where phone like '%6'

/*  missing values  */
select
	state,
    coalesce(state, 'No State') as stateClean
from customers

select
	state,
    case when state is null then 'No State'
		else 'State'
	end as 'state_clean'
from customers

/*Aggregate Functions */
select 
    SUM(buyPrice) sum_price,
    AVG(buyPrice) avg_price,
    MIN(buyPrice) min_price,
    MAX(buyPrice) max_price
from products

/* นับจำนวน record*/
select 
   count(*),
   count(quantityInStock)
from products

/* นับจำนวน  distinct แบบไม่ซ้ำ*/
select 
   count(distinct customerNumber)
from customers

/*  group by  */
select 
	productName,
    count(*)
from products
group by productLine

select 
	country,
    count(*) as count_country
from customers
group by country

select 
	country,
    count(*) as count_country,
    city,
    count(*)
from customers
group by country, city

/*  having  */
select 
	a.productLine,
    count(*)
from productlines a, products b 
where a.productLine = b.productLine 
and a.productLine <> 'Motorcycles'
group by a.productLine
having count(*) > 10
order by count(*) desc

/*  order by  */
select 
	contactFirstName,
    addressLine1,
    city
from customers
order by city

/*  join  */
select 
	a.employeeNumber,
    a.firstName,
    a.officeCode,
	b.city,
	b.country
from employees a
join offices b
on a.officeCode = b.officeCode

select
	a.orderNumber,
    a.quantityOrdered,
    b.orderDate,
    c.amount
from orderdetails a, orders b, payments c
where a.orderNumber = b.orderNumber
and b.customerNumber = c.customerNumber
having a.orderNumber IN (10100, 10104)

select 
	a.employeeNumber,
    a.firstName,
    b.city 
from employees a 
join offices b 
on a.officeCode = b.officeCode 
where b.city LIKE '%P%'

/*   Convert WHERE to INNER JOIN  */
select 
	a.employeeNumber,
    a.firstName,
    b.city 
from employees a , offices b 
where a.officeCode = b.officeCode 
and b.city LIKE '%P%'

select 
	a.employeeNumber,
    a.firstName,
    b.city 
from employees a 
join offices b 
on a.officeCode = b.officeCode 
where b.city LIKE '%P%'

/*   Left Join  */
select *
from customers a 
left join employees b 
on a.salesRepEmployeeNumber = b.employeeNumber

/*   cross join  */
select * from customers 
cross join employees 
order by customerNumber