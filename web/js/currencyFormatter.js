document.addEventListener("DOMContentLoaded", function () {
    function formatCurrencyVND(value) {
        if (!isNaN(value) && value !== null) {
            return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
        }
        return value;
    }

    function applyFormatting() {
        document.querySelectorAll("#formatVND, .formatVND").forEach(function (element) {
            let value = parseFloat(element.innerText.replace(/[^\d.-]/g, ""));
            if (!isNaN(value)) {
                element.innerText = formatCurrencyVND(value);
            }
        });
    }

    applyFormatting();
});
