<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Debt Management</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
    </head>
    <body>

        <%@include file="/components/header.jsp"%>

        <div id="layoutSidenav">
            
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Debt Management</h1>

                        <!-- Search Form -->
                        <form method="get" action="DebtController" class="row g-3 mb-4">
                            <div class="col-md-3">
                                <input type="text" name="phoneNumber" value="${phoneNumber}" class="form-control" placeholder="Search by Phone Number">
                            </div>
                            <div class="col-md-3">
                                <input type="date" name="debtDate" value="${debtDate}" class="form-control">
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-primary w-100">Search</button>
                            </div>
                        </form>

                        <!-- Dropdown chọn số bản ghi trên mỗi trang -->
                        <!--                        <form method="get" action="DebtController" class="mb-3">
                                                    <label for="pageSize">Records per page:</label>
                                                    <select name="pageSize" id="pageSize" class="form-select w-auto d-inline" onchange="this.form.submit()">
                                                        <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
                                                        <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                                                        <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                                                    </select>
                                                    <input type="hidden" name="phoneNumber" value="${phoneNumber}">
                                                    <input type="hidden" name="debtDate" value="${debtDate}">
                                                </form>-->
                        <form method="get" action="DebtController" class="mb-3">
                            <input type="hidden" name="pageSize" value="10">
                            <input type="hidden" name="phoneNumber" value="${phoneNumber}">
                            <input type="hidden" name="debtDate" value="${debtDate}">
                        </form>

                        <!-- Add Debt Button -->
                        <a href="add_debt.jsp" class="btn btn-success mb-3">Add Debt</a>

                        <!-- Debt List -->
                        <div class="card mb-4">
                            <div class="card-header">Debt Records</div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Customer</th>
                                            <th>Phone</th>
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
                                                <td>${debt.customerName}</td>
                                                <td>${debt.phoneNumber}</td>
                                                <td>${debt.debtType}</td>
                                                <td>${debt.amount}</td>
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
                                        <a class="page-link" href="DebtController?page=1&pageSize=${pageSize}&phoneNumber=${phoneNumber}&debtDate=${debtDate}">First</a>
                                    </li>
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="DebtController?page=${currentPage - 1}&pageSize=${pageSize}&phoneNumber=${phoneNumber}&debtDate=${debtDate}">Previous</a>
                                    </li>
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="DebtController?page=${i}&pageSize=${pageSize}&phoneNumber=${phoneNumber}&debtDate=${debtDate}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="DebtController?page=${currentPage + 1}&pageSize=${pageSize}&phoneNumber=${phoneNumber}&debtDate=${debtDate}">Next</a>
                                    </li>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="DebtController?page=${totalPages}&pageSize=${pageSize}&phoneNumber=${phoneNumber}&debtDate=${debtDate}">Last</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>

                        <!-- Back to Home -->
                        <a href="home.jsp" class="btn btn-secondary mt-3">Back to Home</a>

                    </div>
                </main>

                <%@include file="/components/footer.jsp"%>
            </div>
        </div>

        <!-- Confirm Delete Modal -->
        <script>
            function confirmDelete(debtId) {
                if (confirm("Are you sure you want to delete this debt record?")) {
                    window.location.href = "DebtController?action=delete&debtId=" + debtId;
                }
            }
        </script>

    </body>
</html>
