<!DOCTYPE html>
<html lang="vi">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>401 - Không có quyền truy cập</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Arial', sans-serif;
        }
        .error-container {
            text-align: center;
            max-width: 600px;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        .error-code {
            font-size: 5rem;
            font-weight: bold;
            color: #dc3545;
        }
        .error-title {
            font-size: 1.75rem;
            margin-bottom: 20px;
            color: #343a40;
        }
        .error-message {
            font-size: 1.1rem;
            color: #6c757d;
            margin-bottom: 30px;
        }
        .btn-home {
            background-color: #007bff;
            border: none;
            padding: 10px 30px;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }
        .btn-home:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">401</div>
        <h1 class="error-title">Không có quyền truy cập</h1>
        <p class="error-message">
            Xin lỗi, bạn không có quyền truy cập trang này. Vui lòng đăng nhập bằng tài khoản hợp lệ hoặc liên hệ quản trị viên.
        </p>
        <a href="home" class="btn btn-home text-white">Quay lại trang chủ</a>
    </div>

    <!-- Bootstrap JS (Optional, only if you need Bootstrap JS features) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>