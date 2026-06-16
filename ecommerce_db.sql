-- ============================================================
-- E-Commerce Practice Database
-- 涵盖技能: 数据库设计, 数据类型, 列属性, 索引, 触发器, 视图, 存储过程, 事务, 用户权限
-- ============================================================

DROP DATABASE IF EXISTS ecommerce_practice;
CREATE DATABASE ecommerce_practice CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ecommerce_practice;

-- ============================================================
-- 1. 建表 (Table Design)
-- ============================================================

CREATE TABLE categories (
    category_id   INT           AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100)  NOT NULL,
    description   TEXT
);

CREATE TABLE products (
    product_id      INT             AUTO_INCREMENT PRIMARY KEY,
    category_id     INT             NOT NULL,
    name            VARCHAR(200)    NOT NULL,
    price           DECIMAL(10, 2)  NOT NULL CHECK (price >= 0),
    stock_quantity  INT             NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE customers (
    customer_id  INT           AUTO_INCREMENT PRIMARY KEY,
    first_name   VARCHAR(50)   NOT NULL,
    last_name    VARCHAR(50)   NOT NULL,
    email        VARCHAR(150)  NOT NULL UNIQUE,
    city         VARCHAR(100),
    joined_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    order_id    INT          AUTO_INCREMENT PRIMARY KEY,
    customer_id INT          NOT NULL,
    status      ENUM('pending', 'completed', 'cancelled') NOT NULL DEFAULT 'pending',
    ordered_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id     INT             AUTO_INCREMENT PRIMARY KEY,
    order_id    INT             NOT NULL,
    product_id  INT             NOT NULL,
    quantity    INT             NOT NULL CHECK (quantity > 0),
    unit_price  DECIMAL(10, 2)  NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================================
-- 2. 索引 (Indexes) — 加在常用查询字段上
-- ============================================================

CREATE INDEX idx_orders_customer    ON orders(customer_id);
CREATE INDEX idx_orders_ordered_at  ON orders(ordered_at);
CREATE INDEX idx_order_items_order  ON order_items(order_id);
CREATE INDEX idx_products_category  ON products(category_id);

-- ============================================================
-- 3. 模拟数据 (Sample Data)
-- ============================================================

INSERT INTO categories (name, description) VALUES
('Electronics',  'Phones, laptops, and gadgets'),
('Books',        'Fiction and non-fiction titles'),
('Clothing',     'Apparel for all seasons'),
('Home & Garden','Furniture and garden tools'),
('Sports',       'Equipment and activewear');

INSERT INTO products (category_id, name, price, stock_quantity) VALUES
(1, 'Wireless Earbuds',       79.99,  120),
(1, 'Mechanical Keyboard',   109.99,   85),
(1, 'USB-C Hub',              39.99,  200),
(2, 'Clean Code (Book)',      34.99,   60),
(2, 'SQL in 10 Minutes',      24.99,   75),
(3, 'Running Jacket',         89.99,   50),
(3, 'Wool Sweater',           59.99,   40),
(4, 'Bamboo Desk Organizer',  29.99,   90),
(4, 'Indoor Plant Pot Set',   44.99,   65),
(5, 'Yoga Mat',               49.99,  110),
(5, 'Resistance Bands Set',   19.99,  150),
(1, 'Smart Watch',           199.99,   30),
(3, 'Casual Sneakers',        74.99,   55),
(2, 'The Pragmatic Programmer',38.99,  45),
(5, 'Water Bottle 1L',        22.99,  180);

INSERT INTO customers (first_name, last_name, email, city, joined_at) VALUES
('Alice',   'Wang',    'alice.wang@email.com',    'Toronto',   '2023-01-15 10:00:00'),
('Bob',     'Li',      'bob.li@email.com',         'Vancouver', '2023-02-20 11:30:00'),
('Carol',   'Zhang',   'carol.zhang@email.com',    'Montreal',  '2023-03-05 09:15:00'),
('David',   'Kim',     'david.kim@email.com',      'Toronto',   '2023-04-10 14:00:00'),
('Emily',   'Chen',    'emily.chen@email.com',     'Calgary',   '2023-05-22 16:45:00'),
('Frank',   'Nguyen',  'frank.nguyen@email.com',   'Ottawa',    '2023-06-01 08:00:00'),
('Grace',   'Park',    'grace.park@email.com',     'Toronto',   '2023-07-18 12:00:00'),
('Henry',   'Liu',     'henry.liu@email.com',      'Vancouver', '2023-08-30 10:30:00'),
('Irene',   'Zhao',    'irene.zhao@email.com',     'Montreal',  '2023-09-14 15:00:00'),
('Jack',    'Wu',      'jack.wu@email.com',        'Toronto',   '2023-10-05 09:00:00'),
('Karen',   'Tan',     'karen.tan@email.com',      'Calgary',   '2023-11-11 13:00:00'),
('Leo',     'Ma',      'leo.ma@email.com',         'Ottawa',    '2023-12-01 17:00:00'),
('Mia',     'He',      'mia.he@email.com',         'Toronto',   '2024-01-07 11:00:00'),
('Nathan',  'Xu',      'nathan.xu@email.com',      'Vancouver', '2024-02-14 10:00:00'),
('Olivia',  'Luo',     'olivia.luo@email.com',     'Montreal',  '2024-03-20 14:30:00');

-- Orders for 2023
INSERT INTO orders (customer_id, status, ordered_at) VALUES
(1,  'completed', '2023-03-01 10:00:00'),
(2,  'completed', '2023-03-15 11:00:00'),
(3,  'completed', '2023-04-02 09:30:00'),
(1,  'completed', '2023-04-20 14:00:00'),
(4,  'completed', '2023-05-05 16:00:00'),
(5,  'completed', '2023-05-18 10:30:00'),
(6,  'completed', '2023-06-10 09:00:00'),
(2,  'completed', '2023-06-25 13:00:00'),
(7,  'completed', '2023-07-04 11:30:00'),
(3,  'completed', '2023-07-19 15:00:00'),
(8,  'completed', '2023-08-08 10:00:00'),
(1,  'completed', '2023-08-22 14:00:00'),
(9,  'completed', '2023-09-03 09:00:00'),
(4,  'completed', '2023-09-17 12:00:00'),
(10, 'completed', '2023-10-01 10:30:00'),
(5,  'completed', '2023-10-14 11:00:00'),
(11, 'completed', '2023-11-05 09:30:00'),
(6,  'completed', '2023-11-20 14:30:00'),
(12, 'completed', '2023-12-03 10:00:00'),
(2,  'completed', '2023-12-18 13:00:00'),
-- Orders for 2024
(13, 'completed', '2024-01-10 11:00:00'),
(7,  'completed', '2024-01-25 09:00:00'),
(14, 'completed', '2024-02-08 14:00:00'),
(3,  'completed', '2024-02-22 10:30:00'),
(15, 'completed', '2024-03-07 09:30:00'),
(8,  'completed', '2024-03-21 13:00:00'),
(1,  'completed', '2024-04-04 11:30:00'),
(9,  'completed', '2024-04-18 15:00:00'),
(10, 'completed', '2024-05-02 10:00:00'),
(4,  'cancelled', '2024-05-16 09:00:00'),
(11, 'completed', '2024-06-01 14:00:00'),
(5,  'completed', '2024-06-15 11:00:00'),
(12, 'completed', '2024-07-03 10:30:00'),
(13, 'completed', '2024-07-19 13:00:00'),
(6,  'completed', '2024-08-05 09:00:00'),
(14, 'completed', '2024-08-20 14:30:00'),
(2,  'pending',   '2024-09-02 11:00:00'),
(15, 'completed', '2024-09-16 10:00:00'),
(7,  'completed', '2024-10-01 09:30:00'),
(1,  'completed', '2024-10-15 13:00:00');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
-- 2023 orders
(1,  1,  1,  79.99),
(1,  4,  1,  34.99),
(2,  2,  1, 109.99),
(3,  6,  1,  89.99),
(3,  10, 1,  49.99),
(4,  12, 1, 199.99),
(5,  3,  2,  39.99),
(5,  8,  1,  29.99),
(6,  11, 2,  19.99),
(6,  15, 1,  22.99),
(7,  5,  1,  24.99),
(7,  14, 1,  38.99),
(8,  7,  1,  59.99),
(8,  9,  1,  44.99),
(9,  1,  1,  79.99),
(9,  13, 1,  74.99),
(10, 2,  1, 109.99),
(10, 4,  2,  34.99),
(11, 10, 2,  49.99),
(12, 12, 1, 199.99),
(12, 3,  1,  39.99),
(13, 6,  1,  89.99),
(14, 11, 3,  19.99),
(14, 15, 2,  22.99),
(15, 5,  2,  24.99),
(16, 8,  1,  29.99),
(16, 9,  2,  44.99),
(17, 7,  2,  59.99),
(18, 1,  1,  79.99),
(18, 13, 1,  74.99),
(19, 14, 1,  38.99),
(20, 12, 1, 199.99),
-- 2024 orders
(21, 2,  1, 109.99),
(21, 5,  1,  24.99),
(22, 10, 1,  49.99),
(22, 11, 2,  19.99),
(23, 1,  2,  79.99),
(23, 3,  1,  39.99),
(24, 6,  1,  89.99),
(24, 7,  1,  59.99),
(25, 12, 1, 199.99),
(25, 4,  1,  34.99),
(26, 13, 1,  74.99),
(26, 9,  1,  44.99),
(27, 15, 3,  22.99),
(27, 8,  2,  29.99),
(28, 2,  1, 109.99),
(28, 14, 1,  38.99),
(29, 1,  1,  79.99),
(29, 10, 2,  49.99),
-- order 30 is cancelled, still has items
(30, 6,  1,  89.99),
(31, 11, 4,  19.99),
(31, 15, 2,  22.99),
(32, 5,  2,  24.99),
(32, 3,  2,  39.99),
(33, 12, 1, 199.99),
(34, 7,  1,  59.99),
(34, 9,  2,  44.99),
(35, 13, 2,  74.99),
(35, 8,  1,  29.99),
(36, 1,  1,  79.99),
(36, 4,  2,  34.99),
(37, 2,  1, 109.99),
(38, 14, 1,  38.99),
(38, 10, 1,  49.99),
(39, 6,  1,  89.99),
(39, 11, 2,  19.99),
(40, 12, 1, 199.99),
(40, 3,  1,  39.99);

-- ============================================================
-- 4. 视图 (Views)
-- ============================================================

-- 每月各类别销售汇总
CREATE VIEW monthly_sales_summary AS
SELECT
    DATE_FORMAT(o.ordered_at, '%Y-%m')  AS order_month,
    c.name                              AS category,
    COUNT(DISTINCT o.order_id)          AS total_orders,
    SUM(oi.quantity * oi.unit_price)    AS total_revenue,
    ROUND(AVG(oi.unit_price), 2)        AS avg_unit_price
FROM orders o
JOIN order_items oi ON o.order_id   = oi.order_id
JOIN products    p  ON oi.product_id = p.product_id
JOIN categories  c  ON p.category_id = c.category_id
WHERE o.status = 'completed'
GROUP BY order_month, c.name;

-- 客户消费概览
CREATE VIEW customer_spending_summary AS
SELECT
    cu.customer_id,
    CONCAT(cu.first_name, ' ', cu.last_name)  AS full_name,
    cu.city,
    COUNT(DISTINCT o.order_id)                 AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_spent,
    ROUND(AVG(oi.quantity * oi.unit_price), 2) AS avg_order_value
FROM customers   cu
JOIN orders      o  ON cu.customer_id = o.customer_id
JOIN order_items oi ON o.order_id     = oi.order_id
WHERE o.status = 'completed'
GROUP BY cu.customer_id, full_name, cu.city;

-- ============================================================
-- 5. 存储过程 (Stored Procedures)
-- ============================================================

DELIMITER $$

-- 查询指定客户的所有订单
CREATE PROCEDURE get_customer_orders(IN p_customer_id INT)
BEGIN
    SELECT
        o.order_id,
        o.ordered_at,
        o.status,
        p.name                            AS product_name,
        oi.quantity,
        oi.unit_price,
        ROUND(oi.quantity * oi.unit_price, 2) AS line_total
    FROM orders      o
    JOIN order_items oi ON o.order_id    = oi.order_id
    JOIN products    p  ON oi.product_id = p.product_id
    WHERE o.customer_id = p_customer_id
    ORDER BY o.ordered_at DESC;
END$$

-- 下单存储过程（含事务）: 插入订单 + 明细，失败则回滚
CREATE PROCEDURE place_order(
    IN  p_customer_id  INT,
    IN  p_product_id   INT,
    IN  p_quantity     INT,
    OUT p_order_id     INT,
    OUT p_message      VARCHAR(100)
)
BEGIN
    DECLARE v_price         DECIMAL(10,2);
    DECLARE v_stock         INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_message = 'Error: transaction rolled back.';
    END;

    -- 检查库存
    SELECT price, stock_quantity INTO v_price, v_stock
    FROM products WHERE product_id = p_product_id;

    IF v_stock < p_quantity THEN
        SET p_message = 'Error: insufficient stock.';
        SET p_order_id = NULL;
    ELSE
        START TRANSACTION;
            INSERT INTO orders (customer_id, status) VALUES (p_customer_id, 'pending');
            SET p_order_id = LAST_INSERT_ID();
            INSERT INTO order_items (order_id, product_id, quantity, unit_price)
            VALUES (p_order_id, p_product_id, p_quantity, v_price);
        COMMIT;
        SET p_message = 'Success: order placed.';
    END IF;
END$$

DELIMITER ;

-- ============================================================
-- 6. 触发器 (Triggers)
-- ============================================================

DELIMITER $$

-- 下单后自动扣减库存
CREATE TRIGGER after_order_item_insert
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END$$

-- 取消订单后自动恢复库存
CREATE TRIGGER after_order_cancel
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    IF NEW.status = 'cancelled' AND OLD.status != 'cancelled' THEN
        UPDATE products p
        JOIN order_items oi ON p.product_id = oi.product_id
        SET p.stock_quantity = p.stock_quantity + oi.quantity
        WHERE oi.order_id = NEW.order_id;
    END IF;
END$$

DELIMITER ;

-- ============================================================
-- 7. 用户权限 (User Management)
-- ============================================================

-- 只读用户，适合报表查询场景
CREATE USER IF NOT EXISTS 'readonly_user'@'localhost' IDENTIFIED BY 'ReadOnly@2024';
GRANT SELECT ON ecommerce_practice.* TO 'readonly_user'@'localhost';

-- 应用层用户，只能做增删改查（不能改结构）
CREATE USER IF NOT EXISTS 'app_user'@'localhost' IDENTIFIED BY 'AppUser@2024';
GRANT SELECT, INSERT, UPDATE, DELETE ON ecommerce_practice.* TO 'app_user'@'localhost';

FLUSH PRIVILEGES;

-- ============================================================
-- 完成！数据库已就绪。
-- 下一步：参考 practice_queries.sql 开始练习查询
-- ============================================================
