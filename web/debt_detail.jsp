<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Debt Details</title>
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
                        <h1 class="mt-4">Chi tiết công nợ</h1>

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
                                        <a href="DebtCustomerController" class="btn btn-secondary me-2">Trở về</a>
                                        <a href="DebtCustomerController?action=add&id=${customer.customerId}" class="btn btn-primary">Thêm đơn nợ mới</a>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Debt Details Table -->
                        <div class="card mb-4">
                            <div class="card-header">Danh sách công nợ</div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${empty debts}">
                                        <div class="alert alert-info text-center" role="alert">
                                            Không có khoản nợ nào.
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Ngày tạo</th>
                                                    <th>Chi Tiết</th>
                                                    <th>Ghi chú</th>
                                                    <th>Số tiền</th>
                                                    <th>Dư nợ</th>
                                                    <th>Người tạo</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="debt" items="${debts}" varStatus="loop">
                                                    <tr>
                                                        <td>${(currentPage - 1) * pageSize + loop.count}</td>
                                                        <td>${debt.debtDate.toString().substring(0,10)}</td>
                                                        <td>${debt.description}</td>
                                                        <td>${not empty debt.evident ? debt.evident : 'N/A'}</td>
                                                        <td><fmt:formatNumber value="${debt.amount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${loop.count == 1 && currentPage == 1}">
                                                                    <fmt:formatNumber value="${debt.debtType == 1 ? debt.amount : -debt.amount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <fmt:formatNumber value="${prevOutstanding + (debt.debtType == 1 ? debt.amount : -debt.amount)}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:set var="creatorFound" value="false" />
                                                            <c:forEach var="user" items="${users}">
                                                                <c:if test="${user.userId == debt.createdBy}">
                                                                    <c:out value="${user.fullName}" />
                                                                    <c:set var="creatorFound" value="true" />
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${!creatorFound}">N/A</c:if>
                                                            </td>
                                                        </tr>
                                                    <c:set var="prevOutstanding" value="${loop.count == 1 && currentPage == 1 ? (debt.debtType == 1 ? debt.amount : -debt.amount) : prevOutstanding + (debt.debtType == 1 ? debt.amount : -debt.amount)}" />
                                                </c:forEach>
                                            </tbody>
                                        </table>

                                        <!-- Pagination -->
                                        <nav aria-label="Page navigation">
                                            <ul class="pagination justify-content-center">
                                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                    <a class="page-link" href="DebtCustomerController?action=detail&id=${customer.customerId}&page=${currentPage - 1}">Previous</a>
                                                </li>
                                                <c:forEach begin="1" end="${totalPages}" var="i">
                                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                        <a class="page-link" href="DebtCustomerController?action=detail&id=${customer.customerId}&page=${i}">${i}</a>
                                                    </li>
                                                </c:forEach>
                                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                    <a class="page-link" href="DebtCustomerController?action=detail&id=${customer.customerId}&page=${currentPage + 1}">Next</a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </main>
                <%@include file="/components/footer.jsp"%>
            </div>
        </div>
    </body>
</html>