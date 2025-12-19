-- FINDING NULLS

SELECT
    COUNT(*) FILTER ( WHERE s.customer_id IS NULL ) AS null_customer_id,
    COUNT(*) FILTER ( WHERE s.order_id IS NULL ) AS null_order_id,
    COUNT(*) FILTER ( WHERE s.order_date IS NULL ) AS null_order_date,
    COUNT(*) FILTER ( WHERE s.ship_date IS NULL ) AS null_ship_date,
    COUNT(*) FILTER ( WHERE s.customer_id IS NULL ) AS null_customer_id,
    COUNT(*) FILTER ( WHERE s.customer_name IS NULL ) AS null_customer_name,
    COUNT(*) FILTER ( WHERE s.segment IS NULL ) AS null_segment,
    COUNT(*) FILTER ( WHERE s.country IS NULL ) AS null_country,
    COUNT(*) FILTER ( WHERE s.city IS NULL ) AS null_city,
    COUNT(*) FILTER ( WHERE s.state IS NULL ) AS null_state,
    COUNT(*) FILTER ( WHERE s.postal_code IS NULL ) AS null_postal_code,
    COUNT(*) FILTER ( WHERE s.region IS NULL ) AS null_region,
    COUNT(*) FILTER ( WHERE s.product_id IS NULL ) AS null_product_id,
    COUNT(*) FILTER ( WHERE s.category IS NULL ) AS null_category,
    COUNT(*) FILTER ( WHERE s.sub_category IS NULL ) AS null_sub_category,
    COUNT(*) FILTER ( WHERE s.product_name IS NULL ) AS null_product_name,
    COUNT(*) FILTER ( WHERE s.sales IS NULL ) AS null_sales
FROM superstore_train s ;

-- There are 11 postal codes are null but we do not use postal code so it can be left empty

-- Finding Problems
SELECT
    COUNT(*) FILTER ( WHERE sales<0 )
FROM superstore_train;

-- FINDING DUPLICATES

SELECT
    order_id,
    product_id,
    sales,
    order_date,
    COUNT(*) AS order_duplicate
FROM superstore_train s
GROUP BY order_id, product_id, sales, order_date
HAVING COUNT(*)>1;

-- We found duplicate so we will check once again

SELECT *
FROM superstore_train
WHERE (order_id, product_id, sales, order_date) IN (
    SELECT order_id, product_id, sales, order_date
    FROM superstore_train
    GROUP BY order_id, product_id, sales, order_date
    HAVING COUNT(*)>1
    )
ORDER BY order_id;

-- Two exact duplicate transaction records were identified
-- at the line-item level and removed to ensure accurate
-- frequency and revenue calculations.
DELETE FROM superstore_train WHERE row_id=3407;