CREATE INDEX idx_price_btree
ON production.products(list_price);

EXPLAIN ANALYZE
SELECT product_name, list_price
FROM production.products
ORDER BY list_price DESC
LIMIT 5;