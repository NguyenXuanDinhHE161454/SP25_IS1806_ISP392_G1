<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Staff Management</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet">
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
                        <h1 class="mt-4">Add New Staff</h1>

                        <!-- Hiển thị thông báo -->
                        <c:if test="${not empty sessionScope.message}">
                            <div class="alert alert-${sessionScope.messageType} alert-dismissible fade show" role="alert">
                                ${sessionScope.message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <%
                                session.removeAttribute("message");
                                session.removeAttribute("messageType");
                            %>
                        </c:if>

                        <!-- Form tạo người dùng mới -->
                        <div class="card mb-4">
                            <div class="card-header">Create New User</div>
                            <div class="card-body">
                                <form action="StaffController" method="post" class="row g-3">
                                    <input type="hidden" name="action" value="createUser">
                                    <div class="col-md-6">
                                        <label for="fullName" class="form-label">Full Name</label>
                                        <input type="text" name="fullName" id="fullName" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="phoneNumber" class="form-label">Phone Number</label>
                                        <input type="text" name="phoneNumber" id="phoneNumber" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="address" class="form-label">Address</label>
                                        <input type="text" name="address" id="address" class="form-control">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="username" class="form-label">Username</label>
                                        <input type="text" name="username" id="username" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="passwordHash" class="form-label">Password Hash</label>
                                        <input type="password" name="passwordHash" id="passwordHash" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="role" class="form-label">Role</label>
                                        <select name="role" id="role" class="form-select" required>
                                            <option value="Staff">Staff</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" name="email" id="email" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="isBanned" class="form-label">Initial Status</label>
                                        <select name="isBanned" id="isBanned" class="form-select">
                                            <option value="false">Active</option>
                                            <option value="true">Ban</option>
                                        </select>
                                    </div>
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-primary">Create User</button>
                                        <a href="StaffController" class="btn btn-secondary ms-2">Cancel</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
                <%@include file="/components/footer.jsp"%>
            </div>
        </div>

    </body>
</html>