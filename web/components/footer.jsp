<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<footer class="py-4 mt-auto">
    <div class="container-fluid px-4">
        <div class="row">
            <!-- Thông tin bản quyền -->
            <div class="col-md-4 text-center text-md-start mb-3 mb-md-0">
                <p class="text-muted mb-0">&copy; 2025 Warehouse Rice. All Rights Reserved.</p>
                <p class="text-muted small">Designed & Developed by xAI Team</p>
            </div>
            <!-- Liên kết chính sách -->
            <div class="col-md-4 text-center mb-3 mb-md-0">
                <a href="#" class="footer-link">Privacy Policy</a>
                <span class="mx-2">·</span>
                <a href="#" class="footer-link">Terms & Conditions</a>
                <span class="mx-2">·</span>
                <a href="#" class="footer-link">Contact Us</a>
            </div>
            <!-- Mạng xã hội -->
            <div class="col-md-4 text-center text-md-end">
                <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                <a href="#" class="social-icon"><i class="fab fa-github"></i></a>
            </div>
        </div>
    </div>
</footer>

<style>
    footer {
        background: linear-gradient(90deg, #2c3e50 0%, #34495e 100%);
        color: #ecf0f1;
        padding: 2rem 0;
        border-top: 4px solid #3498db;
    }
    .footer-link {
        color: #ecf0f1;
        text-decoration: none;
        font-size: 0.9rem;
        transition: color 0.3s ease;
    }
    .footer-link:hover {
        color: #3498db;
    }
    .social-icon {
        color: #ecf0f1;
        font-size: 1.2rem;
        margin: 0 10px;
        text-decoration: none;
        transition: all 0.3s ease;
    }
    .social-icon:hover {
        color: #3498db;
        transform: scale(1.2);
    }
    .text-muted {
        color: #bdc3c7 !important;
    }
    .small {
        font-size: 0.85rem;
    }
</style>

<!-- Scripts (đặt trong trang chính, không cần trong footer.jsp) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="assets/demo/chart-area-demo.js"></script>
<script src="assets/demo/chart-bar-demo.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="js/datatables-simple-demo.js"></script>