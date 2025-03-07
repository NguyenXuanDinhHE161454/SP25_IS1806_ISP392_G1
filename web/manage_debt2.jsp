<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Customer Debt List</title>
        <link href="css/styles.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="/components/header.jsp"%>

        <div id="layoutSidenav">

            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Customer Debt List</h1>
                        <!-- Search Form -->
                        <form method="get" action="DebtController2" class="row g-3 mb-4">
                            <div class="col-md-3">
                                <input type="text" name="phoneNumber" value="${phoneNumber}" class="form-control" placeholder="Search by Phone Number">
                            </div>
                            <div class="col-md-3">
                                <input type="text" name="customerName" value="${customerName}" class="form-control" placeholder="Search by Customer Name">
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-primary w-100">Search</button>
                            </div>
                        </form>
                         
                            <!-- Add Debt Button -->
                        <a href="add_debt.jsp" class="btn btn-success mb-3">Add Debt</a>

                        
                        <form method="get" action="DebtController2" class="mb-3">
                            <input type="hidden" name="pageSize" value="10">
                            <input type="hidden" name="phoneNumber" value="${phoneNumber}">
                            <input type="hidden" name="debtDate" value="${debtDate}">
                        </form>

                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Customer ID</th>
                                    <th>Customer Name</th>
                                    <th>Phone</th>
                                    <th>Total debt</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="customer" items="${customerList}">
                                    <tr>
                                        <td>${customer.customerId}</td>
                                        <td>${customer.fullName}</td>
                                        <td>${customer.phoneNumber}</td>
                                        <td>
                                            <c:set var="totalDebt" value="${customerDebtTotals[customer.customerId]}" />
                                            ${totalDebt != null ? totalDebt : "0"}
                                        </td>
                                        <td>
                                            <a href="DebtController?phoneNumber=${customer.phoneNumber}" class="btn btn-info">Detail</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <a href="home.jsp" class="btn btn-secondary mt-3">Back to Home</a>
                    </div>
                </main>

                <%@include file="/components/footer.jsp"%>
            </div>
        </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    </body>
</html>