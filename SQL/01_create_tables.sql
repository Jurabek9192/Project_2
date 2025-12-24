-- Creating Table to import dataset from csv file
-- Создания таблица для загрузки данных
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

-- Changing date columns from text to date type
-- Преобразование столбцов с датой из текстового формате в тип DATE

ALTER TABLE superstore_train
ALTER COLUMN order_date TYPE DATE
USING TO_DATE(order_date, 'DD/MM/YYYY');

ALTER TABLE superstore_train
ALTER COLUMN ship_date TYPE DATE
USING TO_DATE(ship_date, 'DD/MM/YYYY');

-- CHECKING TYPES
-- Проверка типов данных
SELECT superstore_train.order_date, superstore_train.ship_date
FROM superstore_train
LIMIT 10;

-- Verifing imported data
-- Проверка загружtнных данных

SELECT * FROM superstore_train;

-- Counting rows
-- Подсчёт строк

SELECT COUNT(*) FROM superstore_train;
