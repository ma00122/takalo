-- Create users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);-- Create admins table
CREATE TABLE admins (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);-- Create categories table
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);-- Create produits table
CREATE TABLE produits (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    user_id INTEGER REFERENCES users(id),
    category_id INTEGER REFERENCES categories(id),
    photos TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);-- Create requests table
CREATE TABLE requests (
    id SERIAL PRIMARY KEY,
    from_user_id INTEGER REFERENCES users(id),
    to_user_id INTEGER REFERENCES users(id),
    offered_product_id INTEGER REFERENCES produits(id),
    requested_product_id INTEGER REFERENCES produits(id),
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);-- Create historique_produit table
CREATE TABLE historique_produit (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES produits(id),
    action VARCHAR(255),
    user_id INTEGER REFERENCES users(id),
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);-- Insert test users
INSERT INTO users (email, password, name) VALUES
('user1@example.com', 'password1', 'User One'),
('user2@example.com', 'password2', 'User Two'),
('user3@example.com', 'password3', 'User Three');

-- Insert test admin
INSERT INTO admins (email, password, name) VALUES
('admin@example.com', 'adminpass', 'Admin User');-- Insert test categories
INSERT INTO categories (name, description) VALUES
('Electronics', 'Electronic devices and gadgets'),
('Books', 'Books and literature'),
('Clothing', 'Clothes and accessories'),
('Furniture', 'Home furniture');

-- Insert test produits
INSERT INTO produits (title, description, user_id, category_id, photos) VALUES
('Laptop Dell', 'A used Dell laptop in good condition', 1, 1, ARRAY['laptop1.jpg', 'laptop2.jpg']),
('Harry Potter Book', 'The first book of the series', 2, 2, ARRAY['book1.jpg']),
('T-shirt', 'Blue cotton t-shirt', 3, 3, ARRAY['tshirt.jpg']),
('Chair', 'Wooden chair for office', 1, 4, ARRAY['chair.jpg']);-- Insert test échanges (requests)
INSERT INTO requests (from_user_id, to_user_id, offered_product_id, requested_product_id, status) VALUES
(1, 2, 1, 2, 'pending'),
(2, 3, 2, 3, 'accepted'),
(3, 1, 3, 4, 'refused');

-- Insert test historique_produit
INSERT INTO historique_produit (product_id, action, user_id) VALUES
(1, 'created', 1),
(2, 'created', 2),
(3, 'created', 3),
(4, 'created', 1),
(2, 'exchanged', 2),
(3, 'exchanged', 3);

jjkjl