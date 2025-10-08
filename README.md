-----------------------PARTITION-----------------------
Partition là kỹ thuật phân chia bảng or chỉ mục thành những thành phần nhỏ hơn dựa trên giá trị của 1 (hoặc nhiều) cột nhất định.
Quản lý và truy vấn dữ liệu dễ dàng hơn

Các loại Partition:
+Range Partition: Các row sẽ được assign đến partition dựa vào value của column có nằm trong phạm vi của partition function tương ứng hay không. Range partition sử dụng VALUE LESS THAN. Các value phải được liền kề nhau và không được chồng chéo lên nhau và phải mang giá trị integer hoặc NULL

+List Partition: Tương tự như Range partition nhưng giá để phân vùng đã được khai báo sẵn với VALUES IN, nó hoạt động như WHERE IN vậy. Có điểm khác biệt nữa với Range partition là value ngoài INTEGER, NULL thì nó có thể là STIRNG, DATE, TIME

+Hash Partition: Không cần khái báo trước giá để quyết định xem sẽ đc phân vào partition nào, nó sẽ làm điều này một cách tự động dựa vào biếu thức hoặc giá trị INTEGER của cột đã đc chọn. Các bản ghi sẽ đc chia đều cho các partition, nếu k định nghĩa số lượng partition thì sẽ mặc định sẽ là là 1

+Key Partition: Tương tự như Hash Partition có điều Key Partition có thể sử dụng 0 hoặc n cột để partition, các cột không nhất thiết phải là INTEGER. Trường hợp không truyền cột để partition thì primary key hoặc unique key sẽ auto được chọn.

-----------------------INDEX-----------------------
Index trỏ tới địa chỉ dữ liệu trong bảng, nó giống như mục lục, giúp truy vấn trở nên nhanh chóng

Các kiểu index:
-B-Tree:

- Dữ liệu được tổ chức và lưu trữ theo dạng cây
- Được sử dụng trong các biểu thức so sánh <,>,=,>=,<=, BETWEEN và LIKE

-Hash:

- Dùng hàm băm chuyển giá trị cột thành vị trí trong bảng hash
- Tốt với các truy vấn so sánh bằng =

Nhược điểm:
-Tốn bộ nhớ
-Làm giảm hiệu năng các câu lệnh insert, update ,delete

-----------------------PROCEDURES-----------------------

- Lưu trữ câu lệnh SQL giúp bạn sử dụng lại nhiều lần
- Kiểm soát quyền truy cập dễ dàng hơn bằng cách chỉ cho phép người dùng gọi Stored Procedure thay vì truy cập trực tiếp vào bảng dữ liệu
- Đóng gói logic phức tạp trong Stored Procedure giúp giảm sai sót khi thực thi các lệnh SQL thủ công.
- Không thể sử dụng procedure trong câu lệnh select

-----------------------FUNCTION-----------------------

- Được sử dụng để thực hiện một nhiệm vụ cụ thể và trả về kết quả.
- Luôn trả về 1 kết quả, có thể là giá trị hoặc là bảng
- Có thể sử dụng trong câu lệnh SELECT

-----------------------So sánh procedure và function -----------------------

- Procedure:

* Thực hiện các thao tác trong truy vấn
* Không nhất thiết phải trả về giá trị
* Không thể dùng trục tiếp trong câu truy vấn

- Function:

* Thực hiện tính toán hoặc truy vấn dữ liệu
* Phải trả về giá trị
* Có thể dùng trục tiếp trong câu truy vấn

  -----------------------VIEW-----------------------

  - Tạo một “bảng ảo” từ dữ liệu gốc
  - Tái sử dụng các truy vấn phức tạp bằng cách tạo thành 1 table
  - Không làm thay đổi dữ liệu gốc
