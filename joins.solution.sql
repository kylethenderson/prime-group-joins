-- Get customers and their addresses

SELECT *
FROM "addresses"
JOIN "customers" ON "addresses"."customer_id" = "customers"."id";


-- Get all orders and their line items (orders, quantity and product).

SELECT "orders"."id", "orders"."order_date", "quantity", "description"
FROM "orders"
LEFT JOIN "line_items" ON "orders"."id" = "line_items"."order_id"
LEFT JOIN "products" ON "line_items"."product_id" = "products"."id";

-- 	Which warehouses have cheetos?

SELECT *
FROM "warehouse"
JOIN "warehouse_product" ON "warehouse"."id" = "warehouse_product"."warehouse_id"
JOIN "products" ON "warehouse_product"."product_id" = "products"."id"
WHERE "products"."description" = 'cheetos';

--	Which warehouses have diet pepsi?

SELECT *
FROM "warehouse"
JOIN "warehouse_product" ON "warehouse"."id" = "warehouse_product"."warehouse_id"
JOIN "products" ON "warehouse_product"."product_id" = "products"."id"
WHERE "products"."description" = 'diet pepsi';

-- 	Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.

SELECT "customers"."first_name", "customers"."last_name", COUNT(*) FROM 
"orders" LEFT JOIN "addresses" 
	ON "orders"."address_id" = "addresses"."id"
LEFT JOIN "customers" 
	ON "addresses"."customer_id" = "customers"."id"
GROUP BY "customers"."id";

-- 	How many customers do we have?

SELECT COUNT(*) FROM
"customers";

--	How many products do we carry?

SELECT COUNT(*) FROM 
"products";

--	What is the total available on-hand quantity of diet pepsi?

SELECT SUM("warehouse_product"."on_hand") AS "On-hand diet pepsi" FROM
"warehouse" JOIN "warehouse_product"
	ON "warehouse"."id" = "warehouse_product"."warehouse_id"
JOIN "products" 
	ON "warehouse_product"."product_id" = "products"."id"
WHERE "products"."description" = 'diet pepsi';

--	How much was the total cost for each order?

SELECT "orders"."id" AS "Order ID", SUM("products"."unit_price") AS "Order Total" FROM
"orders"
JOIN "line_items" ON "orders"."id" = "line_items"."order_id"
JOIN "products" ON "line_items"."product_id" = "products"."id"
GROUP BY "orders"."id";