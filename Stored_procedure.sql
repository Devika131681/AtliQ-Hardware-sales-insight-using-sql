-- ------------------------------------------------------------
-- PROCEDURE 1: Get Top N Markets by Net Sales for a Fiscal Year
-- ------------------------------------------------------------

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_market_by_netsale`( 
    IN in_fiscal_year INT,         -- Fiscal year to filter sales (e.g., 2024)
    IN in_Top_n INT                -- Number of top markets to return (e.g., 5)
)
BEGIN
    -- If the top N input is invalid or null, default to 10
    IF in_Top_n IS NULL OR in_Top_n < 1 THEN
        SET in_Top_n = 10;
    END IF;

    -- Query to get top N markets based on total net sales (in millions)
    SELECT 
        market,
        ROUND(SUM(net_sale) / 1000000, 2) AS total_net_sales_million
    FROM
        netsale_customer
    WHERE
        fiscal_year = in_fiscal_year
    GROUP BY 
        market
    ORDER BY 
        total_net_sales_million DESC
    LIMIT 
        in_Top_n;
END$$

-- ------------------------------------------------------------
-- PROCEDURE 2: Get Top 5 Products by Category for India (FY 2024)
-- ------------------------------------------------------------

CREATE DEFINER=`root`@`localhost` PROCEDURE `top_product_by_category`(
    IN in_category CHAR(20)        -- Product category to filter (e.g., 'Laptop')
)
BEGIN
    -- Query to get top 5 selling products by net sale within a category for India in 2024
    SELECT 
        p.product,
        CONCAT(ROUND(SUM(n.net_sale) / 1000000, 1), ' lakh') AS net_sales
    FROM
        netsale_customer n
    JOIN
        dim_product p ON n.product_code = p.product_code
    WHERE
        n.market = 'India'
        AND n.fiscal_year = 2024
        AND p.category = in_category
    GROUP BY 
        p.product
    ORDER BY 
        SUM(n.net_sale) DESC
    LIMIT 5;
END$$

DELIMITER ;
