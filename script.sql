
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS deliveries CASCADE;


CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATE DEFAULT CURRENT_DATE
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0),
    category_id INT REFERENCES categories(category_id) NOT NULL
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE NOT NULL,
    order_status VARCHAR(50),
    order_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE order_items (
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE NOT NULL,
    product_id INT REFERENCES products(product_id) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE NOT NULL,
    payment_date DATE DEFAULT CURRENT_DATE,
    amount NUMERIC(10,2) NOT NULL CHECK (amount > 0),
    payment_method VARCHAR(50)
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE NOT NULL,
    product_id INT REFERENCES products(product_id) ON DELETE CASCADE NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review VARCHAR(255),
    review_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE deliveries (
    delivery_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    shipping_address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    shipping_date DATE DEFAULT CURRENT_DATE,
    delivery_date DATE,
    delivery_status VARCHAR(50),
    CONSTRAINT fk_deliveries_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE
);



INSERT INTO users (full_name, email) VALUES
('Tim Cook', 'tim@apple.com'),
('Jensen Huang', 'jensen@nvidia.com'),
('Sundar Pichai', 'sundar@google.com'),
('Elon Musk', 'elon@tesla.com'),
('Mark Zuckerberg', 'mark@meta.com'),
('Satya Nadella', 'satya@microsoft.com'),
('Jeff Bezos', 'jeff@amazon.com'),
('Bill Gates', 'bill@gates.com'),
('Larry Page', 'larry@google.com'),
('Sergey Brin', 'sergey@google.com');



INSERT INTO categories (category_name) VALUES
('electronics'),
('books'),
('clothes'),
('shoes'),
('cars'),
('groceries'),
('furniture'),
('toys'),
('sports'),
('beauty');



INSERT INTO products (product_name, price, category_id) VALUES
('SQL Book', 15.99, 2),
('PostgreSQL Guide', 22.50, 2),
('Sony Headphones', 149.99, 1),
('JBL Speaker', 79.99, 1),
('Running Shoes', 120.00, 4),
('Office Chair', 199.99, 7),
('Toy Car', 19.99, 8),
('Football', 29.99, 9),
('Audi Q7', 10000, 5),
('Skin Care Kit', 49.99, 10);



INSERT INTO orders (user_id, order_status) VALUES
(1, 'Completed'),
(2, 'Completed'),
(3, 'Pending'),
(4, 'Completed'),
(5, 'Pending'),
(6, 'Completed'),
(7, 'Completed'),
(8, 'Pending'),
(9, 'Completed'),
(10, 'Completed');



INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 3, 1),
(2, 4, 2),
(3, 5, 1),
(4, 6, 1),
(5, 7, 3),
(6, 8, 2),
(7, 9, 1),
(8, 10, 2),
(9, 2, 1);



INSERT INTO payments (order_id, amount, payment_method) VALUES
(1, 165.98, 'Credit Card'),
(2, 159.98, 'PayPal'),
(3, 120.00, 'Credit Card'),
(4, 199.99, 'Debit Card'),
(5, 59.97, 'Credit Card'),
(6, 59.98, 'PayPal'),
(7, 10000.00, 'Bank Transfer'),
(8, 99.98, 'Credit Card'),
(9, 22.50, 'Debit Card'),
(10, 49.99, 'PayPal');



INSERT INTO reviews (user_id, product_id, rating, review) VALUES
(1, 1, 5, 'Excellent SQL book'),
(2, 3, 4, 'Very good sound'),
(3, 4, 5, 'Loud and clear'),
(4, 5, 4, 'Comfortable shoes'),
(5, 6, 5, 'Great chair'),
(6, 7, 4, 'Kids loved it'),
(7, 8, 5, 'Perfect for training'),
(8, 9, 5, 'Amazing car'),
(9, 2, 4, 'Well explained'),
(10, 10, 3, 'Good but pricey');


INSERT INTO deliveries
(order_id, shipping_address, city, country, delivery_date, delivery_status)
VALUES
(1, '1 Infinite Loop', 'Cupertino', 'USA', CURRENT_DATE + INTERVAL '5 days', 'Delivered'),
(2, '2788 San Tomas Expressway', 'Santa Clara', 'USA', CURRENT_DATE + INTERVAL '6 days', 'Shipped'),
(3, '1600 Amphitheatre Parkway', 'Mountain View', 'USA', NULL, 'Processing'),
(4, '350 Fifth Avenue', 'New York', 'USA', CURRENT_DATE + INTERVAL '4 days', 'Delivered'),
(5, '1 Hacker Way', 'Menlo Park', 'USA', NULL, 'Processing'),
(6, 'One Microsoft Way', 'Redmond', 'USA', CURRENT_DATE + INTERVAL '3 days', 'Delivered'),
(7, '410 Terry Ave', 'Seattle', 'USA', CURRENT_DATE + INTERVAL '7 days', 'Shipped'),
(8, '345 Spear Street', 'San Francisco', 'USA', NULL, 'Pending'),
(9, '111 8th Avenue', 'New York', 'USA', CURRENT_DATE + INTERVAL '5 days', 'Delivered'),
(10, '1355 Market Street', 'San Francisco', 'USA', CURRENT_DATE + INTERVAL '6 days', 'Shipped');



CREATE VIEW user_orders_view AS
SELECT 
    u.user_id,
    u.full_name,
    o.order_id,
    o.order_status,
    o.order_date
FROM users u
JOIN orders o ON u.user_id = o.user_id;



CREATE VIEW product_sales_stats AS
SELECT 
    p.product_name,
    c.category_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * p.price) AS total_revenue
FROM products p
JOIN categories c ON p.category_id = c.category_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name, c.category_name;



SELECT * 
FROM products
ORDER BY price DESC;


SELECT 
    u.full_name,
    p.product_name,
    o.order_status
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
  AND p.price > 50;


SELECT 
    c.category_name,
    COUNT(p.product_id) AS product_count
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING COUNT(p.product_id) >= 2;