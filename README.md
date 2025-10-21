
# Sales Insights Case Study – AtliQ Hardware
**A Data-Driven Sales Performance Dashboard built using SQL and Power BI**

## Executive Summary:

**Company**: AtliQ Hardware <br>
**Industry**: Computer Hardware & Peripherals<br>
**Head Office**: Delhi, India<br>
**Key Stakeholder**: Bhavin Patel, Sales Director<br>

Using SQL and Power BI, this project builds an interactive sales dashboard for AtliQ Hardware — a computer hardware manufacturer facing fragmented, unreliable sales reports. The dashboard consolidates sales data from multiple sources to help the Sales Director, Bhavin Patel, easily track key KPIs, identify performance trends, and make faster, 
data-driven decisions.

Key Outcomes:

* Centralized, accurate view of company-wide sales performance
* Automated reporting with real-time insights
* Improved sales visibility and data-driven decision-making


## Business Problem:

Context:
AtliQ Hardware supplies computer components and peripherals to major retail clients across India. As the market expands rapidly, the company struggles to track and analyze 
sales performance effectively across its regional divisions (North, South, and Central India).

Problem Statement:
Bhavin Patel lacks centralized visibility into AtliQ’s sales performance. Fragmented Excel files and inconsistent manual reporting from regional managers prevent timely and 
reliable business insights.


Key Challenges:
1. Lack of Data-Backed Insights: No single source of truth for performance by region, customer, or product category.
2. Inefficient Reporting: Manual Excel reports and verbal updates delay decision-making.
3. Sales Decline Despite Market Growth: Missed opportunities due to poor visibility and unstructured data.


## Methodology:

Framework Used: AIMS Grid *(Assumptions | Information | Methodology | Solutions)*

 1. Purpose:
 Define a structured plan to solve AtliQ’s reporting challenges by creating a unified, data-driven dashboard for real-time sales visibility and faster decision-making.

2. Stakeholders:
 Sales & Marketing Teams, IT Department (Falcons), Data Analytics Team (Data Masters).

3. End Result:
 A Power BI dashboard directly connected to AtliQ’s SQL sales database, consolidating regional performance data into a single interactive view.

4. Success Criteria:
 Reduced manual reporting time and cost, improved accessibility of sales insights, and a measurable uplift in data-driven strategic decisions.


Imported the AtliQ Hardware dataset consisting of 5 tables - Products, Date, Transactions, Customers, Markets:
Wrote SQL Queries (In MySQL DB) to gather sales insight about AtliQ Hardware:

****My SQL:****
select* from sales.customers; select* from sales.date; select* from sales.markets; select* from sales.products; select* from sales.transactions;

/*1) First and Foremost we wanted to know how many transcations took place - Like In Total - so we can use the .count()*/
select count(sales_qty) as "Total Transactions"
from sales.transactions;
/*Or could have even simply done THIS:*/
select count(*) as "Total Transactions"
from sales.transactions;
/*So from either one of our query (whichever one we want to use) we can conclude |Total Transactions were = 150283| */


/*2) No. of Total Records from the Customers Table:  */
select count(*) as "Number of Total Records (Customers)"
from sales.customers;
/*OR*/
select count(customer_code) as "Number of Total Records (Customers)"
from sales.customers;
/*So we can see that the Total Number of Customers in record = 38 */


/*3) We want to see Transactions only from Chennai*/
select* from sales.markets; /*Running this query must give us details about the Markets - Areas of Business*/
/*So we know now that markets_name - Chennai is associated with markets_code = Mark001 */
select* from sales.transactions;

/*So lets run our Analysis Query to find more about the transactions in Chennai*/
select*
from sales.transactions as T
join sales.markets as M on T.market_code = M.markets_code
where markets_code = 'Mark001';

/*OR could have simply done - no need for a join - but using a join gives us more info from both transactions and Markets*/
select*
from sales.transactions
where market_code = "Mark001";

/*If we wanted the total number Transactions in chennai then we do this: */

select count(*) as "Total Transactions in Chennai"
from sales.transactions
where market_code = 'Mark001';


/*4) Now we want to know within the transactions - How many transactions have happened using USD currency*/
select*
from sales.transactions 
where currency = "USD";
/*So we know the details of the 2 transactions that took place in USD currency*/
/*AND if we strictly are looking for only the count - as in how many in total then we simply do this: */
select count(*) as "Total Number of Transactions using USD currency"
from sales.transactions
where currency = "USD";


/*5) Show Transactions only in 2020 joined with the date table*/

select* from sales.date; select* from sales.transactions;

select*
from sales.transactions as T
inner join sales.date as D on D.date = T.order_date
where D.year = 2020;

/*AND if we only want a count of how many total transactions took place only in the year 2020*/

select count(*) as "Total Transactions in Year 2020"
from sales.transactions as T 
inner join sales.date as D on D.date = T.order_date
where D.year = 2020;
/*SO WE can see that total of '21550' transactions have took place in the year of 2020*/


/*6) We want to know total Revenue Generated only in the year 2020*/

select sum(T.sales_amount) as "Total Revenue in 2020"
from sales.transactions as T
join sales.date as D on D.date = T.order_date
where D.year = 2020;

/*SO we know now that Total Revenue genereated in the year 2020 is = '142235559' INR - in Indian Rupees*/

/*Also the same thing we can do for the year 2019 or 2018*/
select sum(T.sales_amount) as "Total Revenue 2019"
from sales.transactions as T
join sales.date as D on D.date = T.order_date
where D.year = 2019 and T.currency = "INR";

select sum(T.sales_amount) as "Total Revenue 2018"
from sales.transactions as T
join sales.date as D on D.date = T.order_date
where D.year = 2018 and T.currency = "INR";
/*SO we can see that Total Revenue (sales) have dropped from the year 2018 = '621 779' INR to 2019 = '433 012' INR */


/* 7) We want to know the Total Revenue Generated only from/in Chennai in the year 2020 */
select sum(T.sales_amount) as "Total Transactions - Chennai (2020)"
from sales.transactions as T
join sales.markets as M on M.markets_code = T.market_code
join sales.date as D on D.date = T.order_date 
where markets_code = 'Mark001' and year = 2020;
/* Total Transactions - Chennai (2020) = '2463024' */


/*8) Distinct Products sold in Chennai and we want it to be by most sold product to least sold*/
select P.product_code, M.markets_code, M.markets_name, P.product_type, sum(T.sales_amount) as "Total Sales"
from sales.transactions as T
join sales.products as P on P.product_code = T.product_code
join sales.markets as M on M.markets_code = T.market_code
where M.markets_code = "Mark001" 
group by P.product_code, P.product_type, M.markets_code
order by sum(T.sales_amount) desc;


/* 9) Finding our top 5 most Profitable Markets*/
select  markets_name, sum(sales_amount) as "Total Sales"
from sales.transactions as T
join sales.markets as M on T.market_code = M.markets_code
group by T.market_code 
order by sum(sales_qty) desc
limit 5;
/*So our Top 5 Most Profitable Markets (in INR Currency) are: 
markets_name Total Sales
Delhi NCR	520721134
Mumbai	150180636
Nagpur	55026321
Kochi	18813466
Ahmedabad	132526737
*/


/*10) 5 of The Least Profitable Markets (in INR)*/
select M.markets_name, sum(T.sales_amount) as "Total Sales"
from sales.transactions as T
join sales.markets as M on M.markets_code = T.market_code
group by T.market_code 
order by sum(T.sales_amount) asc
limit 5;
/* 5 of The Least Profitable Markets (in INR) are: 
markets_name Total Sales
Bengaluru	373115
Bhubaneshwar	893857
Surat	2605796
Lucknow	3094007
Patna	4428393
*/

After we wrote some My SQL queries to draw some preliminary sales insight about AtliQ Hardware we moved onto importing the data withing Power BI: 

****Power BI:****
Establishing relations/relationship between the 5 tables within the sales schema (Dataset for AtliQ Hardware) - The Tables are organized in a Star Schema: <br>
So from using MySQL and joining the tables on the same Keys - we knew that all 4 tables have a relation with the transactions table and so when I imported the dataset 
(all 5 tables) within Power BI - in Model View - the relation between Product and transactions (on Product code) was already made, Customers and Transactions (on Customer code) was already made but the relation between date table and transactions table, markets table and Transactions table were not made (perhaps because it was markets_code in market table and market_code in transactions table) and with the date table and transactions table I knew (through using MySQL Joins) that the date and order_date are the same but I had to manully build the connections in Power BI for both of these (market-transactions and date-transactions).

<br><img width="626" height="303" alt="image" src="https://github.com/user-attachments/assets/b6ed9d0b-4000-4b20-90b2-3b7b7d58fcf6" />


**Approach**

1. **Data Extraction (SQL):**
   - Collected and merged multiple Excel datasets.
   - Used SQL queries to clean, aggregate, and transform raw data.

2. **Data Modeling (Power BI):**
   - Established relationships between sales, customers, and products tables.
   - Created calculated columns and measures for KPIs.
   
3. **Visualization:**
   - Built an interactive Power BI dashboard for dynamic exploration and insights.

**Data Flow:**
Raw Excel Files ➜ SQL Cleaning & Joins ➜ Clean Dataset ➜ Power BI Dashboard


## Skills:

* SQL: Joins, aggregate functions, CASE statements, window functions (if applicable)
* Power BI: DAX, data modeling, measures, calculated columns, and dynamic dashboards 
* Data Analysis: Cleaning, transformation, KPI design, trend analysis, storytelling


## Results & Business Recommendations:

*(Placeholder – to be filled once analysis & dashboard visuals are finalized)*

**Results:**
 
* Identified top-performing regions and customers
* Highlighted areas of revenue decline and underperforming products
* Delivered clear insights for strategic decision-making

**Recommendations:**

* Focus marketing and promotions on weak regions
* Re-evaluate low-performing products
* Automate monthly sales reports for consistent updates

(Insert visuals or screenshots from Power BI dashboard here once ready)


## Next Steps:

- Integrate additional KPIs (e.g., profit margins, customer retention)
- Automate data refreshes using SQL and Power BI scheduling
- Address data limitations and ensure completeness
- Explore predictive modeling for sales forecasting
- Expand dashboard access across departments for unified reporting
