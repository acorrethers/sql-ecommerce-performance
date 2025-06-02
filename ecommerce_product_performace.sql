-- products table
CREATE TABLE products (
  id INT,
  name TEXT,
  category TEXT,
  price DECIMAL
);

INSERT INTO products VALUES
(1, 'Wireless Mouse', 'Electronics', 25.99),
(2, 'Yoga Mat', 'Fitness', 45.00),
(3, 'Bluetooth Speaker', 'Electronics', 60.00),
(4, 'Desk Lamp', 'Home', 30.00),
(5, 'Running Shoes', 'Fitness', 85.00);

-- sales table
CREATE TABLE sales (
  id INT,
  product_id INT,
  quantity INT
);

INSERT INTO sales VALUES
(1, 1, 10),
(2, 2, 5),
(3, 3, 7),
(4, 1, 3),
(5, 5, 6),
(6, 4, 4);

-- returns table
CREATE TABLE returns (
  id INT,
  product_id INT,
  quantity INT
);

INSERT INTO returns VALUES
(1, 1, 1),
(2, 3, 1),
(3, 5, 2);

-- SQL query: product performance
SELECT 
  p.name,
  p.category,
  SUM(s.quantity) AS total_sold,
  COALESCE(SUM(r.quantity), 0) AS total_returned,
  SUM(s.quantity) - COALESCE(SUM(r.quantity), 0) AS net_units_sold,
  ROUND(p.price * (SUM(s.quantity) - COALESCE(SUM(r.quantity), 0)), 2) AS net_revenue
FROM products p
LEFT JOIN sales s ON p.id = s.product_id
LEFT JOIN returns r ON p.id = r.product_id
GROUP BY p.id, p.name, p.category, p.price
ORDER BY net_revenue DESC;
