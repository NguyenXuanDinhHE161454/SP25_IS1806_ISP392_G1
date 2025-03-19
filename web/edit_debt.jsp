<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Debt</title>
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>

    <%@include file="/components/header.jsp"%>

    <div id="layoutSidenav">
        <%@include file="/components/sidebar.jsp"%>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Edit Debt</h1>

                    <!-- Hiển thị lỗi nếu có -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <c:if test="${not empty debt}">
                        <form method="post" action="DebtController">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="debtId" value="${debt.debtId}">
                            <input type="hidden" name="customerId" value="${debt.customerId}">

                            <!-- Hiển thị tên khách hàng -->
                            <div class="mb-3">
                                <label>Customer Name:</label>
                                <input type="text" class="form-control" value="${debt.customerName}" disabled>
                            </div>

                            <!-- Chỉnh sửa loại nợ -->
                            <div class="mb-3">
                                <label for="debtType">Debt Type:</label>
                                <select class="form-control" id="debtType" name="debtType">
                                    <option value="+" ${debt.debtType eq '+' ? 'selected' : ''}>Owner Owes Customer</option>
                                    <option value="-" ${debt.debtType eq '-' ? 'selected' : ''}>Customer Owes Owner</option>
                                </select>
                            </div>

                            <!-- Chỉnh sửa số tiền -->
                            <div class="mb-3">
                                <label for="amount">Amount:</label>
                                <input type="number" class="form-control" id="amount" name="amount" value="${debt.amount}" required>
                            </div>

                            <!-- Chỉnh sửa ghi chú -->
                            <div class="mb-3">
                                <label for="note">Note:</label>
                                <textarea class="form-control" id="note" name="note">${debt.note}</textarea>
                            </div>

                            <button type="submit" class="btn btn-primary">Update Debt</button>
                            <a href="DebtController" class="btn btn-secondary">Cancel</a>
                        </form>
                    </c:if>
                </div>
            </main>

            <%@include file="/components/footer.jsp"%>
        </div>
    </div>

</body>
</html>
