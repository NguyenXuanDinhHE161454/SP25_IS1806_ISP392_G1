<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Import Rice</title>
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
                    <h1 class="mt-4">Import Rice</h1>

                    <!-- Search Form: Customer ID Verification -->
                    <form method="get" action="ImportRiceController" class="row g-3 mb-4">
                        <div class="col-md-4">
                            <input type="number" name="customerId" value="${customerId}" class="form-control" placeholder="Enter Customer ID" required>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">Verify</button>
                        </div>
                    </form>

                    <!-- Display error if applicable -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <!-- Display Customer Information if valid -->
                    <c:if test="${not empty customer}">
                        <div class="card mb-4">
                            <div class="card-header">Customer Information</div>
                            <div class="card-body">
                                <p><strong>Customer ID:</strong> ${customer.customerId}</p>
                                <p><strong>Name:</strong> ${customer.fullName}</p>
                                <p><strong>Phone:</strong> ${customer.phoneNumber}</p>
                                <p><strong>Address:</strong> ${customer.address}</p>
                            </div>
                        </div>

                        <!-- Import Rice Form -->
                        <form action="ImportRiceController" method="post">
                            <input type="hidden" name="customerId" value="${customer.customerId}">

                            <div class="mb-3">
                                <label for="riceId">Rice Type:</label>
                                <select class="form-control" id="riceId" name="riceId" required>
                                    <option value="1">Jasmine Rice</option>
                                    <option value="2">Sticky Rice</option>
                                    <option value="3">Brown Rice</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="quantity">Quantity (kg):</label>
                                <input type="number" class="form-control" id="quantity" name="quantity" required>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="isDebt" name="isDebt">
                                <label class="form-check-label" for="isDebt">Purchase on Debt</label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="isPorterService" name="isPorterService">
                                <label class="form-check-label" for="isPorterService">Use Porter Service (2000 VND/50kg)</label>
                            </div>

                            <button type="submit" class="btn btn-primary mt-3">Import Rice</button>
                        </form>
                    </c:if>
                </div>
            </main>

            <%@include file="/components/footer.jsp"%>
        </div>
    </div>

</body>
</html>
