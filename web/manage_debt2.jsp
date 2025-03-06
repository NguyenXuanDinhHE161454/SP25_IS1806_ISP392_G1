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

                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Customer ID</th>
                                    <th>Customer Name</th>
                                    <th>Total Debt</th>
                                    <th>Action</th>
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
    </body>
</html>