SELECT 
    p.segment,
    concat(round(sum(n.net_sale)/1000000,1),"lakh") as net_sales
FROM
    netsale_customer n
        JOIN
    dim_product p ON n.product_code = p.product_code
WHERE
    n.market = 'India'
        AND 
	n.fiscal_year = '2022'
Group by p.segment
order by sum(n.net_sale) desc
