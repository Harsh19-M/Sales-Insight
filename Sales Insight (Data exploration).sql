/* THIS DATASET BELONGS TO A COMPANY IN INDIA AND WE WILL USE IT TO WRITE/EXPLORE/EXAMINE QUERIES ALSO WE'LL DO INR TO CAD ($) 
for our understanding */

SELECT count(*)
FROM sales.transactions
/* If we want to look at transactions where the sales amount is >0 
- so not in negatives basically then we can use the where clause/statement */
WHERE sales_amount > 1

/* If we want to look at the total amount of transactions - all transactions */
SELECT * 
FROM sales.transactions;

/* If we want to look at the total amount of Customers - all Customers */
SELECT count(*)
FROM sales.customers

/* If we only wanted to look at the transactions that took place in chennai - that's it then... */
SELECT*
FROM sales.transactions
WHERE market_code = 'Mark001'

SELECT *
FROM sales.transactions





/* AND if you wanted tot see the amount of transactions that happened only in Chennai */
SELECT count(*) 
FROM sales.transactions 
WHERE market_code = 'Mark001'

/* NOW if we want to Join the date table with the transactions table we can do so like this*/
/*This query below would would give us the join data (inner join) of date by date and it doe so by joining ON: date(from date table)
 and order_date (from transactions table) we can get the sales detail for each date. Also, if we wanted to find out the sales numbers
 for a specific year then we can do that as well using the WHERE clause/statement.*/ 
 
SELECT*
FROM sales.date
INNER JOIN sales.transactions ON 
date.date = transactions.order_date 
WHERE sales.date.year = '2020'


/* And now if we wanted to find out the total revenue? */

SELECT SUM(sales.transactions.sales_amount) as total_reveneue
FROM sales.transactions
INNER JOIN sales.date 
ON sales.transactions.order_date = sales.date.date 
WHERE sales.date.year = 2020;

/* And Now if we wanted to find the total revenue but only for Chennai */

Select*
From sales.transactions

Select SUM(transactions.sales_amount) as totalRevenueChennai
From sales.date 
Inner Join sales.transactions 
on date.date = transactions.order_date
Where sales.date.year = 2020 AND  sales.transactions.market_code = 'Mark001'


Select *
From sales.transactions


/* NOW if we wanted to know what these porducts are; from our sales from chennai, in 2020 we can do so 
by using DISTINCT */
/* What is SQL DISTINCT? The SQL DISTINCT keyword is used to retrieve unique values 
from a specified column or set of columns in a database table. 
It eliminates duplicate records, ensuring that only distinct, non-repeated values are returned.
*/

Select distinct product_code
From  sales.transactions
Where market_code = 'Mark001' 







