<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Invoice Detail - Warehouse Rice Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
        <style>
            .invoice-header {
                background-color: #f8f9fa;
                border-bottom: 2px solid #e9ecef;
                padding: 1.5rem;
                border-radius: 8px 8px 0 0;
            }
            .invoice-details {
                background-color: #fff;
                padding: 1.5rem;
                border-radius: 0 0 8px 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
            }
            .badge {
                font-size: 0.9rem;
                padding: 0.5rem 0.75rem;
            }
            .table thead th {
                background-color: #f8f9fa;
                font-weight: 600;
            }
            .table-striped tbody tr:nth-of-type(odd) {
                background-color: rgba(0, 0, 0, 0.02);
            }
            .btn-back {
                background-color: #6c757d;
                color: #fff;
                border-radius: 25px;
                padding: 0.5rem 1.5rem;
            }
            .btn-back:hover {
                background-color: #5a6268;
            }
            .status-badge.completed {
                background-color: #d4edda;
                color: #155724;
            }
            .status-badge.pending {
                background-color: #fff3cd;
                color: #856404;
            }
            .total-amount {
                font-size: 1.25rem;
                font-weight: 600;
                color: #28a745;
            }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <%@include file="/components/header.jsp"%>

        <div id="layoutSidenav">
            <%@include file="/components/sidebar.jsp"%>

            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h1 class="mt-4 fw-bold text-primary"><i class="bi bi-receipt me-2"></i>Invoice Details</h1>
                            <a href="InvoiceController" class="btn btn-back">
                                <i class="bi bi-arrow-left me-2"></i>Back to Invoices
                            </a>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <c:if test="${not empty invoiceDetail}">
                            <div class="card shadow-sm mb-4">
                                <div class="invoice-header">
                                    <h4 class="mb-0 fw-bold">
                                        <i class="bi bi-file-earmark-text me-2"></i>
                                        Invoice #${invoiceDetail.id}
                                    </h4>
                                    <span class="badge ${invoiceDetail.completed ? 'status-badge completed' : 'status-badge pending'}">
                                        ${invoiceDetail.status}
                                    </span>
                                </div>
                                <div class="invoice-details">
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <h5 class="fw-bold mb-3">Invoice Information</h5>
                                            <ul class="list-unstyled">
                                                <li class="mb-2">
                                                    <span class="fw-semibold">Created On:</span>
                                                    <c:choose>
                                                        <c:when test="${invoiceDetail.createDate != null}">
                                                            ${invoiceDetail.createDate}
                                                        </c:when>
                                                        <c:otherwise>N/A</c:otherwise>
                                                    </c:choose>
                                                </li>
                                                <li class="mb-2">
                                                    <span class="fw-semibold">Customer:</span>
                                                    ${invoiceDetail.customerName} (#${invoiceDetail.customerId})
                                                </li>
                                                <li class="mb-2">
                                                    <span class="fw-semibold">Processed By:</span>
                                                    ${invoiceDetail.userName} (#${invoiceDetail.userId})
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-md-6">
                                            <h5 class="fw-bold mb-3">Payment Summary</h5>
                                            <ul class="list-unstyled">
                                                <li class="mb-2">
                                                    <span class="fw-semibold">Total Quantity:</span>
                                                    <span id="totalQuantity">${invoiceDetail.totalQuantity}</span>
                                                </li>
                                                <li class="mb-2">
                                                    <span class="fw-semibold">Total Amount:</span>
                                                    <span class="total-amount" id="formatVND">${invoiceDetail.totalAmount}</span>
                                                </li>
                                                <li class="mb-2">
                                                    <span class="fw-semibold">Paid Amount:</span>
                                                    <span id="formatVND">${invoiceDetail.paidAmount}</span>
                                                </li>
                                                <li class="mb-2">
                                                    <span class="fw-semibold">Debt Amount:</span>
                                                    <span id="formatVND">${invoiceDetail.debtAmount}</span>
                                                </li>
                                            </ul>
                                        </div>



                                    </div>

                                    <h5 class="fw-bold mb-3">Products</h5>
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Product ID</th>
                                                    <th>Product Name</th>
                                                    <th>Quantity</th>
                                                    <th>Unit Price</th>
                                                    <th>Total Price</th>
                                                    <th>Description</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="product" items="${invoiceDetail.products}">
                                                    <tr>
                                                        <td>${product.productId}</td>
                                                        <td>${product.productName}</td>
                                                        <td>${product.quantity}</td>
                                                        <td id="formatVND">${product.unitPrice}</td>
                                                        <td id="formatVND">${product.totalPrice}</td>
                                                        <td>${product.description}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </main>

                <%@include file="/components/footer.jsp"%>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/scripts.js"></script>
        <script src="js/currencyFormatter.js"></script>
    </body>
</html>