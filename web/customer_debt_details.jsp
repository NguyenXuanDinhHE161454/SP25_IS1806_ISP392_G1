<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Customer Debt Details</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
    </head>
    <body>

        <%@include file="/components/header.jsp"%>

        <div id="layoutSidenav">
            <%@include file="/components/sidebar.jsp"%>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Customer Debt Details</h1>

                        <!-- Debt List -->
                        <div class="card mb-4">
                            <div class="card-header">Debt Records for Customer ID: ${customerId}</div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Debt Type</th>
                                            <th>Amount</th>
                                            <th>Note</th>
                                            <th>Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="debt" items="${debtList}">
                                            <tr class="${debt.debtType eq '+' ? 'table-success' : 'table-danger'}">
                                                <td>${debt.debtId}</td>
                                                <td>${debt.debtType}</td>
                                                <td>
                                                    <fmt:formatNumber value="${debt.amount}" type="currency" currencySymbol="VNĐ" />
                                                </td>
                                                <td>${debt.note}</td>
                                                <td>${debt.debtDate}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav>
                                <ul class="pagination">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="DebtController?action=getDebtByCustomer&customerId=${customerId}&page=1&pageSize=${pageSize}">First</a>
                                    </li>
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="DebtController?action=getDebtByCustomer&customerId=${customerId}&page=${currentPage - 1}&pageSize=${pageSize}">Previous</a>
                                    </li>
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="DebtController?action=getDebtByCustomer&customerId=${customerId}&page=${i}&pageSize=${pageSize}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="DebtController?action=getDebtByCustomer&customerId=${customerId}&page=${totalPages}&pageSize=${pageSize}">Last</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>

                        <a href="manage_debt.jsp" class="btn btn-secondary mt-3">Back to Debt List</a>

                    </div>
                </main>

                <%@include file="/components/footer.jsp"%>
            </div>
        </div>

    </body>
</html>
