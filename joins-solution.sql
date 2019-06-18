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
