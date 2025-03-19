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
                        <h1 class="mt-4">Staff Manager</h1>

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
                                        <input type="text" name="fullName" id="fullName" class="form-control" value="${requestScope.fullName}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="phoneNumber" class="form-label">Phone Number</label>
                                        <input type="text" name="phoneNumber" id="phoneNumber" class="form-control" value="${requestScope.phoneNumber}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="address" class="form-label">Address</label>
                                        <input type="text" name="address" id="address" class="form-control" value="${requestScope.address}">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="username" class="form-label">Username</label>
                                        <input type="text" name="username" id="username" class="form-control" value="${requestScope.username}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="passwordHash" class="form-label">Password Hash</label>
                                        <input type="text" name="passwordHash" id="passwordHash" class="form-control" value="${requestScope.passwordHash}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="role" class="form-label">Role</label>
                                        <select name="role" id="role" class="form-select" required>
                                            <option value="Staff" ${requestScope.role == 'Staff' ? 'selected' : ''}>Staff</option>
                                            <option value="Owner" ${requestScope.role == 'Owner' ? 'selected' : ''}>Owner</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" name="email" id="email" class="form-control" value="${requestScope.email}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="isBanned" class="form-label">Initial Status</label>
                                        <select name="isBanned" id="isBanned" class="form-select">
                                            <option value="false" ${requestScope.isBanned == false ? 'selected' : ''}>Active</option>
                                            <option value="true" ${requestScope.isBanned == true ? 'selected' : ''}>Ban</option>
                                        </select>
                                    </div>
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-primary">Create User</button>
                                        <a href="StaffController" class="btn btn-secondary ms-2">Cancel</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">Staff List</div>
                            <div class="card-body">
                                <form action="StaffController" method="get" class="row g-3">
                                    <div class="col-md-9">
                                        <label for="keyword" class="form-label">Search (ID, Name, Phone)</label>
                                        <input type="text" name="keyword" id="keyword" class="form-control" value="${requestScope.keyword}" placeholder="Enter ID, Name, or Phone Number">
                                    </div>
                                    <div class="col-md-3 d-flex align-items-end">
                                        <button type="submit" class="btn btn-primary me-2">Search</button>
                                        <a href="StaffController" class="btn btn-secondary">Clear</a>
                                    </div>
                                </form>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Full Name</th>
                                            <th>Phone Number</th>
                                            <th>Email</th>
                                            <th>Status</th>
                                            <th>Deleted</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="user" items="${listUser}">
                                            <tr>
                                                <td>${user.userId}</td>
                                                <td>${user.fullName}</td>
                                                <td>${user.phoneNumber}</td>
                                                <td>${user.email}</td>
                                                <td>${user.isBanned ? 'Ban' : 'Active'}</td>
                                                <td>${user.isDeleted ? 'Yes' : 'None'}</td>
                                                <td>
                                                    <c:if test="${user.role != 'Admin'}">
                                                        <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#updateStatusModal${user.userId}">Update Status</button>
                                                        <a href="StaffController?action=delete&id=${user.userId}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                                                    </c:if>
                                                </td>
                                            </tr>

                                            <!-- Modal để cập nhật trạng thái IsBanned -->
                                        <div class="modal fade" id="updateStatusModal${user.userId}" tabindex="-1" aria-labelledby="updateStatusModalLabel${user.userId}" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="updateStatusModalLabel${user.userId}">Update Status for User ID: ${user.userId}</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form action="StaffController" method="post">
                                                            <input type="hidden" name="action" value="updateStatus">
                                                            <input type="hidden" name="id" value="${user.userId}">
                                                            <div class="mb-3">
                                                                <label for="isBanned${user.userId}" class="form-label">Status</label>
                                                                <select name="isBanned" id="isBanned${user.userId}" class="form-select">
                                                                    <option value="false" ${!user.isBanned ? 'selected' : ''}>Active</option>
                                                                    <option value="true" ${user.isBanned ? 'selected' : ''}>Ban</option>
                                                                </select>
                                                            </div>
                                                            <button type="submit" class="btn btn-primary">Update</button>
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    </tbody>
                                </table>

                                <!-- Phân trang -->
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="StaffController?page=${currentPage - 1}&keyword=${keyword}">Previous</a>
                                        </li>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="StaffController?page=${i}&keyword=${keyword}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="StaffController?page=${currentPage + 1}&keyword=${keyword}">Next</a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </main>
                <%@include file="/components/footer.jsp"%>
            </div>
        </div>
        
    </body>
</html>