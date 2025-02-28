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
            <%@include file="/components/sidebar.jsp"%>
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
                                            <th>Amount</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="debt" items="${debtList}">
                                            <tr>
                                                <td>${debt.debtId}</td>
                                                <td>${debt.customerName}</td>
                                                <td>${debt.phoneNumber}</td>
                                                <td>
                                                    <c:set var="totalAmount" value="0"/>
                                                    <c:forEach var="d" items="${debt.allDebts}">
                                                        <c:set var="totalAmount" value="${totalAmount + d.amount}"/>
                                                    </c:forEach>
                                                    ${totalAmount}
                                                </td>
                                                <td>
                                                    <a href="DebtController?action=detail&phoneNumber=${debt.phoneNumber}" class="btn btn-info">Detail</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Back to Home -->
                        <a href="home.jsp" class="btn btn-secondary mt-3">Back to Home</a>

                    </div>
                </main>

                <%@include file="/components/footer.jsp"%>
            </div>
        </div>

    </body>
</html>
