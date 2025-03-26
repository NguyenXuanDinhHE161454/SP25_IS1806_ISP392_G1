<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>User Profile - Rice Warehouse</title>
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
                        <h1 class="mt-4">Thông tin tài khoản</h1>

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

                        <!-- Form hiển thị thông tin người dùng -->
                        <div class="card mt-4">
                            <div class="card-body">
                                <form action="ProfileController" method="POST">
                                    <div class="mb-3">
                                        <label for="username" class="form-label">Tên đăng nhập:</label>
                                        <input type="text" class="form-control" id="username" name="username" value="${requestScope.user.username}" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label for="fullName" class="form-label">Họ tên:</label>
                                        <input type="text" class="form-control" id="fullName" name="fullName" value="${requestScope.user.fullName}">
                                    </div>
                                    <div class="mb-3">
                                        <label for="phoneNumber" class="form-label">Số điện thoại:</label>
                                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${requestScope.user.phoneNumber}">
                                    </div>
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email:</label>
                                        <input type="email" class="form-control" id="email" name="email" value="${requestScope.user.email}">
                                    </div>
                                    <div class="mb-3">
                                        <label for="address" class="form-label">Địa chỉ:</label>
                                        <input type="text" class="form-control" id="address" name="address" value="${requestScope.user.address}">
                                    </div>
                                    <div class="mb-3">
                                        <label for="role" class="form-label">Vai trò:</label>
                                        <input type="text" class="form-control" id="role" name="role" value="${requestScope.user.role}" readonly>
                                    </div>

                                    <!-- Nút điều khiển -->
                                    <div class="d-flex justify-content-end">
                                        <!-- Nút Đổi mật khẩu (mở modal) -->
                                        <button type="button" class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                                            Đổi mật khẩu
                                        </button>
                                        <!-- Nút Cập nhật -->
                                        <input type="hidden" name="action" value="update">
                                        <button type="submit" class="btn btn-success me-2">Cập nhật</button>
                                        <!-- Nút Thoát -->
                                        <a href="dashboard.jsp" class="btn btn-secondary">Thoát</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
                <%@include file="/components/footer.jsp"%>
            </div>
        </div>

        <!-- Modal Đổi mật khẩu -->
        <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="changePasswordModalLabel">Đổi mật khẩu</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="ProfileController" method="POST">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email:</label>
                                <input type="email" class="form-control" id="email" name="email" value="${requestScope.user.email}" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">Mật khẩu mới:</label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                            </div>
                            <input type="hidden" name="action" value="changePassword">
                            <button type="submit" class="btn btn-primary">Xác nhận</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
       
    </body>
</html>