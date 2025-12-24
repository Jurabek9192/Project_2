-- Checking for NULL values
-- Поиск пропущенных знычений

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

-- 11 postal codes are NULL, but we do not use them, so they can be left empty
-- 11 почтовых индексов пустые, но мы их не используем, поэтому их можно оставить пустыми

-- Sales can not be less than zero, so we check for negative values
-- Продажи не могут быть меньше нулю, поэтому проверяем данные

SELECT
    COUNT(*) FILTER ( WHERE sales<0 )
FROM superstore_train;

-- Checking for duplicate records to ensure data quality
-- Также необходимо проверить дубликаты

SELECT
    order_id,
    product_id,
    sales,
    order_date,
    COUNT(*) AS order_duplicate
FROM superstore_train s
GROUP BY order_id, product_id, sales, order_date
HAVING COUNT(*)>1;

-- Duplicates were found, so we will check again
-- Обнаружены дубликаты, поэтому выполняем повторную проверку

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
-- Были выявлены два полностью идентичных транзакционных записи
-- на уровне позиции и удалены для обеспечения точных
-- расчётов частоты и выручки.

DELETE FROM superstore_train WHERE row_id=3407;
