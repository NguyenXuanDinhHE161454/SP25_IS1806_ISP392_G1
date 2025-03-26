<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Add New Debt</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <style>
            .form-label {
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <%@include file="/components/header.jsp"%>

        <div id="layoutSidenav">
            <%@include file="/components/sidebar.jsp"%>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Thêm khoản nợ mới</h1>

                        <!-- Customer Information -->
                        <div class="card mb-4">
                            <div class="card-header">Thông tin khách hàng</div>
                            <div class="card-body">
                                <form action="DebtCustomerController" method="get" class="row g-3">
                                    <div class="col-md-4">
                                        <label for="customerId" class="form-label">ID khách hàng:</label>
                                        <input type="text" id="customerId" class="form-control" value="${customer.customerId}" readonly>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="fullName" class="form-label">Tên khách hàng:</label>
                                        <input type="text" id="fullName" class="form-control" value="${customer.fullName}" readonly>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="phoneNumber" class="form-label">Số điện thoại:</label>
                                        <input type="text" id="phoneNumber" class="form-control" value="${customer.phoneNumber}" readonly>
                                    </div>
                                    <div class="col-md-12">
                                        <label for="address" class="form-label">Địa chỉ:</label>
                                        <input type="text" id="address" class="form-control" value="${customer.address}" readonly>
                                    </div>
                                    <div class="col-md-3 d-flex align-items-end">
                                        <a href="DebtCustomerController?action=detail&id=${customer.customerId}" class="btn btn-secondary me-2">Trở về</a>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Debt Form -->
                        <div class="card mb-4">
                            <div class="card-header">Thông tin khoản nợ</div>
                            <div class="card-body">
                                <form action="DebtCustomerController" method="post" class="row g-3">
                                    <input type="hidden" name="action" value="save">
                                    <input type="hidden" name="customerId" value="${customer.customerId}">
                                    <div class="col-md-6">
                                        <label for="debtType" class="form-label">Loại khoản nợ:</label>
                                        <select id="debtType" name="debtType" class="form-select" required>
                                            <option value="1">Khách vay nợ</option>
                                            <option value="2">Khách trả nợ</option>
                                            <option value="3">Cửa hàng trả nợ</option>
                                            <option value="4">Cửa hàng vay trả</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="amount" class="form-label">Số tiền (VNĐ):</label>
                                        <input type="number" id="amount" name="amount" class="form-control" min="0" step="1000" required>
                                    </div>
                                    <div class="col-md-12">
                                        <label for="note" class="form-label">Ghi chú:</label>
                                        <textarea id="note" name="note" class="form-control" rows="3"></textarea>
                                    </div>
                                    <div class="col-md-12">
                                        <label for="evident" class="form-label">Bảng chứng:</label>
                                        <input type="text" id="evident" name="evident" class="form-control">
                                    </div>
                                    <div class="col-md-12 d-flex justify-content-end">
                                        <button type="submit" class="btn btn-primary">Lưu khoản nợ</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
                <%@include file="/components/footer.jsp"%>
            </div>
        </div>
    </body>
</html>