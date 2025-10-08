--Trigger khi insert vào bảng products thì tên sản phẩm tự động chuyển thành in hoa

CREATE OR REPLACE FUNCTION make_product_name_uppercase()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.product_name := UPPER(NEW.product_name);
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_product_name_upper
BEFORE INSERT ON production.products
FOR EACH ROW
EXECUTE FUNCTION make_product_name_uppercase();

INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price) VALUES
('Shoe', 1, 1, 2025, 2100.00)

select * 
from production.products

--Trigger ngăn chặn update giá sản phẩm <0
CREATE OR REPLACE FUNCTION prevent_negative_price()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.list_price < 1 THEN
        RAISE EXCEPTION 'Giá bán không thể < 0 ';
    END IF;
    
    RETURN NEW;  
END;
$$;

CREATE TRIGGER trigger_prevent_negative_price
BEFORE UPDATE ON production.products
FOR EACH ROW
EXECUTE FUNCTION prevent_negative_price();

update production.products
set list_price = -2
where product_id = 1
