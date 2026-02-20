# 📖 KuJiTool – Ứng dụng đọc truyện tranh

KuJiTool là một ứng dụng **đọc truyện tranh online** được xây dựng bằng **Flutter**, hỗ trợ đa nền tảng (Web / Mobile), tập trung vào trải nghiệm đọc mượt mà, quản lý tiến trình đọc và tương tác người dùng.

---

## 🚀 Tính năng chính

- 📚 Đọc truyện tranh KuJiTool
- 🌐 Sử dụng **API bên thứ 3** để lấy dữ liệu truyện, chapter, hình ảnh
- 🔐 Quản lý người dùng với **Firebase**
- 💬 Hệ thống **comment** cho từng truyện / chapter
- 👁️ Theo dõi **lượt xem (view count)** mỗi khi người dùng đọc
- ⏱️ Lưu **tiến trình đọc** (đọc từ đầu / đọc tiếp)
- 🔄 Hỗ trợ reload trang trên **Flutter Web** mà không mất dữ liệu
- 🔒 Mã hóa Base64 dữ liệu nhạy cảm khi truyền qua query string

---

## 🏗️ Kiến trúc & Design Pattern

Dự án tuân thủ **BLoC Architecture (Business Logic Component)** nhằm đảm bảo:

- Separation of Concerns
- Dễ mở rộng, dễ test, dễ bảo trì
- Phù hợp cho project Flutter quy mô vừa và lớn

---

## 🔄 Data Flow (BLoC)

UI → Bloc / Cubit → UseCase → Repository → DataSource

---

## 🔐 Firebase sử dụng cho

- Auth
- User
- Comment
- View count
- Trạng thái đọc

---

## 🧾 Phiên bản môi trường

Flutter 3.38.6  
Dart 3.10.7  
DevTools 2.51  

---

## ⚠️ Lưu ý bảo mật

Base64 chỉ dùng để che dữ liệu, **không phải mã hóa bảo mật**.
