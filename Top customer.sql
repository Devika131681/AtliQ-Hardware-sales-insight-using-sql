SELECT 
    Customer,
    CONCAT(ROUND(SUM(net_sale) / 10000000, 2), 'Cr') AS total_net_sale
FROM
    netsale_customer
WHERE
    fiscal_year = 2022 AND market = 'India'
GROUP BY customer
ORDER BY total_net_sale DESC
LIMIT 5;