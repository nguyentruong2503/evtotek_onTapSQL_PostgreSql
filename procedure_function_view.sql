--produres update giá trị của sản phẩm sau khi cộng thuế VAT
CREATE PROCEDURE price_after_VAT(p_percentage NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE production.products
    SET list_price = list_price * (1 + p_percentage/100);
END;
$$;

call price_after_VAT(10);

select * from production.products

--function trả về giá của sản phẩm sau khi cộng thuế VAT
CREATE FUNCTION price_after_tax(p_price NUMERIC, p_tax_rate NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN p_price * (1 + p_tax_rate);
END;
$$;
SELECT 
    product_name, 
    list_price,
    price_after_tax(list_price, 0.1) AS final_price
FROM production.products;



CREATE VIEW products_with_VAT AS
SELECT 
    product_id,
    product_name,
    list_price,
    list_price * 1.1 AS price_with_vat
FROM production.products;

SELECT * FROM products_with_VAT;

