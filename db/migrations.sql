DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
\c shop;

CREATE TABLE employees(
	id SERIAL PRIMARY KEY,
	name VARCHAR(128),
	username VARCHAR(64),
	password_digest VARCHAR(256),
	manager BOOLEAN
);

CREATE TABLE drivers(
	id SERIAL PRIMARY KEY,
	name VARCHAR(128),
	username VARCHAR(64),
	password_digest VARCHAR(256),
	truck_num VARCHAR(32),
	make VARCHAR(32),
	model VARCHAR(32),
	year SMALLINT
);

CREATE TABLE orders(
	id SERIAL PRIMARY KEY,
	title VARCHAR(128),
	driver_id INT REFERENCES drivers(id),
	employee_id INT REFERENCES employees(id),
	comment VARCHAR(512),
	description VARCHAR(32),
	completed BOOLEAN
);