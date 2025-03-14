<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Debt Management</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <style>
            .table th, .table td {
                text-align: center;
                vertical-align: middle;
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
                        <h1 class="mt-4">Quản lí công nợ</h1>

                        <!-- Search form -->
                        <div class="card mb-4">
                            <div class="card-header">Danh sách công nợ</div>
                            <div class="card-body">
                                <form action="DebtCustomerController" method="get" class="row g-3">
                                    <div class="col-md-9">
                                        <label for="keyword" class="form-label">Tên khách hàng:</label>
                                        <input type="text" name="keyword" id="keyword" class="form-control" value="${keyword}" placeholder="Nhập tên khách hàng">
                                    </div>
                                    <div class="col-md-3 d-flex align-items-end">
                                        <button type="submit" class="btn btn-primary me-2">Tìm kiếm</button>
                                        <a href="DebtCustomerController" class="btn btn-secondary">Xóa</a>
                                    </div>
                                </form>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>ID tên khách</th>
                                            <th>Tên Khách Hàng</th>
                                            <th>Số điện thoại</th>
                                            <th>Địa chỉ</th>
                                            <th>Dư nợ</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="summary" items="${debtSummaries}">
                                            <tr>
                                                <td>${summary.customerId}</td>
                                                <td>${summary.fullName}</td>
                                                <td>${summary.phoneNumber}</td>
                                                <td>${summary.address}</td>
                                                <td><fmt:formatNumber value="${summary.debtAmount - summary.amountPaid}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></td>
                                                <td>
                                                    <a href="DebtCustomerController?action=detail&id=${summary.customerId}" class="btn btn-sm btn-primary">Chi tiết</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <!-- Pagination -->
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="DebtCustomerController?page=${currentPage - 1}&keyword=${keyword}">Trước</a>
                                        </li>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="DebtCustomerController?page=${i}&keyword=${keyword}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="DebtCustomerController?page=${currentPage + 1}&keyword=${keyword}">Sau</a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </main>
                <%@include file="/components/footer.jsp"%>
            </div>
        </div>

    </body>
</html>