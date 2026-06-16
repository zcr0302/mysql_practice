# MySQL Practice Project

A self-directed SQL practice project built on an AI-generated simulated e-commerce database, covering core MySQL skills including data retrieval, aggregation, subqueries, views, stored procedures, triggers, and transactions.

## Database Schema

- `customers` — customer profiles and location  
- `categories` — product categories  
- `products` — product catalogue with pricing and stock  
- `orders` — order records with status tracking  
- `order_items` — line items linking orders to products

## Files

| File | Description |
| :---- | :---- |
| `ecommerce_db.sql` | Creates the database, tables, sample data, views, stored procedures, triggers, and users |
| `MySQL_skills_practice.sql` | My own practice queries written from scratch |

## Skills Demonstrated

- **Data retrieval** — `SELECT`, `WHERE`, `ORDER BY`, `LIKE`  
- **Joins** — `INNER JOIN` across multiple tables using `USING`  
- **Aggregate functions** — `SUM`, `COUNT`, `AVG`, `GROUP BY`, `HAVING`  
- **Subqueries** — correlated subqueries and nested `AVG` for threshold filtering  
- **Views** — `monthly_sales_summary`, `customer_spending_summary`  
- **Stored procedures** — parameterised order lookup and order placement  
- **Triggers** — automatic stock deduction on insert, stock restoration on order cancellation  
- **Transactions** — `START TRANSACTION` / `ROLLBACK` with trigger verification

