--Range partition
CREATE TABLE products_range (
    product_id SERIAL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price NUMERIC(10,2),
    PRIMARY KEY (product_id, model_year) 
) PARTITION BY RANGE (model_year);

CREATE TABLE products_2020_2021 PARTITION OF products_range
    FOR VALUES FROM (2020) TO (2022);

CREATE TABLE products_2022_2023 PARTITION OF products_range
    FOR VALUES FROM (2022) TO (2024);

INSERT INTO products_range (product_name, brand_id, category_id, model_year, list_price) VALUES
('Giant Defy Advanced', 1, 1, 2023, 2500.00),
('Trek Domane SL5', 2, 1, 2022, 2800.00),
('Specialized Tarmac', 3, 1, 2023, 3000.00),
('Cannondale Synapse Carbon', 4, 1, 2022, 2700.00),
('Shimano Ultegra R8000', 1, 2, 2021, 450.00),
('Specialized Body Geometry Saddle', 3, 2, 2020, 120.00),
('Pearl Izumi Cycling Jersey', 4, 3, 2023, 75.00),
('Giant Water Bottle', 1, 4, 2023, 15.00);

select *
from products_2020_2021

select *
from products_2022_2023

--List partition
CREATE TABLE products_list (
    product_id SERIAL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price NUMERIC(10,2),
    PRIMARY KEY (product_id, category_id)
) PARTITION BY LIST (category_id);

CREATE TABLE products_category1 PARTITION OF products_list FOR VALUES IN (1);
CREATE TABLE products_category2 PARTITION OF products_list FOR VALUES IN (2);
CREATE TABLE products_category3 PARTITION OF products_list FOR VALUES IN (3);
CREATE TABLE products_category4 PARTITION OF products_list FOR VALUES IN (4);

INSERT INTO products_list (product_name, brand_id, category_id, model_year, list_price) VALUES
('Giant Defy Advanced', 1, 1, 2023, 2500.00),
('Trek Domane SL5', 2, 1, 2022, 2800.00),
('Specialized Tarmac', 3, 1, 2023, 3000.00),
('Cannondale Synapse Carbon', 4, 1, 2022, 2700.00),
('Shimano Ultegra R8000', 1, 2, 2021, 450.00),
('Specialized Body Geometry Saddle', 3, 2, 2020, 120.00),
('Pearl Izumi Cycling Jersey', 4, 3, 2023, 75.00),
('Giant Water Bottle', 1, 4, 2023, 15.00);

--Hash partition
CREATE TABLE products_hash (
    product_id INT,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price NUMERIC(10,2),
    PRIMARY KEY (product_id)
) PARTITION BY HASH (product_id);

CREATE TABLE products_hash0 PARTITION OF products_hash
    FOR VALUES WITH (MODULUS 4, REMAINDER 0);

CREATE TABLE products_hash1 PARTITION OF products_hash
    FOR VALUES WITH (MODULUS 4, REMAINDER 1);

CREATE TABLE products_hash2 PARTITION OF products_hash
    FOR VALUES WITH (MODULUS 4, REMAINDER 2);

CREATE TABLE products_hash3 PARTITION OF products_hash
    FOR VALUES WITH (MODULUS 4, REMAINDER 3);

INSERT INTO products_hash (product_id, product_name, brand_id, category_id, model_year, list_price) VALUES
(1, 'Giant Defy Advanced', 1, 1, 2023, 2500.00),
(2, 'Trek Domane SL5', 2, 1, 2022, 2800.00),
(3, 'Specialized Tarmac', 3, 1, 2023, 3000.00),
(4, 'Cannondale Synapse Carbon', 4, 1, 2022, 2700.00),
(5, 'Shimano Ultegra R8000', 1, 2, 2021, 450.00),
(6, 'Specialized Body Geometry Saddle', 3, 2, 2020, 120.00),
(7, 'Pearl Izumi Cycling Jersey', 4, 3, 2023, 75.00),
(8, 'Giant Water Bottle', 1, 4, 2023, 15.00);

select * from products_hash3


