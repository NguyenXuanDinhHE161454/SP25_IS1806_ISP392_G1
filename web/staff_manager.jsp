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
                        <h1 class="mt-4">Quản lí nhân viên</h1>

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
                        <div class="card mb-4 col-lg-4">
                            <a href="staff_add.jsp" class="btn btn-primary">Tạo tài khoản nhân viên</a>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">Danh sách nhân viên</div>
                            <div class="card-body">
                                <form action="StaffController" method="get" class="row g-3">
                                    <div class="col-md-9">
                                        <label for="keyword" class="form-label">Tìm (ID, Tên, Số điện thoại)</label>
                                        <input type="text" name="keyword" id="keyword" class="form-control" value="${requestScope.keyword}" placeholder="Enter ID, Name, or Phone Number">
                                    </div>
                                    <div class="col-md-3 d-flex align-items-end">
                                        <button type="submit" class="btn btn-primary me-2">Tìm</button>
                                        <a href="StaffController" class="btn btn-secondary">Xóa</a>
                                    </div>
                                </form>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Họ tên</th>
                                            <th>Số điện thoại</th>
                                            <th>Email</th>
                                            <th>Trạng thái</th>
                                            <th>Hành động</th>
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
                                                <td>
                                                    <c:if test="${user.role != 'Admin'}">
                                                        <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#updateStatusModal${user.userId}">Cập nhật</button>
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
                                                                <label for="isBanned${user.userId}" class="form-label">Trạng thái</label>
                                                                <select name="isBanned" id="isBanned${user.userId}" class="form-select">
                                                                    <option value="false" ${!user.isBanned ? 'selected' : ''}>Active</option>
                                                                    <option value="true" ${user.isBanned ? 'selected' : ''}>Ban</option>
                                                                </select>
                                                            </div>
                                                            <button type="submit" class="btn btn-primary">Update</button>
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Thoát</button>
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
                                            <a class="page-link" href="StaffController?page=${currentPage - 1}&keyword=${keyword}">Trước</a>
                                        </li>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="StaffController?page=${i}&keyword=${keyword}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="StaffController?page=${currentPage + 1}&keyword=${keyword}">Sau</a>
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