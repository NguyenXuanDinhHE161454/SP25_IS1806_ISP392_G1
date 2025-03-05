package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import model.User;

@WebFilter("/*") // Áp dụng filter cho tất cả request
public class AuthFilter implements Filter {

    // Danh sách các trang công khai (không yêu cầu đăng nhập)
    private static final List<String> publicPages = List.of(
            "/login.jsp",
            "/register.jsp",
            "/about.jsp",
            "/contact.jsp",
            "/home",
            "/login"
    );

    // Danh sách các quyền truy cập dựa trên role
    private static final Map<String, List<String>> roleAccessMap = new HashMap<>();

    static {
        roleAccessMap.put("Admin", List.of(
                "/admin", "/admin/", "/admin/dashboard", "/admin/reports", "/manageUsers"
        ));

        roleAccessMap.put("Owner", List.of(
                "/home","/owner", "/owner/", "/owner/manageBusiness", "/owner/finance", "/customer", "/owner/owner",
                "/createCustomer.jsp", "/warehouserice", "/ExportRiceController", "/ImportRiceController",
                "/detailWarehouseRice", "/RiceController", "/add_rice.jsp", "/add_debt.jsp",
                "/DebtController", "/PaymentController"
        ));

        roleAccessMap.put("Staff", List.of(
                "/staff", "/staff/", "/staff/tasks", "/customer", "/owner/owner",
                "/createCustomer.jsp", "/warehouserice", "/ExportRiceController", "/ImportRiceController",
                "/detailWarehouseRice", "/RiceController", "/add_rice.jsp", "/add_debt.jsp",
                "/DebtController", "/PaymentController"
        ));
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getServletPath();
        System.out.println("Requested Path: " + path);

        // Kiểm tra xem trang có thuộc danh sách công khai không
        if (publicPages.contains(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Kiểm tra session có tồn tại không
        if (session == null) {
            System.out.println("Session is null, redirecting to login.");
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // Lấy user từ session
        User userCheck = (User) session.getAttribute("user");
        if (userCheck == null) {
            System.out.println("User is null, redirecting to login.");
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // Lấy role của user
        String role = userCheck.getRole();
        System.out.println("User role: " + role);

        // Kiểm tra quyền truy cập theo role
        if (!isAuthorized(role, path)) {
            System.out.println("Access Denied: " + role + " cannot access " + path);
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập!");
            return;
        }

        // Nếu hợp lệ, tiếp tục request
        chain.doFilter(request, response);
    }

    private boolean isAuthorized(String role, String path) {
        List<String> allowedPaths = roleAccessMap.get(role);
        if (allowedPaths == null) return false;

        // Kiểm tra nếu `path` bắt đầu với bất kỳ đường dẫn nào trong danh sách quyền
        for (String allowedPath : allowedPaths) {
            if (path.startsWith(allowedPath)) {
                return true;
            }
        }
        return false;
    }
}