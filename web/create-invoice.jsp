<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Hóa Đơn Xuất</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/currencyFormatter.js"></script> 
        <style>
            body {
                background-color: #F8F9FA;
                color: #333;
            }
            .table {
                background-color: white;
                color: #333;
                border-radius: 8px;
            }
            .table thead {
                background-color: #6C757D;
                color: white;
            }
            .form-control {
                background-color: white;
                color: #333;
                border-radius: 6px;
                border: 1px solid #CED4DA;
            }
            .btn-danger {
                background-color: #DC3545;
                border-radius: 6px;
            }
            .btn-success {
                background-color: #28A745;
                border-radius: 6px;
            }
            .btn-primary {
                background-color: #007BFF;
                border-radius: 6px;
            }
            .search-box {
                width: 100%;
                border-radius: 6px;
                border: 1px solid #CED4DA;
                background-color: white;
                color: #333;
                padding: 8px;
                outline: none;
            }
            .hidden {
                display: none;
            }
        </style>
    </head>
    <body>
        <%@include file="/components/header.jsp"%>

        <div class="container mt-4">
            <h2 class="text-center text-dark">Hóa Đơn Xuất</h2>

            <div class="row">
                <!-- Bảng tìm kiếm sản phẩm -->
                <div class="col-md-7">
                    <input type="text" id="productSearch" class="search-box mb-2" placeholder="🔍 Tìm sản phẩm...">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Hình Ảnh</th>
                                <th>Tên Sản Phẩm</th>
                                <th>Số Bao</th>
                                <th>Giá Mỗi Bao</th>
                                <th>Tổng Tiền</th>
                                <th>Xóa</th>
                            </tr>
                        </thead>
                        <tbody id="productTable">
                            <!-- Danh sách sản phẩm -->
                        </tbody>
                    </table>
                    <div class="d-flex justify-content-between">
                        <strong class="text-dark">Tổng tiền:</strong> <span id="totalPrice" class="text-primary fw-bold">0 VND</span>
                    </div>
                </div>

                <!-- Thông tin khách hàng & hóa đơn -->
                <div class="col-md-5">
                    <label class="fw-bold">Người Tạo:</label>
                    <input type="text" class="form-control" value="Lục" readonly>

                    <label class="fw-bold">Ngày Tạo:</label>
                    <input type="date" class="form-control" id="createDate" readonly>

                    <label class="fw-bold">Tìm khách hàng theo SĐT:</label>
                    <input type="text" id="customerSearch" class="search-box" placeholder="🔍 Nhập số điện thoại...">
                    <select id="customerList" class="form-control mt-2">
                        <option value="">Chọn khách hàng</option>
                        <option value="new">➕ Thêm khách hàng mới</option>
                    </select>

                    <!-- Form thêm khách hàng mới -->
                    <div id="newCustomerForm" class="hidden">
                        <label class="fw-bold mt-2">Tên khách hàng:</label>
                        <input type="text" id="newCustomerName" class="form-control">
                        <label class="fw-bold mt-2">Số điện thoại:</label>
                        <input type="text" id="newCustomerPhone" class="form-control">
                    </div>

                    <label class="fw-bold">Số hóa đơn:</label>
                    <input type="text" class="form-control">

                    <div class="mt-3">
                        <button id="createInvoice" class="btn btn-success w-100">✅ Tạo Hóa Đơn</button>
                        <button class="btn btn-primary w-100 mt-2">🖨 In Hóa Đơn</button>
                    </div>
                </div>
            </div>

            <!-- Ghi chú -->
            <div class="mt-3">
                <label class="fw-bold">Ghi Chú Đơn Hàng:</label>
                <textarea class="form-control" placeholder="✏️ Nhập ghi chú..."></textarea>
            </div>
        </div>

        <script>
            // Khai báo jQuery tránh xung đột với JSTL
            var jq = jQuery.noConflict();

            // Lấy ngày hiện tại
            document.getElementById("createDate").valueAsDate = new Date();

            // 🧑‍💼 Tìm kiếm khách hàng AJAX
            jq("#customerSearch").on("input", function () {
                let keyword = jq(this).val().trim();
                if (keyword.length < 2)
                    return;

                jq.get("api/invoice?action=searchCustomer&keyword=" + keyword, function (data) {
                    jq("#customerList").empty().append(`<option value="">Chọn khách hàng</option>`);
                    data.forEach(customer => {
                        jq("#customerList").append(
                                `<option value="\${customer.customerId}">\${customer.fullName} (\${customer.phoneNumber})</option>`
                                );
                    });
                    jq("#customerList").append(`<option value="new">➕ Thêm khách hàng mới</option>`);
                }, "json");
            });

            // Hiển thị form thêm khách hàng mới nếu chọn "Thêm khách hàng mới"
            jq("#customerList").on("change", function () {
                if (jq(this).val() === "new") {
                    jq("#newCustomerForm").removeClass("hidden");
                } else {
                    jq("#newCustomerForm").addClass("hidden");
                }
            });

            // 🔍 Tìm kiếm sản phẩm AJAX
            jq("#productSearch").on("input", function () {
                let keyword = jq(this).val().trim();
                if (keyword.length < 2)
                    return;

                jq.get("api/invoice?action=searchProduct&keyword=" + keyword, function (data) {
                    jq("#productTable").empty();
                    data.forEach(product => {
                        let price = 50000; // Giá mặc định (hoặc lấy từ API)
                        jq("#productTable").append(`
                    <tr>
                        <td><img src="images/\${product.image}" alt="\${product.name}" width="50"></td>
                        <td>\${product.name}</td>
                        <td><input type="number" class="form-control quantity" value="1" min="1"></td>
                        <td>
                            <input type="hidden" class="unit-price" value="\${price}">
                            <span class="formatVND">\${price}</span>
                        </td>
                        <td><span class="total formatVND">0</span></td>
                        <td><button class="btn btn-danger removeProduct">Xóa</button></td>
                    </tr>
                `);
                    });
                    updateTotal();
                    applyFormatting();
                }, "json");
            });

            // 🏷️ Cập nhật tổng tiền
            function updateTotal() {
                let total = 0;
                jq("#productTable tr").each(function () {
                    let price = parseFloat(jq(this).find(".unit-price").val());
                    let quantity = parseFloat(jq(this).find(".quantity").val());
                    let totalPrice = price * quantity;
                    jq(this).find(".total").text(totalPrice);
                    total += totalPrice;
                });
                jq("#totalPrice").text(total);
                applyFormatting();
            }

            // 📌 Cập nhật tổng tiền khi thay đổi số lượng
            jq(document).on("input", ".quantity", function () {
                updateTotal();
            });

            // ❌ Xóa sản phẩm khỏi danh sách
            jq(document).on("click", ".removeProduct", function () {
                jq(this).closest("tr").remove();
                updateTotal();
            });

        </script>

    </body>
</html>
