-- get_top_n_market_by_netsale.sql
-- Purpose: Returns top N markets by net sales for a given fiscal year
-- Author: Devika 

DELIMITER $$

CREATE PROCEDURE get_top_n_market_by_netsale( 
    IN in_fiscal_year INT,
    IN in_top_n INT
)
BEGIN
    IF in_top_n IS NULL OR in_top_n < 1 THEN
        SET in_top_n = 10; -- Default value if invalid input
    END IF;

    SELECT 
        ROUND(SUM(net_sale / 1000000), 2) AS total_net_sales_million,
        market
    FROM
        netsale_customer
    WHERE
        fiscal_year = in_fiscal_year
    GROUP BY 
        market
    ORDER BY 
        total_net_sales_million DESC
    LIMIT in_top_n;
END$$

DELIMITER ;
