CREATE TABLE superstore_train(
    row_id INTEGER,
    order_id VARCHAR(80),
    order_date TEXT,
    ship_date TEXT,
    ship_mode TEXT,
    customer_id VARCHAR(80),
    customer_name VARCHAR(80),
    segment VARCHAR(80),
    country VARCHAR(80),
    city VARCHAR,
    state VARCHAR(80),
    postal_code NUMERIC,
    region varchar(80),
    product_id TEXT,
    category VARCHAR(80),
    sub_category VARCHAR(80),
    product_name TEXT,
    sales numeric
);

-- importing dates could not happen by default so we do it
UPDATE superstore_train
SET order_date=TO_DATE(order_date, 'DD/MM/YYYY');

UPDATE superstore_train
SET ship_date=TO_DATE(ship_date, 'DD/MM/YYYY');

-- changing type of date columns
ALTER TABLE superstore_train
ALTER COLUMN order_date TYPE DATE
USING order_date::DATE;

ALTER TABLE superstore_train
ALTER COLUMN ship_date TYPE DATE
USING ship_date::DATE;

-- CHECKING TYPES
SELECT superstore_train.order_date, superstore_train.ship_date
FROM superstore_train
LIMIT 10;

-- Checking imported data
SELECT * FROM superstore_train;

-- Checking rows
SELECT COUNT(*) FROM superstore_train;
