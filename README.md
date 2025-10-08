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

-----------------------TRIGGER-----------------------

- Là một đọn thủ tục được thực thi tự động khi một sự kiện cụ thể
  xảy ra trên bảng

- Ưu điểm:

* Có thể bắt lỗi logic
* Kiểm soát những thay đổi của dữ liệu trong bảng

- Nhược điểm:

* Nếu logic của trigger phức tạp, có thể làm giảm hiệu năng
* Trigger tự động chạy, nên khó hiểu soát và sửa nếu có lỗi
* Không thể thay thế được hoàn toàn phần logic của ứng dụng,
  chỉ dừng lại ở phần logic của Database

  -----------------------Transaction-----------------------
  Là một nhóm các câu lệnh SQL. Nếu một transaction được thực hiện thành công, tất cả các thay đổi dữ liệu được thực hiện được lưu vào cơ sở dữ liệu. Nếu một transaction bị lỗi và được rollback, thì tất cả các sửa đổi dữ liệu sẽ bị xóa (dữ liệu được khôi phục về trạng thái trước khi thực hiện transaction)
  -Đảm bảo tính toàn vẹn của dữ liệu (ACID):

  - Atomicity (tính nguyên tử): Một là tiến trình sẽ thành công, 2 là sẽ
    chẳng có sự thay đổi nào về dữ liệu nếu gặp sự cố
    Ví dụ: A chuyển tiền cho B. Nếu thành công thì tài khoản của A bị trừ tiền và tài khoản của B được cộng số tiền tương ứng. Nếu 1 trong 2 quá
    trình gặp vấn đề thì hệ thống sẽ rollback lại toàn bộ, A không bị trừ tiền và B không được cộng tiền

  - Consistency (tính nhất quán): Dữ liệu luôn phải tuân thủ những ràng buộc của CSDL
    Ví dụ: Ví dụ chỉ còn 50 trong tài khoản, nhưng thực hiện giao dịch -70, sau khi tính toán thì lưu số âm, thì đó là không nhất quán => Sẽ không được commit

  - Isolation (tính độc lập): Đảm bảo các giao dịch thực hiện đồng thời sẽ không bị ảnh hưởng lẫn nhau.
    Ví dụ: Tài khoản có 50 , nếu cả A và B đồng thời thực hiện rút tiền => vi phạm tính độc lập. Lúc nào thì các giao dịch sẽ xử lý tuần tự, nếu ai thực hiện trước thì người sau sẽ ở trạng thái chờ.

  - Durability (tính bền vững): Đảm bảo rằng một khi một giao dịch đã được xác nhận thành công, các thay đổi mà nó thực hiện đối với cơ sở dữ liệu sẽ là vĩnh viễn và không bị mất. Điều này đúng ngay cả khi hệ thống gặp phải sự cố đột ngột sau đó, như mất điện, sập server, hoặc lỗi phần cứng.

  -----------------------Locks-----------------------

- Là cơ chế mà database sử dụng để kiểm soát việc truy cập vào các tài nguyên như bảng, hàng, hoặc trang dữ liệu khi có nhiều transaction đang thực hiện đồng thời đảm bảo rằng các phiên (session) không đọc hoặc ghi vào các tài nguyên đang được giao dịch khác sử dụng.

* Lock cấp độ hàng (Row Lock): Khóa 1 row dữ liệu.
* Lock cấp độ trang (Page Lock): Khóa 1 page dữ liệu (bao gồm nhiều row).
* Lock cấp độ bảng (Table Lock): Khóa toàn bộ bảng dữ liệu.
* Lock cấp độ database (Database Lock): Khóa database.
