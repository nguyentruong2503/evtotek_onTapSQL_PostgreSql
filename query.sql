--Sản phẩm có giá bé hơn 2000 và category = 2
select *
from production.products
where list_price < 2000 and category_id = 2


--Danh sách khách hàng sx theo thứ tự tăng dần của last_name, nếu trùng thì sx theo tăng dần của first_name
select *
from sales.customers
order by last_name asc, first_name asc

--Lấy 5 sản phẩm đắt nhất
select *
from production.products
order by list_price desc
limit 5

--Tìm đơn hàng mà khách hàng có last_name là Green
SELECT *
FROM sales.orders o 
JOIN sales.customers c ON c.customer_id = o.customer_id AND c.last_name = 'Green'

--Tổng số lượng mặt hàng có trong mỗi đơn hàng
select o.order_id, sum(quantity) as total_item
from  sales.orders o
join sales.order_items oi on o.order_id = oi.order_id
group by o.order_id

--Lấy danh sách tất cả khách hàng đã mua sản phẩm từ brand Specialized
select c.*
from sales.customers c
join sales.orders o on c.customer_id = o.customer_id
join sales.order_items oi on o.order_id = oi.order_id
join production.products p on oi.product_id = p.product_id 
join production.brands b on p.brand_id = b.brand_id and brand_name = 'Specialized'

--Lấy danh sách khách hàng, tổng số đơn hàng, tổng số sản phẩm mua, tổng tiền đã chi, sắp xếp theo tổng tiền giảm dần
select
	c.customer_id ,
	c.last_name ,
	c.first_name ,
	count(distinct o.order_id ) as total_orders,
	sum(oi.quantity) as totol_quantity,
	sum(oi.list_price * oi.quantity) as total_amount
from sales.customers c
join sales.orders o on c.customer_id = o.customer_id
join sales.order_items oi on o.order_id = oi.order_id
group by c.customer_id ,c.last_name ,c.first_name
order by total_amount desc

--Tính tổng tiền của mỗi order
select o.order_id ,
	sum(oi.list_price * oi.quantity) as total_amount
from sales.orders o
join sales.order_items oi on o.order_id = oi.order_id
group by o.order_id

--Tính tổng số lượng sản phẩm tồn kho trong mỗi cửa hàng
select ch.store_name, sum(s.quantity) as total_stock
from sales.stores ch
join production.stocks s on ch.store_id = s.store_id
group by ch.store_name

--Tính giá trung bình (average list_price) của mỗi category
select c.category_id , AVG(p.list_price)
from production.categories c 
join production.products p on c.category_id = p.category_id 
group by c.category_id