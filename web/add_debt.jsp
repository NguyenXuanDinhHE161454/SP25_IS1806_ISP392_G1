<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Debt</title>
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>

    <%@include file="/components/header.jsp"%>

    <div id="layoutSidenav">
        <%@include file="/components/sidebar.jsp"%>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Add New Debt</h1>

                    <!-- Hiển thị lỗi nếu có -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form method="post" action="DebtController">
                        <input type="hidden" name="action" value="add">

                        <!-- Nhập số điện thoại để tìm khách hàng -->
                        <div class="mb-3">
                            <label for="phoneNumber">Customer Phone Number:</label>
                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
                            <button type="button" class="btn btn-info mt-2" onclick="fetchCustomer()">Verify</button>
                        </div>

                        <!-- Hiển thị thông tin khách hàng -->
                        <div id="customerInfo" class="mb-3" style="display: none;">
                            <label>Customer Name:</label>
                            <input type="text" class="form-control" id="customerName" disabled>
                            <input type="hidden" id="customerId" name="customerId">
                        </div>

                        <!-- Chọn loại nợ -->
                        <div class="mb-3">
                            <label for="debtType">Debt Type:</label>
                            <select class="form-control" id="debtType" name="debtType">
                                <option value="+">Owner Owes Customer</option>
                                <option value="-">Customer Owes Owner</option>
                            </select>
                        </div>

                        <!-- Nhập số tiền -->
                        <div class="mb-3">
                            <label for="amount">Amount:</label>
                            <input type="number" class="form-control" id="amount" name="amount" required>
                        </div>

                        <!-- Ghi chú -->
                        <div class="mb-3">
                            <label for="note">Note:</label>
                            <textarea class="form-control" id="note" name="note"></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary">Save Debt</button>
                        <a href="DebtController" class="btn btn-secondary">Cancel</a>
                    </form>
                </div>
            </main>

            <%@include file="/components/footer.jsp"%>
        </div>
    </div>

    <!-- JavaScript để lấy thông tin khách hàng -->
    <script>
        function fetchCustomer() {
            let phoneNumber = document.getElementById("phoneNumber").value;
            if (!phoneNumber) {
                alert("Please enter a phone number.");
                return;
            }

            fetch("DebtController?action=getCustomerByPhone&phoneNumber=" + phoneNumber)
                .then(response => response.json())
                .then(data => {
                    if (data.customerId) {
                        document.getElementById("customerName").value = data.customerName;
                        document.getElementById("customerId").value = data.customerId;
                        document.getElementById("customerInfo").style.display = "block";
                    } else {
                        alert("Customer not found.");
                    }
                })
                .catch(error => console.error("Error fetching customer:", error));
        }
    </script>

</body>
</html>
