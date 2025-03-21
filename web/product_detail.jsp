<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Product Detail</title>
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
                        <h1 class="mt-4">Product Detail</h1>

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

                        <!-- Form chỉnh sửa sản phẩm -->
                        <div class="card mb-4">
                            <div class="card-header">Chỉnh sửa sản phẩm</div>
                            <div class="card-body">
                                <form action="ProductController" method="post" class="row g-3">
                                    <input type="hidden" name="action" value="updateProduct">
                                    <input type="hidden" name="id" value="${product.id}">
                                    <div class="col-md-6">
                                        <label for="name" class="form-label">Tên gạo</label>
                                        <input type="text" name="name" id="name" class="form-control" value="${product.name}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="amount" class="form-label">Giá bán</label>
                                        <input type="number" step="0.01" name="amount" id="amount" class="form-control" value="${product.amount}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="description" class="form-label">Mô tả</label>
                                        <input type="text" name="description" id="description" class="form-control" value="${product.description}">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="quantity" class="form-label">Tồn kho</label>
                                        <input type="number" name="quantity" id="quantity" class="form-control" value="${product.quantity}" readonly="">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="zoneId" class="form-label">Đang lưu ở khu vực</label>
                                        <select name="zoneId" id="zoneId" class="form-control" 
                                                ${product.zoneId != null ? 'disabled' : ''}>
<!--                                            <option value="">Select Zone</option>-->
                                            <c:forEach var="zone" items="${listZone}">
                                                <option value="${zone.id}" ${product.zoneId == zone.id ? 'selected' : ''}>
                                                    ${zone.name} (ID: ${zone.id})
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="status" class="form-label">Status</label>
                                        <select name="status" id="status" class="form-select" required>
                                            <option value="1" ${product.status == 1 ? 'selected' : ''}>Đang kinh doanh</option>
                                            <option value="0" ${product.status == 0 ? 'selected' : ''}>Ngừng kinh doanh</option>
                                        </select>
                                    </div>
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-primary">Confirm Update</button>
                                        <a href="ProductController?action=delete&id=${product.id}" class="btn btn-danger ms-2" onclick="return confirm('Are you sure you want to delete ${product.name}?')">Delete</a>
                                        <a href="ProductController" class="btn btn-secondary ms-2">Cancel</a>
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