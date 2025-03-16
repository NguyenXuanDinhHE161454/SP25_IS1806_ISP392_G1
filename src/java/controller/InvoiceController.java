package controller;

import dao.InvoiceDAO;
import dto.InvoiceCreateDTO;
import dto.InvoiceDTO;
import enums.InvoiceStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import utils.EnumHelper;

@WebServlet(name = "InvoiceController", urlPatterns = {"/InvoiceController"})
public class InvoiceController extends HttpServlet {

    private final InvoiceDAO invoiceDAO = new InvoiceDAO();
    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            handleDelete(request, response);
            return;
        }

        loadInvoiceList(request, response);
    }

    private void loadInvoiceList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String keyword = request.getParameter("keyword");
            String customerIdStr = request.getParameter("customerId");
            String userIdStr = request.getParameter("userId");
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");
            int page = parseInt(request.getParameter("page"), 1);
            int offset = (page - 1) * PAGE_SIZE;

            LocalDateTime fromDate = parseDate(fromDateStr);
            LocalDateTime toDate = parseDate(toDateStr);

            List<InvoiceDTO> invoiceList = invoiceDAO.getByPage(
                    keyword, customerIdStr, userIdStr, fromDate, toDate, offset, PAGE_SIZE);

            int totalRecords = invoiceDAO.countInvoices(keyword, customerIdStr, userIdStr, fromDate, toDate);
            int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

            request.setAttribute("invoiceList", invoiceList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("keyword", keyword);
            request.getRequestDispatcher("/invoice-list.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading invoices: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = parseInt(request.getParameter("id"), -1);
            if (id == -1) {
                throw new IllegalArgumentException("Invoice ID is required");
            }

            Integer deletedBy = (Integer) request.getSession().getAttribute("userId");
            if (deletedBy == null) {
                deletedBy = 1;
            }

            boolean success = invoiceDAO.softDeleteInvoice(id, deletedBy);
            if (!success) {
                throw new Exception("Failed to delete invoice");
            }

            response.sendRedirect(request.getHeader("Referer"));
        } catch (Exception e) {
            request.setAttribute("error", "Error deleting invoice: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            InvoiceCreateDTO invoice = parseInvoiceRequest(request);
            request.setAttribute("invoice", invoice);
            request.getRequestDispatcher("/invoice-summary.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error creating invoice: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private InvoiceCreateDTO parseInvoiceRequest(HttpServletRequest request) {
        Integer customerId = parseInt(request.getParameter("customerId"), -1);
        String customerName = request.getParameter("customerName");
        String phoneNumber = request.getParameter("phoneNumber");

        String[] productIds = request.getParameterValues("productIds");
        String[] quantities = request.getParameterValues("quantities");
        String[] unitPrices = request.getParameterValues("unitPrices");

        List<InvoiceCreateDTO.ProductItemDTO> productList
                = IntStream.range(0, productIds.length)
                        .mapToObj(i -> InvoiceCreateDTO.ProductItemDTO.builder()
                        .productId(Integer.parseInt(productIds[i]))
                        .productName(request.getParameter("productName" + productIds[i]))
                        .quantity(Integer.parseInt(quantities[i]))
                        .unitPrice(new BigDecimal(unitPrices[i]))
                        .totalPrice(new BigDecimal(unitPrices[i]).multiply(new BigDecimal(quantities[i])))
                        .build())
                        .collect(Collectors.toList());

        BigDecimal totalAmount = productList.stream()
                .map(InvoiceCreateDTO.ProductItemDTO::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        Integer createdBy = (Integer) request.getSession().getAttribute("userId");
        if (createdBy == null) {
            createdBy = 1;
        }

        return InvoiceCreateDTO.builder()
                .customerId(customerId)
                .customerName(customerName)
                .phoneNumber(phoneNumber)
                .productList(productList)
                .totalAmount(totalAmount)
                .debtAmount(totalAmount)
                .createdAt(LocalDateTime.now())
                .createdBy(createdBy)
                .build();
    }

    private int parseInt(String value, int defaultValue) {
        try {
            return (value != null && !value.isEmpty()) ? Integer.parseInt(value) : defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private LocalDateTime parseDate(String dateStr) {
        return (dateStr != null && !dateStr.isEmpty()) ? LocalDateTime.parse(dateStr) : null;
    }
}
