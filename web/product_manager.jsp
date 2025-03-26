<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Product Management</title>
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
                        <h1 class="mt-4">Quản lí sản phẩm</h1>

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

                        <!-- Form tạo sản phẩm mới -->
                        <div class="card mb-4 col-lg-4">
                            <a href="ProductAddServlet" class="btn btn-primary">Tạo mới</a>
                        </div>

                        <!-- Search form -->
                        <div class="card mb-4">
                            <div class="card-header">Danh sách sản phẩm</div>
                            <div class="card-body">
                                <form action="ProductController" method="get" class="row g-3">
                                    <div class="col-md-9">
                                        <label for="keyword" class="form-label">Tìm (Tên, Mô tả)</label>
                                        <input type="text" name="keyword" id="keyword" class="form-control" value="${requestScope.keyword}" placeholder="Enter Name or Description">
                                    </div>
                                    <div class="col-md-3 d-flex align-items-end">
                                        <button type="submit" class="btn btn-primary me-2">Tìm</button>
                                        <a href="ProductController" class="btn btn-secondary">Xóa</a>
                                    </div>
                                </form>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên gạo</th>
                                            <th>Giá</th>
                                            <th>Mô tả</th>
                                            <th>Tồn kho</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${listProduct}">
                                            <tr>
                                                <td>${product.id}</td>
                                                <td>${product.name}</td>
                                                <td>${product.amount}</td>
                                                <td>${product.description}</td>
                                                <td>${product.quantity}</td>
                                                <td>
                                                    <a href="ProductController?action=detail&id=${product.id}" class="btn btn-sm btn-primary">Chi tiết</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <!-- Pagination -->
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="ProductController?page=${currentPage - 1}&keyword=${keyword}">Trước</a>
                                        </li>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="ProductController?page=${i}&keyword=${keyword}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="ProductController?page=${currentPage + 1}&keyword=${keyword}">Sau</a>
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