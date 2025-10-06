Partition là kỹ thuật phân chia bảng or chỉ mục thành những thành phần nhỏ hơn dựa trên giá trị của 1 (hoặc nhiều) cột nhất định.
Quản lý và truy vấn dữ liệu dễ dàng hơn

Các loại Partition:
+Range Partition: Các row sẽ được assign đến partition dựa vào value của column có nằm trong phạm vi của partition function tương ứng hay không. Range partition sử dụng VALUE LESS THAN. Các value phải được liền kề nhau và không được chồng chéo lên nhau và phải mang giá trị integer hoặc NULL

+List Partition: Tương tự như Range partition nhưng giá để phân vùng đã được khai báo sẵn với VALUES IN, nó hoạt động như WHERE IN vậy. Có điểm khác biệt nữa với Range partition là value ngoài INTEGER, NULL thì nó có thể là STIRNG, DATE, TIME

+Hash Partition: Không cần khái báo trước giá để quyết định xem sẽ đc phân vào partition nào, nó sẽ làm điều này một cách tự động dựa vào biếu thức hoặc giá trị INTEGER của cột đã đc chọn. Các bản ghi sẽ đc chia đều cho các partition, nếu k định nghĩa số lượng partition thì sẽ mặc định sẽ là là 1

+Key Partition: Tương tự như Hash Partition có điều Key Partition có thể sử dụng 0 hoặc n cột để partition, các cột không nhất thiết phải là INTEGER. Trường hợp không truyền cột để partition thì primary key hoặc unique key sẽ auto được chọn.
