<%-- 
    Document   : customer_debt_manager
    Created on : Mar 16, 2025, 12:39:01 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Quản lý khách hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="css/styles.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="/components/header.jsp"%>

        <div id="layoutSidenav">
            <%@include file="/components/sidebar.jsp"%>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Quản lý khách hàng</h1>

                        <!-- Hiển thị thông báo thành công/lỗi -->
                        <c:if test="${not empty sessionScope.message}">
                            <div class="alert alert-${sessionScope.messageType} alert-dismissible fade show" role="alert">
                                ${sessionScope.message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <!-- Xóa thông báo sau khi hiển thị -->
                            <c:remove var="message" scope="session"/>
                            <c:remove var="messageType" scope="session"/>
                        </c:if>

                        <!-- Form tìm kiếm -->
                        <div class="card mb-4">
                            <div class="card-header">Danh sách nợ của khách hàng</div>
                            <div class="card-body">
                                <form action="CustomerDebtController" method="GET" class="row g-3">
                                    <div class="col-auto">
                                        <input type="text" class="form-control" name="fullName" value="${searchFullName != null ? searchFullName : ''}" placeholder="Tên khách hàng">
                                    </div>
                                    <div class="col-auto">
                                        <input type="text" class="form-control" name="phoneNumber" value="${searchPhone != null ? searchPhone : ''}" placeholder="Số điện thoại">
                                    </div>
                                    <div class="col-auto">
                                        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                                    </div>
                                </form>
                            </div>

                            <!-- Bảng dữ liệu -->
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Tên khách hàng</th>
                                            <th>Số điện thoại</th>
                                            <th>Địa chỉ</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${customerDebtList}" var="dto">
                                            <tr>
                                                <td>${dto.fullName}</td>
                                                <td>${dto.phoneNumber != null ? dto.phoneNumber : ''}</td>
                                                <td>${dto.address != null ? dto.address : ''}</td>
                                                
                                                <td>
                                                    <a href="CustomerDebtController?action=updateCustomer&customerId=${dto.customerId}" class="btn btn-sm btn-primary">Cập nhật</a>
                                                    <a href="CustomerDebtController?action=deleteCustomer&customerId=${dto.customerId}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa khách hàng này không?')">Xóa</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <!-- Phân trang -->
                                <nav aria-label="Phân trang">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="CustomerDebtController?page=${currentPage - 1}${searchFullName != null ? '&fullName=' : ''}${searchFullName}${searchPhone != null ? '&phoneNumber=' : ''}${searchPhone}">Trước</a>
                                        </li>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="CustomerDebtController?page=${i}${searchFullName != null ? '&fullName=' : ''}${searchFullName}${searchPhone != null ? '&phoneNumber=' : ''}${searchPhone}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="CustomerDebtController?page=${currentPage + 1}${searchFullName != null ? '&fullName=' : ''}${searchFullName}${searchPhone != null ? '&phoneNumber=' : ''}${searchPhone}">Tiếp theo</a>
                                        </li>
                                    </ul>
                                </nav>

                                <!-- Form thêm khách hàng mới -->
                                <div class="card mt-4">
                                    <div class="card-header">Thêm khách hàng mới</div>
                                    <div class="card-body">
                                        <form action="CustomerDebtController" method="POST">
                                            <input type="hidden" name="action" value="createCustomer">
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <label for="fullName" class="form-label">Tên khách hàng</label>
                                                    <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Nhập tên khách hàng" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="phoneNumber" class="form-label">Số điện thoại</label>
                                                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Nhập số điện thoại">
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="address" class="form-label">Địa chỉ</label>
                                                    <input type="text" class="form-control" id="address" name="address" placeholder="Nhập địa chỉ">
                                                </div>
                                                <div class="col-12">
                                                    <button type="submit" class="btn btn-success">Thêm khách hàng</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <%@include file="/components/footer.jsp"%>
            </div>
        </div>
    </body>
</html>