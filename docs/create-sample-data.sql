-- Sample data needed for dbt transformations
CREATE TABLE public.customers (
	customer_key INT GENERATED ALWAYS AS IDENTITY NOT NULL,
	name VARCHAR NOT NULL,
	address VARCHAR NOT NULL,
	nation_key INT NOT NULL,
	phone_number VARCHAR,
	account_balance numeric(15,2) NOT NULL,
	comment VARCHAR,
	CONSTRAINT customers_pk PRIMARY KEY (customer_key)
);

INSERT INTO public.customers (name, address, nation_key, phone_number, account_balance, comment)
VALUES
('customer#00001', 'customer_address#00001', 1, '9876543210', 34.54, ''),
('customer#00002', 'customer_address#00002', 1, '9876543210', 34.54, ''),
('customer#00003', 'customer_address#00003', 1, '9876543210', 34.54, ''),
('customer#00004', 'customer_address#00004', 1, '9876543210', 34.54, ''),
('customer#00005', 'customer_address#00005', 1, '9876543210', 34.54, ''),
('customer#00006', 'customer_address#00006', 1, '9876543210', 34.54, ''),
('customer#00007', 'customer_address#00007', 1, '9876543210', 34.54, ''),
('customer#00008', 'customer_address#00008', 1, '9876543210', 34.54, ''),
('customer#00009', 'customer_address#00009', 1, '9876543210', 34.54, ''),
('customer#00010', 'customer_address#00010', 1, '9876543210', 34.54, ''),
('customer#00011', 'customer_address#00008', 1, '9876543210', 34.54, ''),
('customer#00012', 'customer_address#00009', 1, '9876543210', 34.54, '');

CREATE TABLE public.orders(
   order_key INT GENERATED ALWAYS AS IDENTITY NOT NULL,
   customer_key INT NOT NULL,
   order_status VARCHAR,
   total_price NUMERIC(15,2) NOT NULL,
   order_date DATE NOT NULL,
   order_priority VARCHAR NOT NULL,
   ship_priority BOOLEAN NOT NULL,
   comment VARCHAR,
   CONSTRAINT orders_pk PRIMARY KEY(order_key),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_key)
        REFERENCES customers(customer_key)
);

INSERT INTO public.orders (customer_key, order_status, total_price, order_date, order_priority, ship_priority, comment)
VALUES
(1, 'O', 21446.87, '2023-12-05', '5-LOW', false, ''),
(2, 'O', 21446.87, '2023-11-05', '1-URGENT', false, ''),
(3, 'F', 21446.87, '2023-12-05', '5-LOW', false, ''),
(4, 'O', 21446.87, '2024-01-05', '5-LOW', false, ''),
(5, 'F', 21446.87, '2024-01-05', '5-LOW', false, ''),
(6, 'F', 21446.87, '2024-01-06', '1-URGENT', true, ''),
(7, 'O', 21446.87, '2024-01-09', '4-NOT SPECIFIED', false, ''),
(8, 'O', 21446.87, '2024-02-05', '2-HIGH', false, ''),
(9, 'F', 21446.87, '2024-02-06', '5-LOW', false, ''),
(10, 'O', 21446.87, '2024-02-07', '5-LOW', false, '');

-- Grant transform_role access to these tables
GRANT USAGE ON SCHEMA public TO transform_role;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO transform_role;
