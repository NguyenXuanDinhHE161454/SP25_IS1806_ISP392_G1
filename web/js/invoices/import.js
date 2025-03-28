$(function () {
    var $ = jQuery.noConflict();

    function formatVND(value) {
        return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(value);
    }

    document.getElementById("createDate").valueAsDate = new Date();

    $(document).on("click", function (e) {
        if (!$(e.target).closest("#productSearch, #searchResults").length) {
            $("#searchResults").hide();
        }
        if (!$(e.target).closest("#customerList, #customerSearch").length) {
            $("#customerList").hide();
        }
    });

    $("#customerSearch").on("input", function () {
        let keyword = $(this).val().trim();
        let customerList = $("#customerList");

        $.get("api/invoice?action=searchCustomer&keyword=" + encodeURIComponent(keyword), function (data) {
            customerList.empty().append('<option value="">Chọn khách hàng</option>');
            data.forEach(customer => {
                customerList.append(
                    `<option value="${customer.customerId}" data-phone="${customer.phoneNumber}" data-name="${customer.fullName}">${customer.fullName} (${customer.phoneNumber})</option>`
                );
            });
            customerList.append('<option value="new">➕ Thêm khách hàng mới</option>');
            customerList.attr("size", Math.min(data.length + 2, 10)).show();
        }, "json").fail(function () {
            console.error("Error fetching customers");
        });
    });

    $("#customerList").on("change", function () {
        let selectedValue = $(this).val();
        let selectedOption = $(this).find("option:selected");

        if (selectedValue === "new") {
            $("#customerSearch").val("");
            $("#customerId").val(0);
            $(this).hide();
            $("#newCustomerForm").removeClass("hidden").hide().fadeIn(300);
        } else if (selectedValue) {
            let name = selectedOption.data("name");
            $("#customerSearch").val(name);
            $("#customerId").val(selectedValue);
            $(this).hide();
            $("#newCustomerForm").fadeOut(300, function () {
                $(this).addClass("hidden");
            });
        }
    });

    $("#productSearch").on("focus", function () {
        if (!$("#searchResults").is(":visible")) {
            $("#searchResults").slideDown(200);
        }
    });

    $("body").on("input change","#productSearch", function () {
        let keyword = $(this).val().trim();
        $.get("api/invoice?action=searchProduct&keyword=" + encodeURIComponent(keyword), function (data) {
            let resultBox = $("#searchResults");
            resultBox.empty();
            if (data.length > 0) {
                data.forEach(product => {
                    resultBox.append(`
                        <div class="search-item" data-id="${product.id}" data-name="${product.name}" data-amount="${product.amount}" data-stock="${product.quantity}">
                            <strong>${product.name}</strong> - ${product.amount} VND/kg (Còn: ${product.quantity} kg)
                            <span class="btn btn-sm btn-success addProduct">+</span>
                        </div>
                    `);
                });
            }
            resultBox.append(`
                <div class="search-item">
                    <a href="/addProduct.jsp" class="btn btn-primary btn-sm">➕ Thêm Sản Phẩm Mới</a>
                </div>
            `);
            resultBox.slideDown(200);
        }, "json").fail(function () {
            console.error("Error fetching products");
        });
    });

    $(document).on("click", ".addProduct", function () {
        let item = $(this).closest(".search-item");
        let productId = item.data("id");
        let productName = item.data("name");
        let stock = parseFloat(item.data("stock"));

        if ($("#productTable tr[data-product-id='" + productId + "']").length > 0) {
            alert("Sảnh phẩm đã tồn tại trong bảng. Vui lòng chọn sản phẩm khác.");
            return;
        }

        let newRow = $(`
            <tr data-product-id="${productId}">
                <td>${productName}</td>
                <td>
                    <select class="form-control package-weight">
                        <option value="10" selected>10 kg</option>
                        <option value="20">20 kg</option>
                        <option value="50">50 kg</option>
                    </select>
                </td>
                <td>
                    <input type="number" class="form-control quantity" value="1" min="1" data-stock="${stock}">
                </td>
                <td>
                    <input 
                        type="text" 
                        class="form-control import" 
                        value="" 
                        required 
                        name="import" 
                        aria-label="Import Price"
                    >
                </td>
                <td>
                    <input type="text" class="form-control total-load" value="10" readonly>
                </td>
                <td>
                    <span class="total formatVND" data-total="0">${formatVND(0)}</span>
                </td>
                <td><button type="button" class="btn btn-danger btn-sm removeProduct">Xóa</button></td>
            </tr>
        `);

        $("#productTable").append(newRow);
        newRow.hide().fadeIn(500);
        $("#productList").append(`
            <div class="product-entry" data-product-id="${productId}">
                <input type="hidden" name="productId[]" value="${productId}">
                <input type="hidden" name="quantity[]" value="1">
                <input type="hidden" name="price[]" value="0">
                <input type="hidden" name="perKg[]" value="10">
            </div>
        `);

        updateRowTotal(newRow);
        updateTotal();
        $("#searchResults").hide();
    });

    function updateRowTotal(row) {
        let packageWeight = parseFloat(row.find(".package-weight").val());
        let quantity = parseFloat(row.find(".quantity").val()) || 1;
        let importPrice = parseFloat(row.find(".import").val()) || 0;
        console.log("importPrice :: " + importPrice);
        let totalLoad = packageWeight * quantity;
        row.find(".total-load").val(totalLoad);

        let totalPrice = totalLoad * importPrice;
        row.find(".total").attr("data-total", totalPrice).text(formatVND(totalPrice));

        let productId = row.data("product-id");
        let productEntry = $(`#productList .product-entry[data-product-id="${productId}"]`);
        productEntry.find('input[name="quantity[]"]').val(quantity);
        productEntry.find('input[name="price[]"]').val(importPrice);
        productEntry.find('input[name="perKg[]"]').val(packageWeight);
    }

    function updateTotal() {
        let total = 0;
        let totalLoad = 0;
        $("#productTable .total").each(function () {
            let rowTotal = parseFloat($(this).attr("data-total")) || 0;
            total += rowTotal;
        });
        $("#productTable .total-load").each(function () {
            let load = parseFloat($(this).val()) || 0;
            totalLoad += load;
        });
        $("#totalPrice").attr("data-total", total).text(formatVND(total));
        $("#totalLoad").text(totalLoad + " kg");
        updateDebt();
    }

    function updateDebt() {
        let total = parseFloat($("#totalPrice").attr("data-total")) || 0;
        let paid = parseFloat($("#paidAmount").val()) || 0;

        if (paid < 0) {
            paid = 0;
            $("#paidAmount").val(0);
        }

        let debt = total - paid;
        if (debt < 0) debt = 0;
        $("#debtAmount").attr("data-debt", debt).text(formatVND(debt));
        $("#totalAmount").val(total);
        $("#paidAmount").val(paid);
        $("#debtAmountHidden").val(debt);

        $("#debtInfo").toggleClass("hidden", debt === 0).fadeTo(300, debt > 0 ? 1 : 0);
    }

    $(document).on("click", ".removeProduct", function () {
        let row = $(this).closest("tr");
        let productId = row.data("product-id");

        $(`#productList .product-entry[data-product-id="${productId}"]`).remove();
        row.fadeOut(300, function () {
            $(this).remove();
            updateTotal();
        });
    });

    function validateImportPrice(input) {
        const value = Number(input.value);
        if (isNaN(value) || value <= 0) {
            input.classList.add('is-invalid');
            input.setCustomValidity('Giá phải lớn hơn 0');
            alert('Vui lòng nhập giá lớn hơn 0');
            input.value = '';
            return false;
        }

        const maxValue = 1000000000;
        if (value > maxValue) {
            input.classList.add('is-invalid');
            input.setCustomValidity('Giá không được vượt quá 1 tỷ');
            alert('Giá không được vượt quá 1 tỷ VND');
            input.value = maxValue;
            return false;
        }

        input.classList.remove('is-invalid');
        input.setCustomValidity('');
        return true;
    }

    $(document).ready(function () {
        $("form").append('<input type="hidden" id="addNewCustomer" name="addNewCustomer" value="false">');

        $("#customerList").on("change", function () {
            $("#addNewCustomer").val($(this).val() === "new" ? "true" : "false");
        });

        $("#paidAmount").on("input change", function () {
            updateDebt();
        });

        $(document).on('input', '.import', function(e) {
            validateImportPrice(this);
            if (typeof updateRowTotal === 'function' && $(this).closest('tr').length) {
                updateRowTotal($(this).closest('tr'));
                updateTotal();
            }
        });

        $(document).on("input change", ".quantity, .package-weight", function () {
            let row = $(this).closest("tr");
            updateRowTotal(row);
            updateTotal();
        });

        $("#createInvoice").on("click", function (e) {
            e.preventDefault();

            let customerId = $("#customerId").val();
            let addNew = $("#addNewCustomer").val();
            let newCustomerName = $("#newCustomerName").val().trim();
            let newCustomerPhone = $("#newCustomerPhone").val().trim();

            if (!customerId && addNew === "false") {
                alert("⚠️ Vui lòng chọn khách hàng hoặc thêm khách hàng mới.");
                return;
            }

            if (addNew === "true" && (!newCustomerName || !newCustomerPhone)) {
                alert("⚠️ Vui lòng nhập đầy đủ Tên và Số điện thoại khách hàng mới.");
                return;
            }

            if ($("#productTable tr").length === 0) {
                alert("⚠️ Vui lòng thêm ít nhất một sản phẩm vào hóa đơn.");
                return;
            }

            if (addNew === "true") {
                $("form").append(`<input type="hidden" name="newCustomerName" value="${newCustomerName}">`);
                $("form").append(`<input type="hidden" name="newCustomerPhone" value="${newCustomerPhone}">`);
            }

            let totalAmount = parseFloat($("#totalPrice").attr("data-total")) || 0;
            let paidAmount = parseFloat($("#paidAmount").val()) || 0;
            let debtAmount = parseFloat($("#debtAmount").attr("data-debt")) || 0;

            $("#customerId").val(customerId);
            $("#totalAmount").val(totalAmount);
            $("#paidAmount").val(paidAmount);
            $("#debtAmountHidden").val(debtAmount);

            $("form").submit();
        });

        const form = document.querySelector('form');
        if (form) {
            form.addEventListener('submit', function(e) {
                const importInputs = document.querySelectorAll('.import');
                let isValid = true;
                importInputs.forEach(input => {
                    if (!validateImportPrice(input)) {
                        isValid = false;
                        input.focus();
                    }
                });
                if (!isValid) {
                    e.preventDefault();
                }
            });
        }
    });
});