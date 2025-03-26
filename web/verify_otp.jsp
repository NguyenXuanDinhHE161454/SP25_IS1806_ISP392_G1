<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/animation.css">
</head>
<body class="bg-light">

    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card shadow-lg p-4 animated bounceIn">
            <h2 class="text-center">Verify OTP</h2>
            <p class="text-center text-muted">Enter the OTP sent to your email.</p>

            <form action="verify-otp" method="post">
                <div class="mb-3">
                    <label>OTP:</label>
                    <input type="text" name="otp" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-success w-100">Verify OTP</button>
            </form>

            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-3">${error}</div>
            </c:if>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
