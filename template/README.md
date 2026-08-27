# Template Mẫu Java Web Servlet JDBC 3 Tầng (MVC)

Dự án mẫu chuẩn kiến trúc MVC 3 tầng (Model - DAO - Service - Controller - View) sử dụng **Jakarta Servlet 6.0**, **JSP/JSTL 3.0**, **Apache Tomcat 11** và **Microsoft SQL Server**.

---

## 📁 1. Cấu trúc thư mục

```
template/
├── pom.xml                                   # Cấu hình Maven (Jakarta Servlet, JSTL, SQL Server JDBC)
├── database.sql                              # Script SQL khởi tạo CSDL mẫu
├── README.md                                 # Hướng dẫn sử dụng template
├── src/main/java/com/koha/
│   ├── model/                                # Chứa các đối tượng dữ liệu (Entity/Model)
│   │   ├── UserModel.java
│   │   └── Category.java
│   ├── dao/                                  # Tầng truy cập CSDL (JDBC PreparedStatement)
│   │   ├── DBConnection.java                 # Cấu hình chuỗi kết nối SQL Server
│   │   ├── UserDao.java & UserDaoImpl.java
│   │   └── CategoryDao.java & CategoryDaoImpl.java
│   ├── service/                              # Tầng xử lý logic nghiệp vụ
│   │   ├── UserService.java & UserServiceImpl.java
│   │   └── CategoryService.java & CategoryServiceImpl.java
│   ├── controller/                           # Tầng điều hướng (Jakarta HttpServlet)
│   │   ├── HomeController.java               # (/home, /)
│   │   ├── LoginController.java              # Đăng nhập với Session & Cookie (/login)
│   │   ├── LogoutController.java             # Đăng xuất (/logout)
│   │   ├── ErrorController.java              # Trang lỗi (/error)
│   │   ├── CategoryListController.java       # Liệt kê & tìm kiếm (/admin/category/list)
│   │   ├── CategoryAddController.java        # Thêm mới + upload ảnh (/admin/category/add)
│   │   ├── CategoryEditController.java       # Sửa + đổi ảnh (/admin/category/edit)
│   │   ├── CategoryDeleteController.java     # Xóa danh mục (/admin/category/delete)
│   │   └── DownloadImageController.java      # Hiển thị ảnh (/image?fname=...)
│   └── util/
│       └── Constant.java                     # Thư mục lưu trữ upload ("D:/upload")
└── src/main/webapp/
    ├── WEB-INF/
    │   └── web.xml                           # Cấu hình web application & session timeout
    └── views/
        ├── index.jsp                         # Trang chủ
        ├── login.jsp                         # Trang đăng nhập (có Remember Me Cookie)
        ├── error.jsp                         # Trang lỗi
        └── admin/
            ├── list-category.jsp             # Bảng CRUD danh mục + Tìm kiếm
            ├── add-category.jsp              # Form Thêm mới + Preview ảnh
            └── edit-category.jsp             # Form Chỉnh sửa + Preview ảnh
```

---

## 🚀 2. Các chức năng có sẵn trong Template

1. **Xác thực & Phiên làm việc (Authentication & Session Tracking)**:
   - **Login với Session**: Lưu đối tượng người dùng vào `HttpSession`, bảo vệ trang và hiển thị thông tin đăng nhập.
   - **Ghi nhớ đăng nhập (Cookie Remember Me)**: Tự động lưu Cookie `username` 7 ngày và tự điền lại vào form đăng nhập.
   - **Đăng xuất**: Hủy `HttpSession` và dọn dẹp trạng thái.
2. **CRUD dữ liệu hoàn chỉnh (Create - Read - Update - Delete - Search)**:
   - Đầy đủ 5 thao tác cơ bản: Xem danh sách, Thêm mới, Sửa, Xóa (kèm hộp thoại xác nhận), và Tìm kiếm theo từ khóa.
3. **Upload & Xem trước hình ảnh (File Upload)**:
   - Xử lý upload file với chuẩn `@MultipartConfig` + `req.getPart()`.
   - Servlet `/image?fname=...` stream dữ liệu ảnh trực tiếp ra trình duyệt, có fallback SVG nếu thiếu file.
   - JavaScript Client-side xem trước ảnh ngay khi chọn file.
4. **Giao diện hiện đại (Bootstrap 5)**:
   - Thiết kế đẹp mắt, chuẩn responsive, sẵn sàng cho việc mở rộng thêm các bảng khác.

---

## 🛠️ 3. Cách sao chép & sử dụng Template cho bài tập mới

Khi có bài tập mới (ví dụ `bt26082026` hoặc `project_ban_hang`):

1. **Copy thư mục `template`** thành tên thư mục mới (ví dụ: `bt26082026`).
2. **Mở file `pom.xml`**:
   - Đổi `<artifactId>template</artifactId>` thành tên bài mới (ví dụ: `<artifactId>bt26082026</artifactId>`).
   - Đổi `<finalName>template</finalName>` thành tên bài mới.
3. **Mở file `DBConnection.java`**:
   - Cập nhật tên Database `databaseName=...` và mật khẩu nếu cần.
4. **Mở file `web.xml`**:
   - Đổi `<display-name>template</display-name>` thành tên bài mới.
5. **Thêm các Model / DAO / Service / Controller / View mới**:
   - Nhân bản từ `Category` sang các đối tượng mới (ví dụ `Product`, `Order`, `Account`,...).
