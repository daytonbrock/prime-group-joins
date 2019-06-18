-- 1. Get all customers and their addresses.
SELECT * FROM "customers"
JOIN "addresses" ON "customer_id"="customers"."id";

-- 2. Get all orders and their line items (orders, quantity and product).
SELECT "orders"."id", "order_date", "line_items"."quantity", "products"."description" FROM "orders" 
JOIN "line_items" ON "orders"."id"="order_id"
JOIN "products" ON "products"."id"="product_id"

-- 3. Which warehouses have cheetos?
SELECT "warehouse"."warehouse" FROM "warehouse"
JOIN "warehouse_product" ON "warehouse_id"="warehouse"."id"
WHERE "warehouse_product"."product_id" = 5;

-- 4. Which warehouse have diet pepsi?
SELECT "warehouse"."warehouse" FROM "warehouse"
JOIN "warehouse_product" ON "warehouse_id"="warehouse"."id"
WHERE "warehouse_product"."product_id" = 6;

-- 5. Get the number of orders from each customer.
SELECT "customers"."id", "customers"."first_name", "customers"."last_name", COUNT("orders"."id") FROM "customers"
JOIN "addresses" ON "customer_id"="customers"."id"
JOIN "orders" ON "address_id"="addresses"."id"
GROUP BY "customers"."id";

-- 6. How many customers do we have?
SELECT COUNT("customers"."id") FROM "customers";

-- 7. How many products do we carry?
SELECT COUNT("products"."id") FROM "products";

-- 8. What is the total available on-hand quantity of diet pepsi?
SELECT "products"."description", SUM("on_hand") FROM "products"
JOIN "warehouse_product" ON "product_id"="products"."id"
WHERE "products"."id"=6 GROUP BY "products"."id";

-- 9. How much was the total cost for each order?
SELECT "orders"."id" AS "order_id", SUM("unit_price"*"quantity") AS "total_cost" FROM "line_items"
JOIN "orders" ON "order_id"="orders"."id"
JOIN "products" ON "product_id"="products"."id"
GROUP BY "orders"."id" ORDER BY "orders"."id" ASC;

-- 10. How much has each customer spent in total?
SELECT "customers"."id", "customers"."first_name", "customers"."last_name", SUM("unit_price"*"quantity") FROM "customers"
JOIN "addresses" ON "customer_id"="customers"."id"
JOIN "orders" ON "address_id"="addresses"."id"
JOIN "line_items" ON "order_id"="orders"."id"
JOIN "products" ON "product_id"="products"."id"
GROUP BY "customers"."id" ORDER BY "customers"."id" ASC;

-- 11. How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).
SELECT "customers"."id", "customers"."first_name", "customers"."last_name", COALESCE(SUM("unit_price"*"quantity"), 0) FROM "customers"
FULL JOIN "addresses" ON "customer_id"="customers"."id"
FULL JOIN "orders" ON "address_id"="addresses"."id"
FULL JOIN "line_items" ON "order_id"="orders"."id"
FULL JOIN "products" ON "product_id"="products"."id"
GROUP BY "customers"."id" ORDER BY "customers"."id" ASC;
