<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hóa Đơn Xuất</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/invoice.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="js/currencyFormatter.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .invoice-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .invoice-header {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }
        .invoice-details p {
            margin-bottom: 10px;
            font-size: 16px;
        }
        .table thead th {
            background-color: #343a40;
            color: #fff;
        }
        .btn-back {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
        }
        .btn-back:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <%@include file="/components/header.jsp" %>

    <div class="container mt-4">
        <c:if test="${empty invoice}">
            <c:redirect url="error.jsp?msg=Không tìm thấy hóa đơn"/>
        </c:if>

        <h2 class="text-center mb-4">Chi Tiết Hóa Đơn</h2>

        <div class="invoice-card shadow">
            <h5 class="invoice-header">Thông Tin Hóa Đơn</h5>
            <div class="invoice-details">
                <p><strong>Mã Hóa Đơn:</strong> ${invoice.id}</p>
                <p><strong>Ngày Tạo:</strong> ${invoice.createDate}</p>
                <p><strong>Người Tạo:</strong> ${invoice.userName != null ? invoice.userName : "Không xác định"} (ID: ${invoice.createById})</p>
                <p><strong>Khách Hàng:</strong> ${invoice.customerName != null ? invoice.customerName : "Không xác định"} (ID: ${invoice.customerId})</p>
                <p><strong>Tổng Khối Lượng:</strong> 
                    <c:set var="totalWeight" value="${0}"/>
                    <c:forEach var="product" items="${invoice.products}">
                        <c:set var="totalWeight" value="${totalWeight + (product.quantity )}"/>
                    </c:forEach>
                    ${totalWeight} KG
                </p>
                <p><strong>Tổng Thanh Toán:</strong> <fmt:formatNumber value="${invoice.payment}" type="currency" currencySymbol=""/></p>
                <p><strong>Đã Thanh Toán:</strong> <fmt:formatNumber value="${invoice.paidAmount}" type="currency" currencySymbol=""/></p>
                <p><strong>Công Nợ Còn Lại:</strong> <fmt:formatNumber value="${invoice.debtAmount}" type="currency" currencySymbol=""/></p>
                
                <p><strong>Loại Hóa Đơn:</strong> ${invoice.type == 1 ? "Nhập hàng" : "Xuất hàng"}</p>
            </div>
        </div>

        <h3 class="mt-4">Danh Sách Sản Phẩm</h3>
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>Mã Sản Phẩm</th>
                    <th>Số Lượng (Bao)</th>
                    <th>Khối Lượng/Bao (KG)</th>
                    <th>Tổng Khối Lượng (KG)</th>
                    <th>Giá</th>
                    <th>Thành Tiền</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${invoice.products}">
                    <tr>
                        <td>${product.productId}</td>
                        <td>${product.quantity / product.amountPerKg}</td>
                        <td>${product.amountPerKg}</td>
                        <td>${product.quantity }</td>
                        <td><fmt:formatNumber value="${product.unitPrice}" type="currency" currencySymbol=""/></td>
                        <td><fmt:formatNumber value="${product.totalPrice}" type="currency" currencySymbol=""/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <a href="dashboard" class="btn btn-back mt-3">Quay Lại Trang Chủ</a>
    </div>

    <script src="js/invoices/create.js"></script>
    <script src="js/currencyFormatter.js"></script>
</body>
</html>