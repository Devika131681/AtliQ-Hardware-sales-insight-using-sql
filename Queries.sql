-- 1️⃣ Top 5 Customers in India by Net Sales for the year 2022
SELECT 
    customer,
    CONCAT(ROUND(SUM(net_sale) / 10000000, 2), ' Cr') AS total_net_sale
FROM
    netsale_customer
WHERE
    fiscal_year = 2022 
    AND market = 'India'
GROUP BY customer
ORDER BY total_net_sale DESC
LIMIT 5;


-- 2️⃣ Top Performing Channel in India for the year 2022
SELECT 
    channel,
    CONCAT(ROUND(SUM(net_sale) / 10000000, 2), ' Cr') AS total_net_sale
FROM
    netsale_customer
WHERE
    fiscal_year = 2022 
    AND market = 'India'
GROUP BY channel
ORDER BY SUM(net_sale) DESC
LIMIT 1;


-- 3️⃣ Net Sales by Product Segment in India for the year 2022
SELECT 
    p.segment,
    CONCAT(ROUND(SUM(n.net_sale) / 1000000, 1), ' lakh') AS net_sales
FROM
    netsale_customer n
JOIN 
    dim_product p ON n.product_code = p.product_code
WHERE
    n.market = 'India'
    AND n.fiscal_year = 2022
GROUP BY p.segment
ORDER BY SUM(n.net_sale) DESC;


-- 4️⃣ Top 5 Products in India by Net Sales for the year 2022
SELECT 
    p.product,
    CONCAT(ROUND(SUM(n.net_sale) / 1000000, 1), ' lakh') AS net_sales
FROM
    netsale_customer n
JOIN 
    dim_product p ON n.product_code = p.product_code
WHERE
    n.market = 'India'
    AND n.fiscal_year = 2022
GROUP BY p.product
ORDER BY SUM(n.net_sale) DESC
LIMIT 5;
