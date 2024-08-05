create table countries(
  id_country serial primary key,
  name varchar(50) not null  
);

create table users(
 id_users serial primary key,
 id_country integer not null,
 email varchar(100) not null,
 name varchar (50) not null,
 foreign key (id_country) references countries (id_country)   
);

insert into countries (name) values ('argentina') , ('colombia'),('chile');

insert into users (id_country, email, name) 
  values (2, 'foo@foo.com', 'fooziman'), (3, 'bar@bar.com', 'barziman'); 

  select * from countries;
  select * from users;

  delete from users where email = 'bar@bar.com';
  
  update users set email = 'foo@foo.foo', name = 'fooz' where id_users = 1;

select * from users inner join  countries on users.id_country = countries.id_country;

select * from users

select u.id_users as id, u.email, u.name as fullname, c.name 
  from users u inner join  countries c on u.id_country = c.id_country;
  
  
  
  
CREATE TABLE priorities (
  id_priority SERIAL PRIMARY KEY,
  type_name VARCHAR(50) NOT NULL
);

CREATE TABLE contact_request (
  id_email VARCHAR(100) PRIMARY KEY,
  id_country INT,
  id_priority INT,
  name VARCHAR(100),
  detail TEXT,
  physical_address TEXT,
  FOREIGN KEY (id_country) REFERENCES countries(id_country),
  FOREIGN KEY (id_priority) REFERENCES priorities(id_priority)
);


INSERT INTO countries (name)
VALUES
  ('Argentina'),
  ('Brasil'),
  ('Colombia'),
  ('México'),
  ('Perú');
  
  SELECT * FROM countries;
  
INSERT INTO priorities (type_name)
VALUES
  ('Alta'),
  ('Media'),
  ('Baja');
  
SELECT * FROM priorities;

INSERT INTO contact_request (id_email, id_country, id_priority, name, detail, physical_address)
VALUES
  ('yan1@example.com', 1, 1, 'Yan Monasterios', 'Solicitud de información', 'Calle Principal 123'),
  ('yan2@example.com', 2, 2, 'Daniel Alvarado', 'Consulta sobre producto', 'Avenida Secundaria 456'),
  ('yan3@example.com', 3, 3, 'Lebron James', 'Queja', 'Calle Lateral 789');
  
SELECT * FROM contact_request;
DELETE FROM contact_request WHERE id_email = 'yan3@example.com';

UPDATE contact_request
SET name = 'Yan Monasterios Updated', detail = 'Solicitud actualizada'
WHERE id_email = 'yan1@example.com';


CREATE TABLE products (
  id_product SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  details TEXT,
  minimum_stock INT,
  maximum_stock INT,
  current_stock INT,
  price NUMERIC(10,2),
  price_with_tax NUMERIC(10,2)
);

CREATE TABLE taxes (
  id_tax SERIAL PRIMARY KEY,
  percentage NUMERIC(5,2)
);

CREATE TABLE offers (
  id_offer SERIAL PRIMARY KEY,
  id_product INT,
  id_tax INT,
  status VARCHAR(20),
  name VARCHAR(100),
  FOREIGN KEY (id_product) REFERENCES products(id_product),
  FOREIGN KEY (id_tax) REFERENCES taxes(id_tax)
);

CREATE TABLE discounts (
  id_discount SERIAL PRIMARY KEY,
  status VARCHAR(20),
  percentage NUMERIC(5,2)
);

CREATE TABLE roles (
  id_role SERIAL PRIMARY KEY,
  name VARCHAR(50)
);

CREATE TABLE customers (
  email VARCHAR(100) PRIMARY KEY,
  id_country INT,
  id_role INT,
  name VARCHAR(100),
  age INT,
  password VARCHAR(255),
  physical_address TEXT,
  FOREIGN KEY (id_country) REFERENCES countries(id_country),
  FOREIGN KEY (id_role) REFERENCES roles(id_role)
);

CREATE TABLE products_customers (
  id_product INT,
  id_customer VARCHAR(100),
  PRIMARY KEY (id_product, id_customer),
  FOREIGN KEY (id_product) REFERENCES products(id_product),
  FOREIGN KEY (id_customer) REFERENCES customers(email)
);

CREATE TABLE invoices (
  id_invoice SERIAL PRIMARY KEY,
  id_customer VARCHAR(100),
  id_payment_status INT,
  date DATE,
  total_to_pay NUMERIC(10,2),
  FOREIGN KEY (id_customer) REFERENCES customers(email)
);


CREATE TABLE orders (
  id_order SERIAL PRIMARY KEY,
  id_customer VARCHAR(100),
  id_invoice INT,
  id_product INT,
  detail TEXT,
  amount INT,
  price NUMERIC(10,2),
  FOREIGN KEY (id_customer) REFERENCES customers(email),
  FOREIGN KEY (id_invoice) REFERENCES invoices(id_invoice),
  FOREIGN KEY (id_product) REFERENCES products(id_product)
);

CREATE TABLE payments (
  id_payment SERIAL PRIMARY KEY,
  type VARCHAR(50),
  id_invoice INT,
  amount NUMERIC(10,2),
  FOREIGN KEY (id_invoice) REFERENCES invoices(id_invoice)
);

CREATE TABLE invoice_status (
  id_invoice_status SERIAL PRIMARY KEY,
  status VARCHAR(50)
);

INSERT INTO products (name, details, minimum_stock, maximum_stock, current_stock, price, price_with_tax)
VALUES
  ('Producto 1', 'Descripción del producto 1', 10, 100, 50, 19.99, 23.99),
  ('Producto 2', 'Descripción del producto 2', 20, 150, 80, 29.99, 35.99),
  ('Producto 3', 'Descripción del producto 3', 30, 200, 120, 39.99, 47.99);
  
INSERT INTO roles (name) VALUES ('admin');
INSERT INTO roles (name) VALUES ('customer');
INSERT INTO roles (name) VALUES ('guest');
  
INSERT INTO customers (email, id_country, id_role, name, age, password, physical_address)
VALUES ('customer4@example.com', 1, 1, 'New Customer', 30, 'password123', 'Address 123');

INSERT INTO invoices (id_customer, id_payment_status, date, total_to_pay)
VALUES ('customer4@example.com', 1, '2024-08-04', 120.00);

INSERT INTO taxes (percentage) VALUES (19);
INSERT INTO taxes (percentage) VALUES (10);
INSERT INTO taxes (percentage) VALUES (5);

UPDATE taxes
SET percentage = 17;

SELECT * FROM taxes;

UPDATE products
SET price = price * 1.1, 
    price_with_tax = price_with_tax * 1.1;
