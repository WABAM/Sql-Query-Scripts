-- Inspecting Data
select * from sales_data_analysis;

-- CHecking unique values
select distinct status from sales_data_analysis;  -- Nice one to plot
select distinct year_id from  sales_data_analysis;
select distinct PRODUCTLINE from sales_data_analysis; -- Nice to plot
select distinct COUNTRY from sales_data_analysis; -- Nice to plot
select distinct DEALSIZE from sales_data_analysis; -- Nice to plot
select distinct TERRITORY from sales_data_analysis;  -- Nice to plot

select distinct MONTH_ID from sales_data_analysis
where year_id = 2003;

-- ANALYSIS
--- Let's start by grouping sales by productline
select PRODUCTLINE, sum(sales) AS Revenue
from sales_data_analysis
group by PRODUCTLINE
order by Revenue desc;


select YEAR_ID, sum(sales) Revenue
from sales_data_analysis
group by YEAR_ID
order by revenue desc;

select  DEALSIZE,  sum(sales) AS Revenue
from sales_data_analysis
group by  DEALSIZE
order by Revenue desc;


--- What was the best month for sales in a specific year? How much was earned that month? 
select  MONTH_ID, sum(sales) AS Revenue, count(ORDERNUMBER) AS Frequency
from sales_data_analysis
where YEAR_ID = 2004 --  change year to see the rest
group by  MONTH_ID
order by Revenue desc;


-- November seems to be the month, what product do they sell in November, 
select  MONTH_ID, PRODUCTLINE, sum(sales) Revenue, count(ORDERNUMBER) As Frequency
from sales_data_analysis
where YEAR_ID = 2004 and MONTH_ID = 11 -- change year to see the rest
group by  MONTH_ID, PRODUCTLINE
order by Frequency desc;


---  Who is our best customer (this could be best answered with RFM)

;with rfm as
(
	select 
		CUSTOMERNAME, 
		sum(sales) As MonetaryValue,
		avg(sales) AS AvgMonetaryValue,
		count(ORDERNUMBER) As Frequency,
		max(ORDERDATE) AS last_order_date,
		(select max(ORDERDATE) from sales_data_analysis ) max_order_date,
		timestampdiff(DAY, max(ORDERDATE), (select max(ORDERDATE) from sales_data_analysis)) Recency
	from sales_data_analysis
	group by CUSTOMERNAME
),
rfm_calc as
(
   select r.*,
	    NTILE(4) OVER (order by Recency desc) rfm_recency,
		NTILE(4) OVER (order by Frequency) rfm_frequency,
		NTILE(4) OVER (order by MonetaryValue) rfm_monetary	
from rfm r
)
select c.*, rfm_recency+ rfm_frequency+ rfm_monetary as rfm_cell,
rfm_recency*100 + rfm_frequency*10 + rfm_monetary as rfm_combined

from rfm_calc c;

SELECT 
CUSTOMERNAME,
rfm_recency,
rfm_frequency,
rfm_monetary,
rfm_recency || rfm_frequency || rfm_monetary AS rfm_cell,
case 
		when rfm_cell_string in (111, 112 , 121, 122, 123, 132, 211, 212, 114, 141) then 'lost_customers'  -- lost customers
		when rfm_cell_string in (133, 134, 143, 244, 334, 343, 344, 144) then 'slipping away, cannot lose' -- (Big spenders who haven’t purchased lately) slipping away
		when rfm_cell_string in (311, 411, 331) then 'new customers'
		when rfm_cell_string in (222, 223, 233, 322) then 'potential churners'
		when rfm_cell_string in (323, 333,321, 422, 332, 432) then 'active' -- (Customers who buy often & recently, but at low price points)
		when rfm_cell_string in (433, 434, 443, 444) then 'loyal'
END AS 'rfm_segment'

FROM
( 
SELECT
         CUSTOMERNAME, 
		sum(sales) As MonetaryValue,
		avg(sales) AS AvgMonetaryValue,
		count(ORDERNUMBER) As Frequency,
		max(ORDERDATE) AS last_order_date,
		(select max(ORDERDATE) from sales_data_analysis ) max_order_date,
		timestampdiff(DAY, max(ORDERDATE), (select max(ORDERDATE) from sales_data_analysis)) Recency
	from sales_data_analysis
	group by CUSTOMERNAME
),

(
   select r.*,
	    NTILE(4) OVER (order by Recency desc) rfm_recency,
		NTILE(4) OVER (order by Frequency) rfm_frequency,
		NTILE(4) OVER (order by MonetaryValue) rfm_monetary	
from
(
SELECT
CUSTOMERNAME, 
		sum(sales) As MonetaryValue,
		avg(sales) AS AvgMonetaryValue,
		count(ORDERNUMBER) As Frequency,
		max(ORDERDATE) AS last_order_date,
		(select max(ORDERDATE) from sales_data_analysis ) max_order_date,
		timestampdiff(DAY, max(ORDERDATE), (select max(ORDERDATE) from sales_data_analysis)) Recency
	from sales_data_analysis
	group by CUSTOMERNAME,

(
    select c.*, rfm_recency+ rfm_frequency+ rfm_monetary as rfm_cell,
    rfm_recency*100 + rfm_frequency*10 + rfm_monetary as rfm_combined

from
(
SELECT
CUSTOMERNAME, 
		sum(sales) As MonetaryValue,
		avg(sales) AS AvgMonetaryValue,
		count(ORDERNUMBER) As Frequency,
		max(ORDERDATE) AS last_order_date,
		(select max(ORDERDATE) from sales_data_analysis ) max_order_date,
		timestampdiff(DAY, max(ORDERDATE), (select max(ORDERDATE) from sales_data_analysis)) Recency
	from sales_data_analysis
	group by CUSTOMERNAME,

(
    select r.*,
	    NTILE(4) OVER (order by Recency desc) rfm_recency,
		NTILE(4) OVER (order by Frequency) rfm_frequency,
		NTILE(4) OVER (order by MonetaryValue) rfm_monetary
)





