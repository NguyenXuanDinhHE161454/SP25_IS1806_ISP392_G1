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
            
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Add New Debt</h1>

                        <!-- Hiển thị lỗi nếu có -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>

                        <!-- Nhập số điện thoại để tìm khách hàng -->
                        <div class="mb-3">
                            <label for="phoneNumber">Customer Phone Number:</label>
                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
                            <button type="button" class="btn btn-info mt-2" onclick="fetchCustomer()">Verify</button>
                            <button type="button" class="btn btn-success" onclick="addCustomer()">Add Customer</button>
                        </div>

                        <!-- Form nhập thông tin nợ (Ẩn ban đầu) -->
                        <form method="post" action="DebtController" id="debtForm" style="display: none;">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" id="customerId" name="customerId">

                            <!-- Hiển thị thông tin khách hàng -->
                            <div class="mb-3">
                                <label>Customer Name:</label>
                                <input type="text" class="form-control" id="customerName" disabled>
                            </div>

                            <!-- Chọn loại nợ -->
                            <div class="mb-3">
                                <label for="debtType">Debt Type:</label>
                                <select class="form-control" id="debtType" name="debtType">
                                    <option value="+">(+)</option>
                                    <option value="-">(-)</option>
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
                            document.getElementById("debtForm").style.display = "block";
                        } else {
                            alert("Customer not found. Please add a new customer.");
                            document.getElementById("debtForm").style.display = "none";
                        }
                    })
                    .catch(error => console.error("Error fetching customer:", error));
            }

            function addCustomer() {
                window.location.href = "createCustomer.jsp"; 
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    </body>
</html>

