<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Zone Detail</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
        <style>
            .form-group {
                margin-bottom: 1rem;
            }
            .associated-products {
                margin-top: 1rem;
            }
        </style>
    </head>
    <body>
        <%@include file="/components/header.jsp"%>

        <div id="layoutSidenav">
            <%@include file="/components/sidebar.jsp"%>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Zone Detail</h1>

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

                        <div class="card mb-4">
                            <div class="card-header">Cập nhật khu vực</div>
                            <div class="card-body">
                                <form action="ZoneController" method="post">
                                    <input type="hidden" name="action" value="updateZone">
                                    <input type="hidden" name="id" value="${zone.id}">

                                    <div class="form-group">
                                        <label>Zone Id: ${zone.id}</label>
                                    </div>

                                    <div class="form-group">
                                        <label for="name">Zone Name:</label>
                                        <input type="text" class="form-control" id="name" name="name" value="${zone.name}" required>
                                    </div>

                                    <div class="form-group associated-products">
                                        <label for="productId">Rice Type:</label>
                                        <select class="form-control" id="productId" name="productId">
                                            <option value="" ${associatedProduct == null ? 'selected' : ''}>-- Select Rice Type --</option>
                                            <c:forEach var="product" items="${listProducts}">
                                                <option value="${product.id}" ${associatedProduct != null && associatedProduct.id == product.id ? 'selected' : ''}>
                                                    ${product.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <input type="hidden" class="form-control" id="stock" name="stock" 
                                           value="${associatedProduct != null ? associatedProduct.quantity : 0}" min="0" required>

                                    <div class="form-group">
                                        <label for="status">Status:</label>
                                        <select class="form-control" id="status" name="status" required>
                                            <option value="1" ${zone.status == 1 ? 'selected' : ''}>Active</option>
                                            <option value="0" ${zone.status == 0 ? 'selected' : ''}>Inactive</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary">Save</button>
                                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exportImportModal">Export - Import</button>
                                        <a href="ZoneController" class="btn btn-secondary">Back To List</a>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Modal for Export/Import -->
                        <div class="modal fade" id="exportImportModal" tabindex="-1" aria-labelledby="exportImportModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exportImportModalLabel">Export/Import Rice</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="ZoneController" method="post">
                                            <input type="hidden" name="action" value="exportImport">
                                            <input type="hidden" name="zoneId" value="${zone.id}">
                                            <input type="hidden" name="productId" value="${associatedProduct != null ? associatedProduct.id : ''}">

                                            <div class="form-group">
                                                <label>Current Rice: ${associatedProduct != null ? associatedProduct.name : 'None'}</label>
                                            </div>

                                            <div class="form-group">
                                                <label for="transactionType">Transaction Type:</label>
                                                <select class="form-control" id="transactionType" name="transactionType" onchange="updateQuantityConstraints()" required>
                                                    <option value="export">Export</option>
                                                    <option value="import">Import</option>
                                                </select>
                                            </div>

                                            <div class="form-group">
                                                <label for="quantity">Quantity:</label>
                                                <input type="number" class="form-control" id="quantity" name="quantity" 
                                                       min="0" max="${associatedProduct != null ? associatedProduct.quantity : 0}" required>
                                            </div>

                                            <button type="submit" class="btn btn-primary">Submit</button>
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

        <script>
            function updateQuantityConstraints() {
                var transactionType = document.getElementById("transactionType").value;
                var quantityInput = document.getElementById("quantity");
                var maxStock = ${associatedProduct != null ? associatedProduct.quantity : 0};

                if (transactionType === "export") {
                    quantityInput.max = maxStock; // Giới hạn tối đa là stock hiện tại
                    quantityInput.min = 0;        // Nhỏ nhất là 0
                } else if (transactionType === "import") {
                    quantityInput.max = "";       // Không giới hạn tối đa
                    quantityInput.min = 0;        // Nhỏ nhất là 0
                }
            }
        </script>
    </body>
</html>