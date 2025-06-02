# SQL Project: E-Commerce Product Performance Analysis

## 🧠 Overview
This project analyzes product sales, returns, and net revenue for an online store. It demonstrates the use of filtering, joining multiple tables, grouping, and calculation in SQL.

## 📊 Key Insights
- Total units sold per product
- Total units returned
- Net units sold after returns
- Net revenue per product based on price and net units sold

## 💻 Tools Used
- SQL (PostgreSQL syntax)
- DB Fiddle (for practice)

## 🔍 Sample Query

```sql
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
