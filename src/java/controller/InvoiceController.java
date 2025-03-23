package controller;

import DBContext.DatabaseConnection;
import dao.CustomerDAO;
import dao.DebtDAO;
import dao.InvoiceDAO;
import dao.InvoiceDetailDAO;
import dao.ProductDAO;
import dto.InvoiceCreateDTO;
import dto.InvoiceDTO;
import dto.ProductItemDTO;
import enums.InvoiceStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;
import model.User;
import utils.ConversionUtils;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import model.Debt;
import model.Invoice;
import model.InvoiceDetail;
import utils.JsonUtils;

@WebServlet(name = "InvoiceController", urlPatterns = {"/InvoiceController"})
public class InvoiceController extends HttpServlet {

    private static final int PAGE_SIZE = 10;
    private final ProductDAO productDAO = new ProductDAO();
    private final InvoiceDAO invoiceDAO = new InvoiceDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();
    DebtDAO debtDAO = new DebtDAO();

    private static final Logger LOGGER = Logger.getLogger(InvoiceController.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action == null ? "" : action) {
            case "delete" ->
                handleDelete(request, response);
            case "import-invoice" ->
                forwardToJsp(request, response, "import-invoice.jsp");
            case "export-invoice" ->
                forwardToJsp(request, response, "export-invoice.jsp");
            default ->
                loadInvoiceList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = getUserFromSession(request);
        String action = request.getParameter("action");
        switch (action == null ? "" : action) {
            case "import-invoice" ->
                handleImportInvoice(request, response, user);
            case "export-invoice" ->
                handleExportInvoice(request, response, user);
            default ->
                loadInvoiceList(request, response);
        }

    }

    private void loadInvoiceList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy và xử lý các tham số từ request
            String keyword = trimToNull(request.getParameter("keyword"));
            Integer customerId = parseInt(request.getParameter("customerId"));
            Integer userId = parseInt(request.getParameter("userId"));
            LocalDateTime fromDate = parseDate(request.getParameter("fromDate"));
            LocalDateTime toDate = parseDate(request.getParameter("toDate"));
            int page = Math.max(1, parseInt(request.getParameter("page"), 1));
            int offset = (page - 1) * PAGE_SIZE;

            // Gọi DAO để lấy dữ liệu
            List<InvoiceDTO> invoices = invoiceDAO.getByPage(
                    keyword,
                    customerId != null ? String.valueOf(customerId) : null,
                    userId != null ? String.valueOf(userId) : null,
                    fromDate,
                    toDate,
                    offset,
                    PAGE_SIZE
            );
            int totalRecords = invoiceDAO.countInvoices(
                    keyword,
                    customerId != null ? String.valueOf(customerId) : null,
                    userId != null ? String.valueOf(userId) : null,
                    fromDate,
                    toDate
            );
            int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

            // Đặt các thuộc tính cho request
            setRequestAttributes(request, Map.of(
                    "invoiceList", invoices,
                    "currentPage", page,
                    "totalPages", totalPages,
                    "keyword", keyword == null ? "" : keyword
            ));

            // Chuyển tiếp đến JSP
            forwardToJsp(request, response, "invoice-list.jsp");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to load invoice list", e);
            forwardWithError(request, response, "Error loading invoices: " + e.getMessage());
        }
    }

    // Helper method để xử lý chuỗi rỗng thành null
    private String trimToNull(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        return value.trim();
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            int id = requireInt(request.getParameter("id"), "Invoice ID");
            int deletedBy = getUserIdFromSession(request);
            if (!invoiceDAO.softDeleteInvoice(id, deletedBy)) {
                throw new Exception("Failed to delete invoice");
            }
            response.sendRedirect(request.getHeader("Referer"));
        } catch (Exception e) {
            forwardWithError(request, response, "Error deleting invoice: " + e.getMessage());
        }
    }

    private void handleImportInvoice(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        try {
            // Tạo InvoiceDTO từ request
            InvoiceDTO invoice = createInvoiceFromRequest(request, user);
            invoice.setCreateById(user.getUserId());
            invoice.setStatus(InvoiceStatus.COMPLETED);
            invoice.setType(enums.EnumInvoiceType.IMPORT.getCode());
            ProductDAO productDAO = new ProductDAO();

            // Thêm Invoice vào cơ sở dữ liệu
            InvoiceDAO invoiceDAO = new InvoiceDAO();
            int invoiceId = invoiceDAO.addInvoiceReturnNewId(convertToInvoiceEntity(invoice, user.getUserId()));
            if (invoiceId <= 0) {
                throw new RuntimeException("Failed to create invoice in database");
            }
            invoice.setId(invoiceId);

            // Thêm InvoiceDetails vào cơ sở dữ liệu
            List<InvoiceDetail> details = convertToInvoiceDetails(invoice.getProducts(), invoiceId, user.getUserId());
            InvoiceDetailDAO detailDAO = new InvoiceDetailDAO();
            List<Integer> detailIds = detailDAO.addInvoiceDetails(details);
            if (detailIds.size() != details.size()) {
                throw new RuntimeException("Failed to add all invoice details");
            }

            // Cập nhật số lượng sản phẩm trong kho (tăng lên)
            int totalLoad = 0;
            for (ProductItemDTO product : invoice.getProducts()) {
                totalLoad += product.getQuantity() * product.getAmountPerKg();
                int temp = product.getQuantity() * product.getAmountPerKg();
                Integer updatedProductId = productDAO.updateProductQuantity(
                        product.getProductId(),
                        temp,
                        true
                );
                if (updatedProductId == -1) {
                    throw new RuntimeException("Failed to update quantity for product ID: " + product.getProductId());
                }
            }

            // Xử lý phiếu nợ nếu cần
            if (invoice.getPaidAmount().compareTo(invoice.getPayment()) < 0) {
                String payload = JsonUtils.objectToJson(invoice);
                Debt debt = Debt.builder()
                        .debtType(enums.EnumDebtType.STORE_OWE.getCode())
                        .amount(invoice.getDebtAmount())
                        .customerId(invoice.getCustomerId())
                        .createdBy(user.getUserId())
                        .createdAt(LocalDateTime.now())
                        .debtDate(LocalDateTime.now())
                        .payload(payload)
                        .build();
                debtDAO.addDebt(debt);
            }
            request.setAttribute("totalLoad", totalLoad);
            forwardToSummary(request, response, invoice);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error exporting invoice", e);
            forwardWithError(request, response, "Error exporting invoice: " + e.getMessage());
        }
    }

    private void handleExportInvoice(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        try {
            // Tạo InvoiceDTO từ request
            InvoiceDTO invoice = createInvoiceFromRequest(request, user);
            invoice.setCreateById(user.getUserId());
            invoice.setType(enums.EnumInvoiceType.EXPORT.getCode());
            invoice.setStatus(InvoiceStatus.COMPLETED);
            ProductDAO productDAO = new ProductDAO();

            // Kiểm tra số lượng trong kho trước khi thực hiện
            for (ProductItemDTO product : invoice.getProducts()) {
                int currentQuantity = productDAO.getProductById(product.getProductId()).getQuantity();
                if (currentQuantity < product.getQuantity() * product.getAmountPerKg()) {
                    throw new IllegalStateException("Insufficient quantity for product ID: " + product.getProductId());
                }
            }

            // Thêm Invoice vào cơ sở dữ liệu
            InvoiceDAO invoiceDAO = new InvoiceDAO();
            int invoiceId = invoiceDAO.addInvoiceReturnNewId(convertToInvoiceEntity(invoice, user.getUserId()));
            if (invoiceId <= 0) {
                throw new RuntimeException("Failed to create invoice in database");
            }
            invoice.setId(invoiceId);

            // Thêm InvoiceDetails vào cơ sở dữ liệu
            List<InvoiceDetail> details = convertToInvoiceDetails(invoice.getProducts(), invoiceId, user.getUserId());
            InvoiceDetailDAO detailDAO = new InvoiceDetailDAO();
            List<Integer> detailIds = detailDAO.addInvoiceDetails(details);
            if (detailIds.size() != details.size()) {
                throw new RuntimeException("Failed to add all invoice details");
            }
            
            int totalLoad = 0;
            // Cập nhật số lượng sản phẩm trong kho (giảm đi)
            for (ProductItemDTO product : invoice.getProducts()) {
                totalLoad += product.getQuantity() * product.getAmountPerKg();
                int temp = product.getQuantity() * product.getAmountPerKg();
                Integer updatedProductId = productDAO.updateProductQuantity(
                        product.getProductId(),
                        product.getQuantity(),
                        false
                );
                if (updatedProductId == -1) {
                    throw new RuntimeException("Failed to update quantity for product ID: " + product.getProductId());
                }
            }

            // Xử lý phiếu nợ nếu cần
            if (invoice.getPaidAmount().compareTo(invoice.getPayment()) < 0) {
                String payload = JsonUtils.objectToJson(invoice);
                Debt debt = Debt.builder()
                        .debtType(enums.EnumDebtType.CUSTOMER_BORROW.getCode())
                        .amount(invoice.getDebtAmount())
                        .customerId(invoice.getCustomerId())
                        .createdBy(user.getUserId())
                        .createdAt(LocalDateTime.now())
                        .debtDate(LocalDateTime.now())
                        .payload(payload)
                        .build();
                debtDAO.addDebt(debt);
            }
            forwardToSummary(request, response, invoice);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error exporting invoice", e);
            forwardWithError(request, response, "Error exporting invoice: " + e.getMessage());
        }
    }

// Chuyển InvoiceDTO thành Invoice entity
    private Invoice convertToInvoiceEntity(InvoiceDTO dto, int userId) {
        return Invoice.builder()
                .id(dto.getId())
                .createDate(dto.getCreateDate())
                .payment(dto.getPayment())
                .customerId(dto.getCustomerId())
                .userId(userId)
                .type(enums.EnumDebtType.CUSTOMER_BORROW.getCode()) // Giả định loại hóa đơn là EXPORT
                .paidAmount(dto.getPaidAmount())
                .description(dto.getDescription())
                .createdBy(userId)
                .createdAt(LocalDateTime.now())
                .isDeleted(false)
                .build();
    }

    private List<InvoiceDetail> convertToInvoiceDetails(List<ProductItemDTO> products, int invoiceId, int userId) {
        return products.stream()
                .map(product -> InvoiceDetail.builder()
                .invoiceId(invoiceId)
                .productId(product.getProductId())
                .unitPrice(product.getUnitPrice())
                .quantity(product.getQuantity())
                .amountPerKg(product.getAmountPerKg())
                .description(product.getDescription())
                .createdBy(userId)
                .createdAt(LocalDateTime.now())
                .isDeleted(false)
                .build())
                .collect(Collectors.toList());
    }

    private InvoiceCreateDTO parseInvoiceRequest(HttpServletRequest request) {
        Integer customerId = parseInt(request.getParameter("customerId"));
        String customerName = request.getParameter("customerName");
        String phoneNumber = request.getParameter("phoneNumber");
        List<ProductItemDTO> products = parseProducts(request, "productIds", "quantities", "unitPrices", "PerKgs");

        BigDecimal totalAmount = products.stream()
                .map(ProductItemDTO::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        return InvoiceCreateDTO.builder()
                .customerId(customerId)
                .customerName(customerName)
                .phoneNumber(phoneNumber)
                .productList(products)
                .totalAmount(totalAmount)
                .debtAmount(totalAmount)
                .createdAt(LocalDateTime.now())
                .createdBy(getUserIdFromSession(request))
                .build();
    }

    private InvoiceDTO createInvoiceFromRequest(HttpServletRequest request, User user) {
        return InvoiceDTO.builder()
                .customerId(getCustomerId(request, user))
                .payment(toBigDecimal(request.getParameter("totalAmount")))
                .paidAmount(toBigDecimal(request.getParameter("paidAmount")))
                .debtAmount(toBigDecimal(request.getParameter("debtAmount")))
                .description(request.getParameter("description"))
                .createDate(LocalDateTime.now())
                .status(getInvoiceStatus(toBigDecimal(request.getParameter("debtAmount"))))
                .products(parseProducts(request, "productId[]", "quantity[]", "price[]", "perKg[]"))
                .build();
    }

    private int getCustomerId(HttpServletRequest request, User user) {
        int customerId = toInt(request.getParameter("customerId"));
        if (customerId <= 0 && "true".equals(request.getParameter("addNewCustomer"))) {
            return createNewCustomer(request, user);
        }
        return customerId;
    }

    private int createNewCustomer(HttpServletRequest request, User user) {
        Customer customer = Customer.builder()
                .fullName(requireNonEmpty(request.getParameter("newCustomerName"), "Customer name"))
                .phoneNumber(requireNonEmpty(request.getParameter("newCustomerPhone"), "Customer phone"))
                .build();
        return requirePositive(customerDAO.addCustomerAndGetId(customer, user.getUserId()), "Failed to create customer");
    }

    private List<ProductItemDTO> parseProducts(HttpServletRequest request, String idParam, String qtyParam, String priceParam, String perKgParam) {
        String[] ids = requireArray(request.getParameterValues(idParam), "Product IDs");
        String[] quantities = requireArray(request.getParameterValues(qtyParam), "Quantities");
        String[] prices = requireArray(request.getParameterValues(priceParam), "Prices");
        String[] perKgs = requireArray(request.getParameterValues(perKgParam), "PerKgs"); // Sửa lỗi tham số sai

        validateArrayLengths(ids, quantities, prices, perKgs);

        return IntStream.range(0, ids.length)
                .mapToObj(i -> {
                    int quantity = toInt(quantities[i]);
                    BigDecimal unitPrice = toBigDecimal(prices[i]);
                    BigDecimal totalPrice = unitPrice.multiply(BigDecimal.valueOf(quantity));

                    return ProductItemDTO.builder()
                            .productId(toInt(ids[i]))
                            .quantity(quantity)
                            .unitPrice(unitPrice)
                            .amountPerKg(toInt(perKgs[i]))
                            .totalPrice(totalPrice) // Đặt giá trị sau khi tính toán
                            .build();
                })
                .peek(this::validateProduct)
                .collect(Collectors.toList());
    }

    // Helper Methods
    private User getUserFromSession(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            user = new User();
            user.setUserId(1);
        }
        return user;
    }

    private int getUserIdFromSession(HttpServletRequest request) {
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        return userId != null ? userId : 1;
    }

    private Integer parseInt(String value) {
        return value != null && !value.isEmpty() ? Integer.parseInt(value) : null;
    }

    private int parseInt(String value, int defaultValue) {
        return ConversionUtils.toInt(value, defaultValue);
    }

    private int toInt(String value) {
        return ConversionUtils.toInt(value, -1);
    }

    private BigDecimal toBigDecimal(String value) {
        return ConversionUtils.toBigDecimal(value, BigDecimal.ZERO);
    }

    private LocalDateTime parseDate(String dateStr) {
        return dateStr != null && !dateStr.isEmpty() ? LocalDateTime.parse(dateStr) : null;
    }

    private String requireNonEmpty(String value, String fieldName) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(fieldName + " is required");
        }
        return value;
    }

    private String[] requireArray(String[] array, String name) {
        if (array == null || array.length == 0) {
            throw new IllegalArgumentException(name + " cannot be empty");
        }
        return array;
    }

    private int requireInt(String value, String fieldName) {
        int val = toInt(value);
        if (val <= 0) {
            throw new IllegalArgumentException(fieldName + " must be positive");
        }
        return val;
    }

    private int requirePositive(int value, String message) {
        if (value <= 0) {
            throw new IllegalStateException(message);
        }
        return value;
    }

    private void validateArrayLengths(String[]... arrays) {
        int length = arrays[0].length;
        if (!Arrays.stream(arrays).allMatch(arr -> arr.length == length)) {
            throw new IllegalArgumentException("Array lengths must match");
        }
    }

    private void validateProduct(ProductItemDTO item) {
        if (item.getProductId() <= 0 || item.getQuantity() <= 0
                || item.getUnitPrice().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Invalid product data");
        }
    }

    private InvoiceStatus getInvoiceStatus(BigDecimal debtAmount) {
        return debtAmount.compareTo(BigDecimal.ZERO) <= 0 ? InvoiceStatus.COMPLETED : InvoiceStatus.PENDING;
    }

    private void forwardToSummary(HttpServletRequest request, HttpServletResponse response, InvoiceDTO invoice)
            throws ServletException, IOException {
        request.setAttribute("invoice", invoice);
        forwardToJsp(request, response, "invoice-summary.jsp");
    }

    private void forwardToJsp(HttpServletRequest request, HttpServletResponse response, String jsp)
            throws ServletException, IOException {
        request.getRequestDispatcher(jsp).forward(request, response);
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String error)
            throws ServletException {
        request.setAttribute("error", error);
        try {
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error forwarding to error page", e);
        }
    }

    private void setRequestAttributes(HttpServletRequest request, Map<String, Object> attributes) {
        attributes.forEach(request::setAttribute);
    }
}
