INSERT INTO users (full_name, email) VALUES
("Tim Cook", "apple@gmail.com"),
( "Jensen Huang", "nvidia@gmail.com" ),
( "Sundar Pichai", "google@gmail.com" ),
( "Ilon Mask", "tesla@gmail.com"),
( "Mark Zuckerberg", "meta@gmail.com");


INSERT INTO categories (category_name) VALUES
( "electronics" ),
( "groceries" ),
( "books" ),
( "clothes" ),
( "shoes" ),
( "cars" );


INSERT INTO products (product_name, price, category_id) VALUES
( "SQL Book", 10, 3 ),
( "Skechers Waterproof Boats", 99.99 , 5 ),
( "Sony Noice-Cancelling Headphones", 150, 1 ),
( "Audi Q7", 10000, 6 ),
( "Psychology of Money", 12.99 , 3),
( "JBL Speaker", 79.99, 1),
( "Harry Potter", 13.99 , 3 )



INSERT INTO orders (user_id, order_status) VALUES
(1, 'Completed'),
(2, 'Pending');


INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(2, 2, 2);


INSERT INTO payments (order_id, amount, payment_method) VALUES
(1, 1200.00, 'Credit Card');


INSERT INTO reviews (user_id, product_id, rating, review) VALUES
(1, 1, 5, 'Excellent product!');