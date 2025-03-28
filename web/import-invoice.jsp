<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Hóa Đơn Nhập</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/invoice.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/currencyFormatter.js"></script>
    </head>
    <body>
        <%@include file="/components/header.jsp"%>
        <c:if test="${not empty mess}">
            <div class="alert alert-danger text-center" role="alert">
                ${mess}
            </div>
        </c:if>
        <div class="container">
            <form action="InvoiceController" method="POST">
                <input type="hidden" id="action" name="action" value="import-invoice"/>
                <input type="hidden" id="customerId" name="customerId">
                <input type="hidden" id="totalAmount" name="totalAmount">
                <input type="hidden" id="debtAmountHidden" name="debtAmount"> 
                <input type="hidden" id="addNewCustomer" name="addNewCustomer" value="false">

                <div id="productList" style="display: none;"></div>
                <h2 class="text-center text-dark mb-4">Hóa Đơn Nhập</h2>

                <div class="row">
                    <!-- Bảng tìm kiếm sản phẩm -->
                    <div class="col-md-7">
                        <div class="search-container">
                            <input type="text" id="productSearch" class="search-box form-control" placeholder="Tìm sản phẩm...">
                            <div id="searchResults" class="search-results"></div>
                        </div>

                        <table>
                            <thead>
                                <tr>
                                    <th>Tên Sản Phẩm  </th>
                                    <th>Đóng Bao  </th>
                                    <th>Số lượng  </th>
                                    <th>Giá nhập  </th>
                                    <th>Tổng khối lượng  </th>
                                    <th>Tổng Tiền  </th>
                                    <th>Xóa  </th>
                                </tr>
                            </thead>
                            <tbody id="productTable"></tbody>
                        </table>
                        <div class="total-price-container d-flex justify-content-between align-items-center">
                            <strong>Tổng tiền:</strong>
                            <span id="totalPrice">0 VND</span>
                        </div>
                    </div>

                    <!-- Thông tin nhà cung cấp & hóa đơn -->
                    <div class="col-md-5">
                        <div class="mb-3">
                            <label class="fw-bold">Người Tạo:</label>
                            <input type="text" class="form-control" value="${user.fullName}" readonly>
                        </div>

                        <div class="mb-3">
                            <label class="fw-bold">Ngày Tạo:</label>
                            <input type="date" class="form-control" id="createDate" readonly>
                        </div>

                        <div class="mb-3">
                            <label class="fw-bold">Tìm nhà cung cấp:</label>
                            <input type="text" id="customerSearch" class="search-box form-control" placeholder="Nhập ...">
                            <select id="customerList" class="form-control mt-2">
                                <option value="">Chọn nhà cung cấp</option>
                                <option value="new">➕ Thêm nhà cung cấp mới</option>
                            </select>
                        </div>

                        <!-- Form thêm nhà cung cấp mới -->
                        <div id="newCustomerForm" class="hidden">
                            <div class="mb-3">
                                <label class="fw-bold">Tên nhà cung cấp:</label>
                                <input type="text" id="newCustomerName" name="newCustomerName" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label class="fw-bold">Số điện thoại:</label>
                                <input type="text" id="newCustomerPhone" name="newCustomerPhone" class="form-control">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="fw-bold">Số tiền đã trả:</label>
                            <input type="number" name="paidAmount" class="form-control paid-amount" id="paidAmount" value="" required="" />
                        </div>

                        <div id="debtInfo" class="debt-info hidden">
                            Số tiền cửa hàng nợ: <span id="debtAmount">0 VND</span>
                        </div>

                        <div class="mt-4">
                            <button id="createInvoice" class="btn btn-success w-100 mb-2">Tạo Hóa Đơn</button>
                            <a href="dashboard" class="btn btn-secondary w-100">Thoát</a>
                        </div>
                    </div>
                </div>

            </form>
        </div>

        <script src="js/invoices/import.js"></script>
    </body>
</html>
