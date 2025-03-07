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
            "/login",
            "/createOwner"
    );

    // Danh sách các quyền truy cập dựa trên role
    private static final Map<String, List<String>> roleAccessMap = new HashMap<>();

    static {
        roleAccessMap.put("Admin", List.of(
                "/manageUsers",
                "/admin",
                "/reports",
                "/dashboard", "/home", "/admin.jsp", "/editUser"));

        roleAccessMap.put("Owner", List.of(
                "/owner",
                "/manageBusiness",
                "/finance",
                "/staff", "/home","/owner", "/owner/", "/owner/manageBusiness", "/owner/finance", "/customer", "/owner/owner",
                "/createCustomer.jsp", "/warehouserice", "/ExportRiceController", "/ImportRiceController",
                "/detailWarehouseRice", "/RiceController", "/add_rice.jsp", "/add_debt.jsp",
                "/DebtController", "/PaymentController", "/editStaff", "/createStaff.jsp", "/createStaff",
                "/editCustomer", "/export_rice.jsp", "/import_rice.jsp", "/rice.jsp", "/DebtController2",
                "/manage_debt2.jsp"));

        roleAccessMap.put("Staff", List.of(
                "/staff",
                "/tasks",
                "/customerSupport",
                "/inventory", "/staff/", "/staff/tasks", "/customer", "/owner/owner",
                "/createCustomer.jsp", "/warehouserice", "/ExportRiceController", "/ImportRiceController",
                "/detailWarehouseRice", "/RiceController", "/add_rice.jsp", "/add_debt.jsp",
                "/DebtController", "/PaymentController", "/editCustomer", "/export_rice.jsp",
                "import_rice.jsp", "/DebtController2", "/manage_debt2.jsp"));
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Lấy đường dẫn yêu cầu
        String path = req.getServletPath();

        // Bỏ qua các tài nguyên tĩnh
        if (path.matches(".*(\\.css|\\.js|\\.png|\\.jpg|\\.jpeg|\\.gif|\\.ico|\\.woff|\\.woff2|\\.ttf|\\.svg)$")) {
            chain.doFilter(request, response);
            return;
        }

        // Kiểm tra xem trang có thuộc danh sách công khai không
        if (publicPages.contains(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Kiểm tra session có tồn tại không
        if (session == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // Lấy user từ session
        User userCheck = (User) session.getAttribute("user");
        if (userCheck == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // Lấy role của user
        String role = userCheck.getRole();

        // Kiểm tra quyền truy cập theo role
        if (!isAuthorized(role, path)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập!");
            return;
        }

        // Nếu hợp lệ, tiếp tục request
        chain.doFilter(request, response);
    }

    private boolean isAuthorized(String role, String path) {
        List<String> allowedPaths = roleAccessMap.get(role);
        return allowedPaths != null && allowedPaths.contains(path);
    }
}
