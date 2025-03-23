<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Hóa Đơn Xuất</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/invoice.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/currencyFormatter.js"></script>
    </head>
    <body>
        <%@include file="/components/header.jsp"%>

        <div class="container">
            <form action="InvoiceController" method="POST">
                <input type="hidden" id="action" name="action" value="export-invoice"/>
                <input type="hidden" id="customerId" name="customerId">
                <input type="hidden" id="totalAmount" name="totalAmount">
                <input type="hidden" id="debtAmountHidden" name="debtAmount"> 
                <input type="hidden" id="addNewCustomer" name="addNewCustomer" value="false">

                <div id="productList" style="display: none;">
                    <!-- Các trường ẩn cho sản phẩm sẽ được thêm vào đây -->
                </div>
                <h2 class="text-center text-dark mb-4">Hóa Đơn Xuất</h2>

                <div class="row">
                    <!-- Product Search Table -->
                    <div class="col-md-7">
                        <div class="search-container">
                            <input type="text" id="productSearch" class="search-box form-control" placeholder="🔍 Tìm sản phẩm...">
                            <div id="searchResults" class="search-results"></div>
                        </div>

                        <table>
                            <thead>
                                <tr>
                                    <th>Tên Sản Phẩm</th>
                                    <th>Đóng Bao (kg)</th>
                                    <th>Số lượng</th>
                                    <th>Giá Mỗi Bao</th>
                                    <th>Tổng khối lượng</th>
                                    <th>Tổng Tiền</th>
                                    <th>Xóa</th>
                                </tr>
                            </thead>
                            <tbody id="productTable"></tbody>
                        </table>
                        <div class="total-price-container d-flex justify-content-between align-items-center">
                            <strong>Tổng tiền:</strong>
                            <span id="totalPrice">0 VND</span>
                        </div>
                    </div>

                    <!-- Customer & Invoice Info -->
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
                            <label class="fw-bold">Tìm khách hàng:</label>
                            <input type="text" id="customerSearch" class="search-box form-control" placeholder="🔍 Nhập ...">
                            <select id="customerList" class="form-control mt-2">
                                <option value="">Chọn khách hàng</option>
                                <option value="new">➕ Thêm khách hàng mới</option>
                            </select>
                        </div>

                        <!-- New Customer Form -->
                        <div id="newCustomerForm" class="hidden">
                            <div class="mb-3">
                                <label class="fw-bold">Tên khách hàng:</label>
                                <input type="text" id="newCustomerName" name="newCustomerName" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label class="fw-bold">Số điện thoại:</label>
                                <input type="text" id="newCustomerPhone" name="newCustomerPhone" class="form-control">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="fw-bold">Số tiền khách đã trả:</label>
                            <input type="number" name="paidAmount" class="form-control paid-amount" id="paidAmount" value="0" required="" />
                        </div>

                        <div id="debtInfo" class="debt-info hidden">
                            Số tiền nợ: <span id="debtAmount">0 VND</span>
                        </div>

                        <div class="mt-4">
                            <button id="createInvoice" class="btn btn-success w-100 mb-2">✅ Tạo Hóa Đơn</button>
                            <button class="btn btn-primary w-100">🖨 In Hóa Đơn</button>
                        </div>
                    </div>
                </div>

                <!-- Order Notes -->
                <div class="mt-4">
                    <label class="fw-bold">Ghi Chú Đơn Hàng:</label>
                    <textarea name="description" class="form-control" rows="3" placeholder="✏️ Nhập ghi chú..."></textarea>
                </div>
            </form>

        </div>

        <script src="js/invoices/create.js"></script>
        <script src="js/currencyFormatter.js"></script>
    </body>
</html>