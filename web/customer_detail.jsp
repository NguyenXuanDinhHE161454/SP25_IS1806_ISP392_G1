<%-- 
    Document   : customer_detail
    Created on : Mar 16, 2025, 1:04:01 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Update Customer Information</title>
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
                        <h1 class="mt-4">Update Customer Information</h1>

                        <div class="card mb-4">
                            <div class="card-body">
                                <c:if test="${not empty customer}">
                                    <form action="CustomerDebtController" method="POST">
                                        <input type="hidden" name="action" value="updateCustomer">
                                        <input type="hidden" name="customerId" value="${customer.customerId}">

                                        <div class="mb-3">
                                            <label for="fullName" class="form-label">Customer Name</label>
                                            <input type="text" class="form-control" id="fullName" name="fullName" value="${customer.fullName}" required>
                                        </div>

                                        <div class="mb-3">
                                            <label for="phoneNumber" class="form-label">Customer Phone Number</label>
                                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${customer.phoneNumber}">
                                        </div>

                                        <div class="mb-3">
                                            <label for="address" class="form-label">Address</label>
                                            <input type="text" class="form-control" id="address" name="address" value="${customer.address}">
                                        </div>

                                        <div class="d-flex gap-2">
                                            <button type="submit" class="btn btn-primary">Update</button>
                                            <a href="CustomerDebtController" class="btn btn-secondary">Back</a>
                                        </div>
                                    </form>
                                </c:if>
                                <c:if test="${empty customer}">
                                    <p class="text-danger">Customer not found!</p>
                                    <a href="CustomerDebtController" class="btn btn-secondary">Back</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </main>
                <%@include file="/components/footer.jsp"%>
            </div>
        </div>

    </body>
</html>