CREATE DEFINER=`root`@`localhost` PROCEDURE `top_product_by_category`(in_category CHAR(20))
BEGIN
SELECT 
    p.product,
    concat(round(sum(n.net_sale)/1000000,1),"lakh") as net_sales
FROM
    netsale_customer n
        JOIN
    dim_product p ON n.product_code = p.product_code
WHERE
    n.market = 'India'
        AND 
	n.fiscal_year = '2022'
	    AND 
	p.category=in_category
Group by p.product
order by sum(n.net_sale) desc
limit 5;
End