<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="utils.EnumHelper" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Invoice Management - Warehouse Rice Dashboard</title>
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
                        <h1 class="mt-4">Invoice Management</h1>

                        <!-- Bộ lọc tìm kiếm -->
                        <form method="get" action="InvoiceController" class="row g-3 mb-3">
                            <div class="col-md-3">
                                <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Search Invoice">
                            </div>
                            <div class="col-md-3">
                                <input type="datetime-local" name="fromDate" value="${fromDate}" class="form-control">
                            </div>
                            <div class="col-md-3">
                                <input type="datetime-local" name="toDate" value="${toDate}" class="form-control">
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">Search</button>
                            </div>
                        </form>

                        <!-- Chọn số bản ghi trên mỗi trang -->
                        <form method="get" action="InvoiceController" class="mb-3">
                            <label for="pageSize">Records per page:</label>
                            <select name="pageSize" id="pageSize" class="form-select w-auto d-inline" onchange="this.form.submit()">
                                <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
                                <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                                <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                            </select>
                            <input type="hidden" name="keyword" value="${keyword}">
                            <input type="hidden" name="fromDate" value="${fromDate}">
                            <input type="hidden" name="toDate" value="${toDate}">
                        </form>

                        <!-- Danh sách hóa đơn -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i> Invoice List
                                <a href="create-invoice.jsp" class="btn btn-success btn-sm float-end">
                                    <i class="fas fa-plus"></i> New Invoice
                                </a>
                            </div>
                            <div class="card-body">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Create Date</th>
                                            <th>Customer</th>
                                            <th>User</th>
                                            <th>Payment</th>
                                            <th>Type</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="invoice" items="${invoiceList}">
                                            <tr>
                                                <td>${invoice.id}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${invoice.createDate != null}">
                                                            ${invoice.createDate}
                                                        </c:when>
                                                        <c:otherwise>N/A</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${invoice.customerName} (#${invoice.customerId})</td>
                                                <td>${invoice.userName} (#${invoice.userId})</td>
                                                <td>${invoice.payment}</td>
                                                <td>
                                                    ${EnumHelper.getInvoiceStatusDescription(invoice.type)}</td>
                                                </td>
                                                <td>
                                                    <a href="InvoiceDetailController?invoiceId=${invoice.id}" class="btn btn-primary btn-sm">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="invoice-edit.jsp?id=${invoice.id}" class="btn btn-warning btn-sm">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button onclick="confirmDelete(${invoice.id})" class="btn btn-danger btn-sm">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </td>
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
                                        <a class="page-link" href="InvoiceController?page=1&pageSize=${pageSize}&keyword=${keyword}&fromDate=${fromDate}&toDate=${toDate}">First</a>
                                    </li>

                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="InvoiceController?page=${currentPage - 1}&pageSize=${pageSize}&keyword=${keyword}&fromDate=${fromDate}&toDate=${toDate}">Previous</a>
                                    </li>

                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="InvoiceController?page=${i}&pageSize=${pageSize}&keyword=${keyword}&fromDate=${fromDate}&toDate=${toDate}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="InvoiceController?page=${currentPage + 1}&pageSize=${pageSize}&keyword=${keyword}&fromDate=${fromDate}&toDate=${toDate}">Next</a>
                                    </li>

                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="InvoiceController?page=${totalPages}&pageSize=${pageSize}&keyword=${keyword}&fromDate=${fromDate}&toDate=${toDate}">Last</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>

                    </div>
                </main>

                <%@include file="/components/footer.jsp"%>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
        <script src="js/scripts.js"></script>
    </body>
</html>
