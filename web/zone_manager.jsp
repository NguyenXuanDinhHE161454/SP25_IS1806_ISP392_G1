<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Zone Management</title>
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
                        <h1 class="mt-4">Quản lí khu vực</h1>

                        <!-- Display messages -->
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

                        <!-- Search form -->
                        <div class="card mb-4">
                            <div class="card-header">Danh sách khu vực</div>
                            <div class="card-body">
                                <form action="ZoneController" method="get" class="row g-3">
                                    <div class="col-auto">
                                        <input type="text" class="form-control" name="keyword" value="${keyword}" placeholder="Tên gạo">
                                    </div>
                                    <div class="col-auto">
                                        <input type="text" class="form-control" name="warehouseName" value="${warehouseName}" placeholder="Tên khu vực">
                                    </div>
                                    <div class="col-auto">
                                        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                                    </div>
                                </form>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên khu vực</th>
                                            <th>ID gạo</th>
                                            <th>Tên gạo</th>
                                            <th>Tồn kho</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="zone" items="${listZone}">
                                            <tr>
                                                <td>${zone.zoneId}</td>
                                                <td>${zone.zoneName}</td>
                                                <td>${zone.productId != 0 ? zone.productId : "None"}</td>
                                                <td>${zone.productName != null ? zone.productName : 'No products'}</td>
                                                <td>${zone.stock}</td>
                                                <td>
                                                    <a href="ZoneController?action=detail&id=${zone.zoneId}" class="btn btn-sm btn-primary">Chi tiết</a>
                                                    <c:choose>
                                                        <c:when test="${zone.stock <= 0}">
                                                            <a href="ZoneController?action=delete&id=${zone.zoneId}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa không')">Xóa</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="#" class="btn btn-sm btn-danger disabled" aria-disabled="true">Xóa</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <!-- Pagination -->
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="ZoneController?page=${currentPage - 1}&keyword=${keyword}&warehouseName=${warehouseName}">Trước</a>
                                        </li>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="ZoneController?page=${i}&keyword=${keyword}&warehouseName=${warehouseName}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="ZoneController?page=${currentPage + 1}&keyword=${keyword}&warehouseName=${warehouseName}">Sau</a>
                                        </li>
                                    </ul>
                                </nav>

                                <!-- Add Zone Form -->
                                <div class="card mt-4">
                                    <div class="card-header">Tạo khu vực mới</div>
                                    <div class="card-body">
                                        <form action="ZoneController" method="post">
                                            <input type="hidden" name="action" value="createZone">
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <label for="name" class="form-label">Tên khu vực</label>
                                                    <input type="text" class="form-control" id="name" name="name" placeholder="Nhập tên khu vực " required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="status" class="form-label">Trạng thái</label>
                                                    <select class="form-control" id="status" name="status" required>
                                                        <option value="1">Đang hoạt động</option>
                                                        <option value="0">Ngừng hoạt động</option>
                                                    </select>
                                                </div>
                                                <div class="col-12">
                                                    <button type="submit" class="btn btn-success">Tạo</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <%@include file="/components/footer.jsp"%>
            </div>
        </div>

    </body>
</html>