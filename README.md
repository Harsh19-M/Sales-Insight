
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


## Data Exploration & Modeling

### **SQL Data Exploration (MySQL)** 

I used Basic MySQL queries to analyze sales Transaction Details, Customer segments, Growth rates, and Profitable Markets etc. Below are some of the key queries — the rest are documented in the attached SQL file.

These queries formed the foundation for modeling and dashboarding later in Power BI, ensuring accurate metrics validation and clean relationships between dimension and fact tables.

<details> <summary><b>Key SQL Queries & Insights (Click to Expand)</b></summary>


Used SQL to explore and extract sales insights from AtliQ Hardware’s sales database, consisting of **5 tables**:
`Products`, `Date`, `Transactions`, `Customers`, and `Markets`.

#### **Transactions using USD Currency**

**Performed basic validation queries (e.g., checking for multi-currency transactions) to ensure data consistency before proceeding with sales and market analysis.**

```
  select*
  from sales.transactions 
  where currency = "USD";
```

*Result:* **Transaction details using USD currency**

****AND Count of How many in total (using USD)****

```
  select count(*) as "Total Number of Transactions using USD currency"
  from sales.transactions
  where currency = "USD";
```

*Result:* **2 transactions in USD**


#### **Total Revenue (Jan–Jun 2020) vs. Previous Years**
   
  ```
  select*, T.sales_amount as "Total Revenue up till June 2020"
  from sales.transactions as T
  inner join sales.date as D on D.date = T.order_date
  where D.year = 2020 and T.currency = "INR";
```
```
  select sum(T.sales_amount) as "Total Revenue 2019"
  from sales.transactions as T
  inner join sales.date as D on D.date = T.order_date
  where D.year = 2019 and T.currency = "INR";
```
```
  select sum(T.sales_amount) as "Total Revenue 2018"
  from sales.transactions as T
  inner join sales.date as D on D.date = T.order_date
  where D.year = 2018 and T.currency = "INR";
```
```
  select sum(T.sales_amount) as "Total Revenue 2017"
  from sales.transactions as T
  inner join sales.date as D on D.date = T.order_date
  where D.year = 2017 and T.currency = "INR";
```
   *Results:*
   * **2020:** `₹11,014`
   * **2019:** `₹433,012`
   * **2018:** `₹621,779`
   * **2017:** `₹685,749`
     
   *Insight:* **(Revenue trend shows decline year-over-year.)**
   

#### **Top 5 Most Profitable Markets**
```
  select  markets_name, sum(sales_amount) as "Total Sales"
  from sales.transactions as T
  join sales.markets as M on T.market_code = M.markets_code
  group by T.market_code 
  order by sum(sales_qty) desc
  limit 5;
```
*Results:*
   * Delhi NCR – `₹520,721,134`
   * Mumbai – `₹150,180,636`
   * Nagpur – `₹55,026,321`
   * Kochi – `₹18,813,466`
   * Ahmedabad – `₹13,252,673`
     

#### **Bottom 5 Least Profitable Markets**
```
  select M.markets_name, sum(T.sales_amount) as "Total Sales"
  from sales.transactions as T
  join sales.markets as M on M.markets_code = T.market_code
  group by T.market_code 
  order by sum(T.sales_amount) asc
  limit 5;
```
*Results:*
   * Bengaluru	– `₹373,115`
   * Bhubaneshwar	– `₹893,857`
   * Surat	– `₹2,605,796`
   * Lucknow	– `₹3,094,007`
   * Patna	– `₹4,428,393`

These SQL queries served as preliminary data exploration steps to validate joins, assess data quality, and gain a basic understanding of key business metrics prior to performing deeper analysis, transformation and visualization in Power BI.

</details>


### **Power BI Data Modeling**

After generating SQL insights, the dataset was imported into **Power BI** for visualization and relationship modeling.

**Steps Taken:**

* Imported all 5 tables into Power BI: `Products`, `Customers`, `Markets`, `Date`, `Transactions`.
* Organized tables in a **Star Schema** — with `Transactions` as the **Fact Table**.
* **Automatic Relationships:**

  * `Products` ↔ `Transactions` (via `product_code`)
  * `Customers` ↔ `Transactions` (via `customer_code`)
    
* **Manual Relationships (created in Model View):**

  * `Markets` ↔ `Transactions` (`markets_code` ↔ `market_code`)
  * `Date` ↔ `Transactions` (`date` ↔ `order_date`)

This ensured proper relational integrity for building measures, aggregations, and visualizations.

**Star Schema:**
<br><img width="626" height="303" alt="image" src="https://github.com/user-attachments/assets/b6ed9d0b-4000-4b20-90b2-3b7b7d58fcf6" />

<br>

**Further Querying revelead:**

<br><img width="752" height="206" alt="image" src="https://github.com/user-attachments/assets/bc9b3eae-c5cb-4bc5-9862-9eef66561a36" />


So I concluded that it would be beneficial/logical to keep both INR\r and USD\r currency values in our dashboard built in Power BI <br>
**NOTE: "INR\r" and "USD\r" in SQL Queries are same as"INR#(cr)" and "USD#(cr)" in Power BI formulas**

- There were Duplicate Records - 1 and 1 duplicate of 2 other transactions in USD - so we must filter thoses ones out.
- INR\r and USD\r | INR#(cr)" and "USD#(cr) - are the ones we will keep in Power BI and I'll keep in Power BI and cleanup the others INR and USD 
- Removing/Cleaning out those sales_amount values that are less than equal to 0. Not replacing them with the mean value. Simply removing them.
  
<br>

**Final Currency values being used:** <br>
`
= Table.SelectRows(#"Removing - values <= 0", each ([currency] = "INR#(cr)" or [currency] = "USD#(cr)"))
`
<br>

<br>

**The Normalized values for the USD currency to INR (as of 2020 - last updated) would be:** <br>
`
= Table.AddColumn(#"Cleanup currency", "Norm_sales_amount", each if [currency] = "USD#(cr)" then [sales_amount]*75.63 else[sales_amount])
`
<br>
<br>

**It was a conscious choice to keep the currency conversion rate (sales_amount*75.63) not changing according to currency rate of 2017, 2018, and 2019.**
<br>


Before (Only 2 changed - but total of 4 exist)
<img width="959" height="443" alt="image" src="https://github.com/user-attachments/assets/58e497bf-52d6-42c5-940f-7c51c6508576" />

After (all 4 total have changed)
<img width="956" height="473" alt="image" src="https://github.com/user-attachments/assets/ede9c2a7-0727-4d97-a978-05a834faac87" />


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
