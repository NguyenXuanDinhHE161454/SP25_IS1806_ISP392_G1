<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Transaction Management</title>
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
                    <h1 class="mt-4">Transaction Management</h1>

                    <!-- Search Form -->
                    <form method="get" action="PaymentController" class="row g-3 mb-4">
                        <div class="col-md-3">
                            <input type="text" name="customerName" value="${customerName}" class="form-control" placeholder="Search by Customer Name">
                        </div>
                        <div class="col-md-3">
                            <input type="text" name="phoneNumber" value="${phoneNumber}" class="form-control" placeholder="Search by Phone Number">
                        </div>
                        <div class="col-md-3">
                            <input type="date" name="transactionDate" value="${transactionDate}" class="form-control">
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">Search</button>
                        </div>
                    </form>

                    <!-- Dropdown chọn số bản ghi trên mỗi trang -->
                    <form method="get" action="PaymentController" class="mb-3">
                        <label for="pageSize">Records per page:</label>
                        <select name="pageSize" id="pageSize" class="form-select w-auto d-inline" onchange="this.form.submit()">
                            <option value="2" ${pageSize == 2 ? 'selected' : ''}>2</option>
                            <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
                            <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                            <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                        </select>
                        <input type="hidden" name="customerName" value="${customerName}">
                        <input type="hidden" name="phoneNumber" value="${phoneNumber}">
                        <input type="hidden" name="transactionDate" value="${transactionDate}">
                    </form>

                    <div class="card mb-4">
                        <div class="card-header">Transaction List</div>
                        <div class="card-body">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Type</th>
                                        <th>Rice</th>
                                        <th>Customer</th>
                                        <th>Phone</th>
                                        <th>Quantity</th>
                                        <th>Date</th>
                                        <th>Porter</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="transaction" items="${transactionList}">
                                        <tr>
                                            <td>${transaction.transactionId}</td>
                                            <td>${transaction.transactionType}</td>
                                            <td>${transaction.riceName}</td>
                                            <td>${transaction.customerName}</td>
                                            <td>${transaction.phoneNumber}</td>
                                            <td>${transaction.quantity}</td>
                                            <td>${transaction.transactionDate}</td>
                                            <td>${transaction.porterService ? 'Yes' : 'No'}</td>
                                            <td>${transaction.totalAmount}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Phân trang -->
                    <c:if test="${totalPages > 1}">
                        <nav>
                            <ul class="pagination">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="PaymentController?page=1&pageSize=${pageSize}&customerName=${customerName}&phoneNumber=${phoneNumber}&transactionDate=${transactionDate}">First</a>
                                </li>

                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="PaymentController?page=${currentPage - 1}&pageSize=${pageSize}&customerName=${customerName}&phoneNumber=${phoneNumber}&transactionDate=${transactionDate}">Previous</a>
                                </li>

                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="PaymentController?page=${i}&pageSize=${pageSize}&customerName=${customerName}&phoneNumber=${phoneNumber}&transactionDate=${transactionDate}">${i}</a>
                                    </li>
                                </c:forEach>

                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="PaymentController?page=${currentPage + 1}&pageSize=${pageSize}&customerName=${customerName}&phoneNumber=${phoneNumber}&transactionDate=${transactionDate}">Next</a>
                                </li>

                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="PaymentController?page=${totalPages}&pageSize=${pageSize}&customerName=${customerName}&phoneNumber=${phoneNumber}&transactionDate=${transactionDate}">Last</a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>

                </div>
            </main>

            <%@include file="/components/footer.jsp"%>
        </div>
    </div>
</body>
</html>
