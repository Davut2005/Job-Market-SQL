
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
    price NUMERIC(10,2) NOT NULL CHECK(price > 0),
    category_id INT REFERENCES categories( category_id ) NOT NULL
);   

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users( user_id ) ON DELETE CASCADE NOT NULL,
    order_status VARCHAR(50),
    order_date DATE DEFAULT CURRENT_DATE  
);

CREATE TABLE order_items (
    order_id INT REFERENCES orders( order_id ) ON DELETE CASCADE NOT NULL,
    product_id INT REFERENCES products( product_id ) NOT NULL,
    quantity INT NOT NULL CHECK(quantity > 0),
    PRIMARY KEY( order_id, product_id )
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE NOT NULL,
    payment_date DATE DEFAULT CURRENT_DATE,
    amount NUMERIC(10,2) NOT NULL CHECK(amount > 0),
    payment_method VARCHAR(50)
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users( user_id ) ON DELETE CASCADE NOT NULL,
    product_id INT REFERENCES products( product_id ) ON DELETE CASCADE NOT NULL,
    rating INT CHECK(rating BETWEEN 1 AND 5),
    review VARCHAR(255),
    review_date DATE DEFAULT CURRENT_DATE
);