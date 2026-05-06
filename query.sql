/* =========================================================
   PROJECT: Supplement Sales Analytics using PostgreSQL
   AUTHOR : Sajlendra Pandey
   DATASET: Supplement Sales Data (2020–2025)
   ========================================================= */


/* =========================================================
   1. TABLE CREATION
   ========================================================= */

CREATE TABLE IF NOT EXISTS supplement_sales (
    date DATE,
    product_name VARCHAR(100),
    category VARCHAR(200),
    units_sold INT,
    price NUMERIC(10,2),
    revenue NUMERIC(12,2),
    discount NUMERIC(5,2),
    units_returned INT,
    location VARCHAR(200),
    platform VARCHAR(200)
);


/* =========================================================
   2. VIEW DATA
   ========================================================= */

SELECT *
FROM supplement_sales;


/* =========================================================
   3. KPI ANALYSIS
   ========================================================= */

-- Total Revenue
SELECT 
    SUM(revenue) AS total_revenue
FROM supplement_sales;


-- Total Units Sold
SELECT 
    SUM(units_sold) AS total_units_sold
FROM supplement_sales;


-- Total Returned Units
SELECT 
    SUM(units_returned) AS total_returns
FROM supplement_sales;


-- Average Product Price
SELECT 
    ROUND(AVG(price),2) AS avg_price
FROM supplement_sales;


/* =========================================================
   4. CATEGORY ANALYSIS
   ========================================================= */

-- Category Wise Revenue
SELECT 
    category,
    SUM(revenue) AS total_revenue
FROM supplement_sales
GROUP BY category
ORDER BY total_revenue DESC;


-- Top 5 Categories by Units Sold
SELECT 
    category,
    SUM(units_sold) AS total_units_sold
FROM supplement_sales
GROUP BY category
ORDER BY total_units_sold DESC
LIMIT 5;


/* =========================================================
   5. PRODUCT ANALYSIS
   ========================================================= */

-- Product with Highest Single Revenue
SELECT 
    product_name,
    revenue
FROM supplement_sales
WHERE revenue = (
    SELECT MAX(revenue)
    FROM supplement_sales
);


-- Top 5 Products by Total Revenue
SELECT 
    product_name,
    SUM(revenue) AS total_revenue
FROM supplement_sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 5;


-- Top 5 Products by Units Sold
SELECT 
    product_name,
    SUM(units_sold) AS total_units_sold
FROM supplement_sales
GROUP BY product_name
ORDER BY total_units_sold DESC
LIMIT 5;


/* =========================================================
   6. YEARLY SALES ANALYSIS
   ========================================================= */

-- Yearly Revenue
SELECT 
    EXTRACT(YEAR FROM date) AS year,
    SUM(revenue) AS total_revenue
FROM supplement_sales
GROUP BY year
ORDER BY year;


-- Top Products in 2020
SELECT 
    product_name,
    SUM(revenue) AS total_revenue
FROM supplement_sales
WHERE EXTRACT(YEAR FROM date) = 2020
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 5;


-- Top Products in 2021
SELECT 
    product_name,
    SUM(revenue) AS total_revenue
FROM supplement_sales
WHERE EXTRACT(YEAR FROM date) = 2021
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 5;


-- Top Products in 2022
SELECT 
    product_name,
    SUM(revenue) AS total_revenue
FROM supplement_sales
WHERE EXTRACT(YEAR FROM date) = 2022
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 5;


/* =========================================================
   7. LOCATION ANALYSIS
   ========================================================= */

-- Highest Revenue Generating Location
SELECT 
    location,
    SUM(revenue) AS total_revenue
FROM supplement_sales
GROUP BY location
ORDER BY total_revenue DESC
LIMIT 1;


-- Lowest Revenue Generating Location
SELECT 
    location,
    SUM(revenue) AS total_revenue
FROM supplement_sales
GROUP BY location
ORDER BY total_revenue
LIMIT 1;


-- Top 5 Locations by Revenue
SELECT 
    location,
    SUM(revenue) AS total_revenue
FROM supplement_sales
GROUP BY location
ORDER BY total_revenue DESC
LIMIT 5;


-- Top 5 Locations by Units Sold
SELECT 
    location,
    SUM(units_sold) AS total_units_sold
FROM supplement_sales
GROUP BY location
ORDER BY total_units_sold DESC
LIMIT 5;


-- Top Locations by Product Returns
SELECT 
    location,
    SUM(units_returned) AS total_returns
FROM supplement_sales
GROUP BY location
ORDER BY total_returns DESC
LIMIT 5;


/* =========================================================
   8. PLATFORM ANALYSIS
   ========================================================= */

-- Platform Wise Revenue
SELECT 
    platform,
    SUM(revenue) AS total_revenue
FROM supplement_sales
GROUP BY platform
ORDER BY total_revenue DESC;


/* =========================================================
   9. WINDOW FUNCTION ANALYSIS
   ========================================================= */

-- Running Revenue Total
SELECT 
    date,
    SUM(revenue) OVER (
        ORDER BY date
    ) AS cumulative_revenue
FROM supplement_sales;


-- Monthly Cumulative Revenue
SELECT 
    DATE_TRUNC('month', date) AS month,

    SUM(revenue) AS monthly_revenue,

    SUM(SUM(revenue)) OVER (
        ORDER BY DATE_TRUNC('month', date)
    ) AS cumulative_revenue

FROM supplement_sales
GROUP BY month
ORDER BY month;


-- Previous Revenue using LAG
SELECT 
    date,

    revenue AS current_revenue,

    LAG(revenue) OVER (
        ORDER BY date
    ) AS previous_revenue

FROM supplement_sales;


/* =========================================================
   10. MONTH-ON-MONTH GROWTH ANALYSIS
   ========================================================= */

SELECT 
    month,

    total_revenue,

    LAG(total_revenue) OVER (
        ORDER BY month
    ) AS previous_month_revenue,

    total_revenue -
    LAG(total_revenue) OVER (
        ORDER BY month
    ) AS revenue_growth

FROM (
    SELECT 
        DATE_TRUNC('month', date) AS month,

        SUM(revenue) AS total_revenue

    FROM supplement_sales
    GROUP BY month
) t;


-- Month-on-Month Growth Percentage
SELECT 
    month,

    total_revenue,

    LAG(total_revenue) OVER (
        ORDER BY month
    ) AS previous_month,

    ROUND(
        (
            (
                total_revenue -
                LAG(total_revenue) OVER (
                    ORDER BY month
                )
            )
            /
            LAG(total_revenue) OVER (
                ORDER BY month
            )
        ) * 100,
        2
    ) AS growth_percentage

FROM (
    SELECT 
        DATE_TRUNC('month', date) AS month,

        SUM(revenue) AS total_revenue

    FROM supplement_sales
    GROUP BY month
) t;


/* =========================================================
   11. TOP PRODUCTS IN EACH CATEGORY
   ========================================================= */

SELECT 
    category,
    product_name,
    total_revenue,
    rank_number

FROM (
    SELECT 
        category,

        product_name,

        SUM(revenue) AS total_revenue,

        RANK() OVER (
            PARTITION BY category
            ORDER BY SUM(revenue) DESC
        ) AS rank_number

    FROM supplement_sales
    GROUP BY category, product_name
) ranked_products

WHERE rank_number <= 3
ORDER BY category, rank_number;


/* =========================================================
   12. DISCOUNT IMPACT ANALYSIS
   ========================================================= */

SELECT 
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount < 0.05 THEN 'Low Discount'
        WHEN discount < 0.20 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_type,

    AVG(units_sold) AS avg_units_sold

FROM supplement_sales
GROUP BY discount_type;


/* =========================================================
   13. RETURN RATE ANALYSIS
   ========================================================= */

SELECT 
    product_name,

    ROUND(
        SUM(units_returned) * 100.0 /
        SUM(units_sold),
        2
    ) AS return_rate

FROM supplement_sales
GROUP BY product_name
ORDER BY return_rate DESC;


/* =========================================================
   14. SALES TREND ANALYSIS
   ========================================================= */

-- Peak Sales Day
SELECT 
    TO_CHAR(date, 'FMDay') AS day_name,

    SUM(revenue) AS total_revenue

FROM supplement_sales
GROUP BY TO_CHAR(date, 'FMDay')
ORDER BY total_revenue DESC;


/* =========================================================
   15. PRICE VS DEMAND ANALYSIS
   ========================================================= */

SELECT 
    category,

    CORR(price, units_sold) AS price_demand_correlation

FROM supplement_sales
GROUP BY category;


/* =========================================================
   16. TOP GROWING PRODUCTS
   ========================================================= */

SELECT 
    product_name,

    SUM(
        CASE
            WHEN EXTRACT(YEAR FROM date) = 2024
            THEN revenue
        END
    )

    -

    SUM(
        CASE
            WHEN EXTRACT(YEAR FROM date) = 2023
            THEN revenue
        END
    ) AS growth

FROM supplement_sales
GROUP BY product_name
ORDER BY growth DESC
LIMIT 5;


/* =========================================================
   17. CUSTOMER RETURN BEHAVIOR
   ========================================================= */

SELECT 
    CASE
        WHEN units_returned > 0
        THEN 'Returned'

        ELSE 'Not Returned'
    END AS customer_type,

    COUNT(*) AS total_orders

FROM supplement_sales
GROUP BY customer_type;
