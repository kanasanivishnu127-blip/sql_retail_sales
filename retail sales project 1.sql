DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

select * from retail_sales
limit 10


select * from retail_sales 
where quantity is null

delete from retail_sales 
where quantity is null 

select count(*)
from retail_sales 

select count(distinct customer_id)
from retail_sales

select distinct category
from retail_sales

--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05

select *
from retail_sales 
where sale_date = '2022-11-05'

--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
the quantity sold is more than 4 in the month of Nov-2022

select *
from retail_sales
where category ='Clothing'
and 
  to_char(sale_date,'yyyy-mm')='2022-11'
and quantity >=4


3.Write a SQL query to calculate the total sales (total_sale) for each category

select category,sum(total_sale)
from retail_sales
group by category

4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:


select round(avg(age),2)
from retail_sales
where category ='Beauty'


5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select *
from retail_sales
where total_sale >1000

6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select gender ,category,count(total_sale)
from retail_sales
group by gender,category


7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select *
from(
select extract(year from sale_date)as year,
   extract(month from sale_date) as month,avg(total_sale),
   rank()over(partition by extract(year from sale_date) order by avg(total_sale)desc ) as rn
from retail_sales
group by 1,2
) t
where rn=1

8.**Write a SQL query to find the top 5 customers based on the highest total sales **:


select  *
from(
select  customer_id,sum(total_sale),
 dense_rank() over(order by sum(total_sale)desc) as rn
 from retail_sales
group by 1
) t
where rn<=5

or

 select customer_id,sum(total_sale)
 from retail_sales
 group by customer_id
 order by 2 desc
 limit 5

9.**Write a SQL query to find the top 5 customers based on the highest total sales **:
 
select category,count(distinct customer_id)
from retail_sales
group by 1

10.Write a SQL query to create each shift and number of orders (Example Morning <12,
Afternoon Between 12 & 17, Evening >17):


with hourly_sales as
(
select *,
      case when extract(hour from sale_time)<12 then 'Morning'
	        when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
			else 'evening'
			end as shift
from retail_sales
)
select shift,count(transaction_id)
from hourly_sales
group by shift





