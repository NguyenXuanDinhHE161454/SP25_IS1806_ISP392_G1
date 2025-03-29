<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/animation.css">
    <script>
        function validatePassword() {
            let password = document.getElementById("password").value;
            let confirmPassword = document.getElementById("confirm-password").value;
            let message = document.getElementById("error-message");

            if (password !== confirmPassword) {
                message.textContent = "Passwords do not match!";
                message.classList.add("text-danger");
                return false;
            } else {
                message.textContent = "";
                return true;
            }
        }
    </script>
</head>
<body class="bg-light">
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card shadow-lg p-4 animated fadeInDown">
            <h2 class="text-center">Reset Password</h2>
            <form action="reset-password" method="post" onsubmit="return validatePassword()">
                <div class="mb-3">
                    <label>New Password:</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Confirm Password:</label>
                    <input type="password" id="confirm-password" class="form-control" required>
                </div>
                <p id="error-message"></p>
                <button type="submit" class="btn btn-danger w-100">Reset Password</button>
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
