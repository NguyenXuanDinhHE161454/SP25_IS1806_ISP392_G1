<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Chi Tiết Hóa Đơn - Bảng Điều Khiển Kho Gạo</title>
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
            .debt-info {
                color: #dc3545; /* Màu đỏ cho thông tin nợ */
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
                            <h1 class="mt-4 fw-bold text-primary"><i class="bi bi-receipt me-2"></i>Chi Tiết Hóa Đơn</h1>
                            <a href="InvoiceController" class="btn btn-back">
                                <i class="bi bi-arrow-left me-2"></i>Quay Lại
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
                                        Hóa Đơn #${invoiceDetail.id}
                                    </h4>

                                </div>
                                <div class="invoice-details">
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <h5 class="fw-bold mb-3">Thông Tin Hóa Đơn</h5>
                                            <ul class="list-unstyled">
                                                <li class="mb-2">
                                                    <span class="fw-semibold">Ngày Tạo:</span>
                                                    <c:choose>
                                                        <c:when test="${invoiceDetail.createDate != null}">
                                                            ${invoiceDetail.createDate}
                                                        </c:when>
                                                        <c:otherwise>Không Có</c:otherwise>
                                                    </c:choose>
                                                </li>
                                                <li class="mb-2">
                                                    <span class="fw-semibold">Khách Hàng:</span>
                                                    ${invoiceDetail.customerName} (#${invoiceDetail.customerId})
                                                </li>
                                                <li class="mb-2">
                                                    <span class="fw-semibold">Xử Lý Bởi:</span>
                                                    ${invoiceDetail.userName} (#${invoiceDetail.userId})
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-md-6">
                                            <h5 class="fw-bold mb-3"></h5>
                                            <ul class="list-unstyled">

                                                <li class="mb-2">
                                                    <span class="fw-semibold">Loại hóa đơn</span>
                                                    <span id="totalQuantity">${invoiceDetail.type == 1 ? "Nhập Hàng" : "Xuất Hàng"}</span>
                                                </li>
                                                <li class="mb-2">
                                                    <span class="fw-semibold">Tổng Số Tiền:</span>
                                                    <span class="total-amount" id="formatVND">${invoiceDetail.totalAmount}</span>
                                                </li>
                                                <li class="mb-2">
                                                    <span class="fw-semibold">Số Tiền Đã Thanh Toán:</span>
                                                    <span id="formatVND">${invoiceDetail.paidAmount}</span>
                                                </li>
                                                <li class="mb-2">
                                                    <span class="fw-semibold">Số Tiền Nợ:</span>
                                                    <span id="formatVND">${invoiceDetail.getDebt().getAmount()}</span>
                                                </li>
                                                <c:if test="${not empty invoiceDetail.debt}">
                                                    <c:if test="${not empty invoiceDetail.debt}">
                                                        
                                                        <c:if test="${invoiceDetail.debt.debtType == 1}">Khách Hàng Nợ</c:if>
                                                        <c:if test="${invoiceDetail.debt.debtType == 2}">Khách Hàng Thanh Toán</c:if>
                                                        <c:if test="${invoiceDetail.debt.debtType == 3}">Cửa Hàng Nợ</c:if>
                                                        <c:if test="${invoiceDetail.debt.debtType == 4}">Cửa Hàng Thanh Toán</c:if>
                                                        <c:if test="${invoiceDetail.debt.debtType != 1 && invoiceDetail.debt.debtType != 2 && invoiceDetail.debt.debtType != 3 && invoiceDetail.debt.debtType != 4}">
                                                            Không Xác Định
                                                        </c:if>
                                                    </li>-->

                                                    </c:if>

                                                </c:if>
                                            </ul>
                                        </div>
                                    </div>

                                    <h5 class="fw-bold mb-3">Sản Phẩm</h5>
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Mã Sản Phẩm</th>
                                                    <th>Tên Sản Phẩm</th>
                                                    <th>Khối Lượng</th>
                                                    <th>Giá</th>
                                                    <th>Tổng Giá</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="product" items="${invoiceDetail.products}">
                                                    <tr>
                                                        <td>${product.productId}</td>
                                                        <td>${product.productName}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${invoiceDetail.type == 2}">
                                                                    <!-- Hóa đơn xuất: chỉ hiển thị quantity -->
                                                                    ${product.quantity}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <!-- Hóa đơn nhập: hiển thị tổng khối lượng -->
                                                                    ${product.quantity * product.amountPerKg}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <c:choose>
                                                            <c:when test="${invoiceDetail.type == 2}">
                                                                <c:set var="price" value="${product.unitPrice}" />
                                                                <c:set var="totalPrice" value="${product.unitPrice * product.quantity }" />
                                                            </c:when>
                                                            <c:when test="${invoiceDetail.type == 1}">
                                                                <c:set var="price" value="${product.unitPrice}" />
                                                                <c:set var="totalPrice" value="${product.unitPrice * product.quantity * product.amountPerKg}" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set var="price" value="${product.unitPrice}" />
                                                                <c:set var="totalPrice" value="${product.totalPrice}" />
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td id="formatVND">${price}</td>
                                                        <td id="formatVND">${totalPrice}</td>
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