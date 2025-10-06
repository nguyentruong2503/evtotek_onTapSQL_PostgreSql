--Tạo database
Create database bike_store

--Tạo Schema
CREATE SCHEMA production;

CREATE SCHEMA sales;

--Tạo bảng
CREATE TABLE production.categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);

CREATE TABLE production.brands (
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL
);

CREATE TABLE production.products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price NUMERIC(10,2) NOT NULL,
    CONSTRAINT fk_category FOREIGN KEY (category_id) 
        REFERENCES production.categories(category_id) ,
    CONSTRAINT fk_brand FOREIGN KEY (brand_id) 
        REFERENCES production.brands(brand_id) 
);

CREATE TABLE sales.customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone VARCHAR(25),
    email VARCHAR(255) NOT NULL,
    street VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(25),
    zip_code VARCHAR(5)
);

CREATE TABLE sales.stores (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR(255) NOT NULL,
    phone VARCHAR(25),
    email VARCHAR(255),
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(10),
    zip_code VARCHAR(5)
);

CREATE TABLE sales.staffs (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(25),
    active SMALLINT NOT NULL,
    store_id INT NOT NULL,
    manager_id INT,
    CONSTRAINT fk_staff_store FOREIGN KEY (store_id) 
        REFERENCES sales.stores(store_id) 
        ON DELETE CASCADE,
    CONSTRAINT fk_staff_manager FOREIGN KEY (manager_id) 
        REFERENCES sales.staffs(staff_id)
);

CREATE TABLE sales.orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_status SMALLINT NOT NULL,
    order_date DATE NOT NULL,
    required_date DATE NOT NULL,
    shipped_date DATE,
    store_id INT NOT NULL,
    staff_id INT NOT NULL,
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) 
        REFERENCES sales.customers(customer_id) 
        ON DELETE CASCADE,
    CONSTRAINT fk_order_store FOREIGN KEY (store_id) 
        REFERENCES sales.stores(store_id) 
        ON DELETE CASCADE,
    CONSTRAINT fk_order_staff FOREIGN KEY (staff_id) 
        REFERENCES sales.staffs(staff_id)
);

CREATE TABLE sales.order_items (
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    list_price NUMERIC(10,2) NOT NULL,
    discount NUMERIC(4,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (order_id, item_id),
    CONSTRAINT fk_orderitem_order FOREIGN KEY (order_id) 
        REFERENCES sales.orders(order_id) 
        ON DELETE CASCADE,
    CONSTRAINT fk_orderitem_product FOREIGN KEY (product_id) 
        REFERENCES production.products(product_id) 
        ON DELETE CASCADE
);

CREATE TABLE production.stocks (
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT,
    PRIMARY KEY (store_id, product_id),
    CONSTRAINT fk_stock_store FOREIGN KEY (store_id) 
        REFERENCES sales.stores(store_id) 
        ON DELETE CASCADE,
    CONSTRAINT fk_stock_product FOREIGN KEY (product_id) 
        REFERENCES production.products(product_id) 
        ON DELETE CASCADE
);

--Insert dữ liệu
INSERT INTO production.categories (category_name) VALUES
('Bikes'),
('Components'),
('Clothing'),
('Accessories');

INSERT INTO production.brands (brand_name) VALUES
('Giant'),
('Trek'),
('Specialized'),
('Cannondale');


INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price) VALUES
('Giant Defy Advanced', 1, 1, 2023, 2500.00),
('Trek Domane SL5', 2, 1, 2022, 2800.00),
('Specialized Tarmac', 3, 1, 2023, 3000.00),
('Cannondale Synapse Carbon', 4, 1, 2022, 2700.00),
('Shimano Ultegra R8000', 1, 2, 2021, 450.00),
('Specialized Body Geometry Saddle', 3, 2, 2020, 120.00),
('Pearl Izumi Cycling Jersey', 4, 3, 2023, 75.00),
('Giant Water Bottle', 1, 4, 2023, 15.00);


INSERT INTO sales.stores (store_name, phone, email, street, city, state, zip_code) VALUES
('Central Bike Store', '123-456-7890', 'central@bikestore.com', '123 Main St', 'New York', 'NY', '10001'),
('Downtown Bike Shop', '234-567-8901', 'downtown@bikestore.com', '456 Market St', 'Los Angeles', 'CA', '90001');


INSERT INTO sales.staffs (first_name, last_name, email, phone, active, store_id, manager_id) VALUES
('John', 'Doe', 'john.doe@example.com', '111-111-1111', 1, 1, NULL),
('Jane', 'Smith', 'jane.smith@example.com', '222-222-2222', 1, 1, 1),
('Alice', 'Brown', 'alice.brown@example.com', '333-333-3333', 1, 2, NULL),
('Bob', 'Johnson', 'bob.johnson@example.com', '444-444-4444', 1, 2, 3);


INSERT INTO sales.customers (first_name, last_name, phone, email, street, city, state, zip_code) values
('Nino', 'Green', '555-111-2222', 'michael.green@example.com', '789 Elm St', 'New York', 'NY', '10002'),
('Michael', 'Green', '555-111-2222', 'michael.green@example.com', '789 Elm St', 'New York', 'NY', '10002'),
('Sarah', 'White', '555-333-4444', 'sarah.white@example.com', '321 Oak St', 'Los Angeles', 'CA', '90002'),
('David', 'Black', '555-555-6666', 'david.black@example.com', '654 Pine St', 'Chicago', 'IL', '60601');


INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id) VALUES
(1, 1, '2025-10-01', '2025-10-05', '2025-10-02', 1, 1),
(2, 2, '2025-10-02', '2025-10-07', NULL, 2, 3),
(3, 1, '2025-10-03', '2025-10-08', '2025-10-04', 1, 2);


INSERT INTO sales.order_items (order_id, item_id, product_id, quantity, list_price, discount) VALUES
(1, 1, 1, 1, 2500.00, 0),
(1, 2, 5, 2, 450.00, 10),
(2, 1, 2, 1, 2800.00, 0),
(2, 2, 7, 3, 75.00, 5),
(3, 1, 3, 2, 3000.00, 15),
(3, 2, 8, 4, 15.00, 0);


INSERT INTO production.stocks (store_id, product_id, quantity) VALUES
(1, 1, 10),
(1, 5, 20),
(1, 3, 5),
(1, 8, 50),
(2, 2, 8),
(2, 7, 15),
(2, 4, 6);




