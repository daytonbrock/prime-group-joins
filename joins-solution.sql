-- 1. Get all customers and their addresses.
SELECT * FROM "customers"
JOIN "addresses" ON "customer_id"="customers"."id";
