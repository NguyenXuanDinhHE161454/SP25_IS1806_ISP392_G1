<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Warehouse Rice Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Warehouse Rice Details</h2>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <!-- Display rice details -->
        <c:if test="${not empty riceDetails}">
            <table class="table table-bordered">
                <tr>
                    <th>Rice ID</th>
                    <td>${riceDetails.riceId}</td>
                </tr>
                <tr>
                    <th>Rice Name</th>
                    <td>${riceDetails.riceName}</td>
                </tr>
                <tr>
                    <th>Price</th>
                    <td>${riceDetails.price}</td>
                </tr>
                <tr>
                    <th>Description</th>
                    <td>${riceDetails.description}</td>
                </tr>
                <tr>
                    <th>Load Capacity</th>
                    <td>${riceDetails.loadCapacity}</td>
                </tr>
            </table>
        </c:if>

        <a href="warehouserice" class="btn btn-secondary">Back to List</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
