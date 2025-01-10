### Currency Converter

## 1 Mô tả cấu trúc ứng dụng.

# Mục đích
Ứng dụng giúp người dùng chuyển đổi tiền tệ giữa các quốc gia, tự động cập nhật tỷ giá và kiểm tra điều kiện hợp lệ khi nhập liệu.

# Chức năng chính
-Nhập số tiền: Hỗ trợ định dạng số hợp lệ, không cho phép số âm và ký tự không phải số.
-Chọn đơn vị tiền tệ: Người dùng chọn đơn vị tiền từ danh sách (USD, VND, EUR, GBP,...).
-Chuyển đổi tiền tệ: Tính toán kết quả chuyển đổi dựa trên tỷ giá hiện tại.
-Đổi vị trí tiền tệ: Đổi vị trí "From Currency" ↔ "To Currency".
-Hiển thị kết quả: Số tiền sau khi chuyển đổi và đơn vị tiền tệ đích.
# Cấu trúc ứng dụng
-Frontend (UI)
+Ngôn ngữ: Flutter (Dart)
-Thư viện:
    +flutter_dotenv: ^5.2.1: Quản lý các biến môi trường trong Flutter, lưu trữ API keys và thông tin cấu hình trong tệp .env.
    +flutter_spinkit: ^5.2.1: Cung cấp các hiệu ứng loading spinner đẹp mắt và dễ sử dụng trong Flutter.
    +http: ^1.2.2: Gửi yêu cầu HTTP (GET, POST, PUT, DELETE, ...) từ Flutter đến các API hoặc dịch vụ web.
    +google_fonts: ^6.2.1: Dễ dàng sử dụng các phông chữ Google Fonts trong Flutter mà không cần tải phông chữ thủ công.
-Màn hình chính:
    +Nhập số tiền, chọn loại tiền tệ nguồn và đích.
    +Nút chuyển đổi tiền tệ và nút "Swap" đổi vị trí hai loại tiền tệ.
    +Hiển thị kết quả chuyển đổi.
    +Backend (Logic & API)
-Tính năng:
    +Gọi API bên thứ ba ExchangeRateAPI để lấy tỷ giá.
    +Kiểm tra dữ liệu đầu vào: số tiền phải lớn hơn 0, tiền "VND" phải là số nguyên, và hai loại tiền tệ không trùng nhau.
-Công nghệ:
    +Logic xử lý tính toán bằng Dart.
    +Gọi API qua thư viện http.
    +Kiểm tra dữ liệu nhập
    +Đảm bảo số tiền hợp lệ và lớn hơn 0.
    +Kiểm tra định dạng tiền tệ đầu vào.
    +Kiểm tra "From Currency" và "To Currency" khác nhau.
    +Đảm bảo "VND" phải là số nguyên.
    +Xử lý lỗi nếu API không trả về kết quả hoặc gặp lỗi mạng.

# Cấu trúc thư mục
lib/
├── main.dart                                # Điểm khởi đầu của ứng dụng
├── screens/
│   ├── currency_converter_screen.dart       # Màn hình chính chuyển đổi tiền tệ
├── services/
│   ├── currency_converter.dart              # Lớp gọi API lấy tỷ giá hối đoái

## 2 Hướng dẫn xây dựng và chạy ứng dụng.

# 1 Cài đặt Flutter:

Tải và cài đặt Flutter SDK từ trang chính của Flutter.
Đảm bảo rằng đã cài đặt Android Studio hoặc VS Code và cấu hình môi trường phát triển Flutter.
# 2 Cài đặt các phụ thuộc:

bước 1 Mở terminal hoặc command prompt và di chuyển đến thư mục dự á.

bước 2 Chạy lệnh sau để cài đặt tất cả các gói phụ thuộc: flutter pub get

bước 3 Cấu hình Key API
    1. Truy cập trang web https://www.exchangerate-api.com và tạo tài khoản.
    2. Sau khi đăng ký, trang web sẽ cung cấp cho bạn một API key.
    3. Tạo tệp .env trong thư mục root/assets/ của dự án.
    4. Mở tệp .env và thêm dòng sau để lưu API key: API_KEY=your_api_key_here

bước 4 Chạy ứng dụng trên thiết bị giả lập hoặc thật:
    +Kết nối thiết bị thật qua USB hoặc mở thiết bị giả lập (Android Emulator/iOS Simulator).
    +Lưu ý: Đảm bảo rằng chế độ nhà phát triển (Developer Mode) đã được bật trên thiết bị thật.

bước 5 Chạy ứng dụng bằng lệnh:
    +flutter run

bước 6 Xây dựng ứng dụng cho release:
    +flutter build apk    # cho Android
    +flutter build ios    # cho iOS
bước 7 Kiểm tra ứng dụng:

    +Sau khi ứng dụng chạy, kiểm tra các chức năng chính như chuyển đổi tiền tệ, nhập liệu và hiển thị kết quả.

## 3 Ghi chú hoặc thách thức gặp phải.

# Thách thức với ExchangeRate API:

Giới hạn truy vấn: Phiên bản miễn phí của ExchangeRate API chỉ cho phép tối đa 1.500 lần gọi mỗi tháng. Nếu cần nhiều lượt truy vấn, có thể tối ưu hóa hoặc nâng cấp lên phiên bản trả phí.

# Ghi chú

Dù em không được chọn, em vẫn rất mong nhận được phản hồi về ứng dụng của mình. Dù chỉ là một sản phẩm nhỏ, nhưng em đã dành rất nhiều thời gian và tâm huyết để thực hiện. Những ý kiến đóng góp của anh/chị sẽ giúp em trưởng thành và cải thiện hơn nữa. Em xin cảm ơn!