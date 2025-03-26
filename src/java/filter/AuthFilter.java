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

@WebFilter("/*")
public class AuthFilter implements Filter {

    private static final Map<String, List<String>> roleAccessMap = new HashMap<>();

    static {
        roleAccessMap.put("Admin", List.of(
                "/InvoiceController", "/InvoiceController?action=export-invoice", "/ProductController",
                "/InvoiceController?action=import-invoice","/ZoneController", "/CustomerDebtController",
                "/DebtCustomerController","/ProfileController","/StaffController",
                "/manageUsers", 
                "/admin", 
                "/reports", 
                "/dashboard"));
        roleAccessMap.put("Staff", List.of(
                "/InvoiceController", 
                "/InvoiceController?action=export-invoice", "/ProductController",
                "/InvoiceController?action=import-invoice","/ZoneController", "/CustomerDebtController",
                "/DebtCustomerController","/ProfileController",
                "/tasks", 
                "/customerSupport", 
                "/dashboard", 
                "/InvoiceController", 
                "/DebtCustomerController"));
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String path = req.getServletPath();

        if (isStaticResource(path) || isPublicPage(path)) {
            chain.doFilter(request, response);
            return;
        }

        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/401.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (requiresAuthorization(path) && !isAuthorized(user.getRole(), path)) {
            res.sendRedirect(req.getContextPath() + "/401.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isStaticResource(String path) {
        return path.matches(".*(\\.css|\\.js|\\.png|\\.jpg|\\.jpeg|\\.gif|\\.ico|\\.woff|\\.woff2|\\.ttf|\\.svg)$");
    }

    private boolean isPublicPage(String path) {
        return roleAccessMap.values().stream().noneMatch(list -> list.contains(path));
    }

    private boolean requiresAuthorization(String path) {
        return roleAccessMap.values().stream().anyMatch(list -> list.contains(path));
    }

    private boolean isAuthorized(String role, String path) {
        return roleAccessMap.getOrDefault(role, List.of()).contains(path);
    }
}
