$(function () {
    var $ = jQuery.noConflict();

    function formatVND(value) {
        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
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

    $("#productSearch").on("input", function () {
        let keyword = $(this).val().trim();
        if (keyword.length < 2) {
            $("#searchResults").hide();
            return;
        }

        $.get("api/invoice?action=searchProduct&keyword=" + encodeURIComponent(keyword), function (data) {
            let resultBox = $("#searchResults");
            resultBox.empty();
            if (data.length > 0) {
                data.forEach(product => {
                    resultBox.append(`
                        <div class="search-item" data-id="${product.id}" data-name="${product.name}" data-price-per-kg="${product.amount}" data-stock="${product.quantity}">
                            <strong>${product.name}</strong> - ${product.amount} VND/kg (Còn: ${product.quantity} kg)
                            <span class="btn btn-sm btn-success addProduct">+</span>
                        </div>
                    `);
                });
                resultBox.slideDown(200);
            } else {
                resultBox.slideUp(200);
            }
        }, "json").fail(function () {
            console.error("Error fetching products");
        });
    });

    $(document).on("click", ".addProduct", function () {
        let item = $(this).closest(".search-item");
        let productId = item.data("id");
        let productName = item.data("name");
        let pricePerKg = parseFloat(item.data("price-per-kg")); // Giá mỗi kg
        let stock = parseFloat(item.data("stock"));

        if ($("#productTable tr[data-product-id='" + productId + "']").length > 0) {
            alert("Sản phẩm đã tồn tại trong bảng. Vui lòng chọn sản phẩm khác.");
            return;
        }

        let initialPackageWeight = 10; // Số cân nặng của 1 bao
        let initialQuantity = 1; // Số lượng bao
        let initialTotalWeight = initialPackageWeight * initialQuantity;
        let initialPricePerBag = pricePerKg * initialPackageWeight; // Giá mỗi bao
        let initialTotalPrice = initialPricePerBag * initialQuantity;

        let newRow = $(`
            <tr data-product-id="${productId}">
                <td>${productName}</td>
                <td>
                    <select class="form-control package-weight" data-price-per-kg="${pricePerKg}">
                        <option value="10" selected>10 kg</option>
                        <option value="20">20 kg</option>
                        <option value="50">50 kg</option>
                    </select>
                </td>
                <td>
                    <input type="number" class="form-control quantity" value="${initialQuantity}" min="1" data-stock="${stock}">
                </td>
                <td>
                    <span class="unit-price-display">${formatVND(pricePerKg)}</span>
                </td>
                <td>
                    <span class="total-weight">${initialTotalWeight} kg</span>
                </td>
                <td>
                    <span class="total" data-total="${initialTotalPrice}">${formatVND(initialTotalPrice)}</span>
                </td>
                <td><button class="btn btn-danger btn-sm removeProduct">Xóa</button></td>
            </tr>
        `);

        $("#productTable").append(newRow);
        newRow.hide().fadeIn(500);

        $("#productList").append(`
            <div class="product-entry" data-product-id="${productId}">
                <input type="hidden" name="productId[]" value="${productId}">
                <input type="hidden" name="quantity[]" value="${initialQuantity}">
                <input type="hidden" name="perKg[]" value="${initialPackageWeight}">
                <input type="hidden" name="price[]" value="${initialPricePerBag}">
                <input type="hidden" name="pricePerKg[]" value="${pricePerKg}">
            </div>
        `);

        updateRowTotal(newRow);
        updateTotal();
        $("#searchResults").hide();
    });

    $(document).on("input change", ".quantity, .package-weight", function () {
        let row = $(this).closest("tr");
        updateRowTotal(row);
        updateTotal();
    });

    function updateRowTotal(row) {
        let pricePerKg = parseFloat(row.find(".package-weight").data("price-per-kg")); // Giá mỗi kg
        let packageWeight = parseFloat(row.find(".package-weight").val()); // Số cân nặng của 1 bao
        let quantity = parseFloat(row.find(".quantity").val()) || 1; // Số lượng bao
        let stock = parseFloat(row.find(".quantity").data("stock"));

        let totalWeight = packageWeight * quantity;
        let maxQuantity = Math.floor(stock / packageWeight);

        if (totalWeight > stock) {
            alert(`⚠️ Số lượng vượt quá kho! Tối đa có thể mua: ${maxQuantity} bao (${stock} kg).`);
            quantity = maxQuantity;
            totalWeight = packageWeight * maxQuantity;
            row.find(".quantity").val(maxQuantity);
        }

        let pricePerBag = pricePerKg * packageWeight; // Giá mỗi bao
        let totalPrice = pricePerBag * quantity; // Tổng tiền

        row.find(".total-weight").text(`${totalWeight} kg`);
        row.find(".total").attr("data-total", totalPrice).text(formatVND(totalPrice));

        let productId = row.data("product-id");
        let productEntry = $(`#productList .product-entry[data-product-id="${productId}"]`);
        productEntry.find('input[name="quantity[]"]').val(quantity);
        productEntry.find('input[name="perKg[]"]').val(packageWeight);
        productEntry.find('input[name="price[]"]').val(pricePerBag);
    }

    function updateTotal() {
        let total = 0;
        $("#productTable .total").each(function () {
            let rowTotal = parseFloat($(this).attr("data-total")) || 0;
            total += rowTotal;
        });

        $("#totalPrice").attr("data-total", total).text(formatVND(total));
        $("#totalAmount").val(total);
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

    $(document).ready(function () {
        $("form").append('<input type="hidden" id="addNewCustomer" name="addNewCustomer" value="false">');

        $("#customerList").on("change", function () {
            $("#addNewCustomer").val($(this).val() === "new" ? "true" : "false");
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

            $("form").submit();
        });

        $("#paidAmount").on("input", updateDebt);
    });
});