<%-- 
    Document   : sidebar
    Created on : Feb 23, 2025, 9:21:04 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <!-- Nút đóng/mở sidebar -->
        <button class="sb-sidenav-toggle" id="sidebarToggle">
            <i class="fas fa-angle-left"></i>
        </button>

        <div class="sb-sidenav-menu">
            <div class="nav">


                <!-- Danh mục chính (Accordion) -->
                <div class="sb-sidenav-menu-heading text-white">Dashboard</div>
                <a class="nav-link" href="HomeServlet">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    <span class="d-none d-md-inline">Home Dashboard</span>
                </a>

                <!-- Quản lý Nhân sự (Accordion) -->
                <div class="sb-sidenav-menu-heading">Personnel</div>
                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#personnelCollapse" aria-expanded="false" aria-controls="personnelCollapse">
                    <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                    <span class="d-none d-md-inline">Personnel Management</span>
                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                </a>
                <div class="collapse" id="personnelCollapse" aria-labelledby="headingPersonnel" data-bs-parent="#sidenavAccordion">
                    <nav class="sb-sidenav-menu-nested nav">
                        <a class="nav-link" href="AdminServlet">Employee Management</a>
                        <a class="nav-link" href="index.html">Porter Management</a>
                    </nav>
                </div>

                <!-- Quản lý Kho (Accordion) -->
                <div class="sb-sidenav-menu-heading">Warehouse</div>
                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#warehouseCollapse" aria-expanded="false" aria-controls="warehouseCollapse">
                    <div class="sb-nav-link-icon"><i class="fas fa-box"></i></div>
                    <span class="d-none d-md-inline">Warehouse Management</span>
                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                </a>
                <div class="collapse" id="warehouseCollapse" aria-labelledby="headingWarehouse" data-bs-parent="#sidenavAccordion">
                    <nav class="sb-sidenav-menu-nested nav">
                        <a class="nav-link" href="WarehouseRiceServlet">Warehouse Rice</a>
                        <a class="nav-link" href="index.html">Rice Inventory</a>
                    </nav>
                </div>

                <!-- Quản lý Tài chính (Accordion) -->
                <div class="sb-sidenav-menu-heading">Finance</div>
                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#financeCollapse" aria-expanded="false" aria-controls="financeCollapse">
                    <div class="sb-nav-link-icon"><i class="fas fa-dollar-sign"></i></div>
                    <span class="d-none d-md-inline">Financial Management</span>
                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                </a>
                <div class="collapse" id="financeCollapse" aria-labelledby="headingFinance" data-bs-parent="#sidenavAccordion">
                    <nav class="sb-sidenav-menu-nested nav">
                        <a class="nav-link" href="DebtController">Debt Management</a>
                        <a class="nav-link" href="PaymentController">Transaction History</a>
                    </nav>
                </div>

                <!-- Công cụ bổ sung (Accordion) -->
                <div class="sb-sidenav-menu-heading">Tools</div>
                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#toolsCollapse" aria-expanded="false" aria-controls="toolsCollapse">
                    <div class="sb-nav-link-icon"><i class="fas fa-tools"></i></div>
                    <span class="d-none d-md-inline">Additional Tools</span>
                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                </a>
                <div class="collapse" id="toolsCollapse" aria-labelledby="headingTools" data-bs-parent="#sidenavAccordion">
                    <nav class="sb-sidenav-menu-nested nav">
                        <a class="nav-link" href="ExportRiceController">Export Rice</a>
                        <a class="nav-link" href="EditUserServlet">Edit User Profile</a>
                    </nav>
                </div>
            </div>
        </div>
        <div class="sb-sidenav-footer">
            <div class="small text-muted">Logged in as:</div>
            <span class="text-white">Welcome, ${sessionScope.user.fullName}</span>
        </div>
    </nav>
</div>

<style>
    /* Phông chữ và màu sắc */
    @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap');

    .sb-sidenav {
        background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
        box-shadow: 2px 0 8px rgba(0, 0, 0, 0.2);
        transition: width 0.3s ease, transform 0.3s ease;
        width: 250px; /* Chiều rộng mặc định */
        font-family: 'Roboto', sans-serif; /* Phông chữ Roboto */
    }
    .sb-sidenav.collapsed {
        width: 70px; /* Chiều rộng khi thu gọn */
    }
    .sb-sidenav-menu-heading {
        color: #a8b2b9; /* Màu xám nhạt hơn, sang trọng */
        font-size: 0.75rem; /* Giảm kích thước font để tinh tế hơn */
        padding: 0.5rem 1rem;
        text-transform: uppercase;
        background: rgba(255, 255, 255, 0.05);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        font-weight: 500;
    }
    .nav-link {
        color: #ecf0f1; /* Màu trắng nhạt, dễ đọc trên nền tối */
        padding: 0.75rem 1rem;
        display: flex;
        align-items: center;
        font-size: 0.9rem; /* Kích thước font nhỏ hơn, tinh tế */
        font-weight: 400; /* Font-weight nhẹ nhàng */
        transition: all 0.3s ease;
    }
    .nav-link:hover {
        background-color: rgba(255, 255, 255, 0.1);
        color: #3498db; /* Màu xanh chủ đạo khi hover */
    }
    .nav-link.active {
        background-color: rgba(52, 152, 219, 0.2);
        color: #3498db;
        font-weight: 500;
    }
    .sb-nav-link-icon {
        margin-right: 0.5rem;
        min-width: 20px;
        text-align: center;
        color: #a8b2b9; /* Màu xám nhạt cho icon, phù hợp với heading */
    }
    .sb-sidenav-collapse-arrow {
        margin-left: auto;
        color: #ecf0f1;
        transition: transform 0.3s ease;
    }
    .nav-link.collapsed .sb-sidenav-collapse-arrow {
        transform: rotate(-90deg);
    }
    .sb-sidenav-footer {
        background: #2c3e50;
        padding: 1rem;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
    }
    .sb-sidenav-footer .text-muted {
        color: #a8b2b9 !important; /* Màu xám nhạt cho text-muted */
        font-size: 0.8rem;
    }
    .sb-sidenav-footer span {
        font-weight: 500;
        color: #ecf0f1; /* Màu trắng nhạt cho tên người dùng */
        font-size: 0.9rem;
    }

    /* Nút toggle sidebar */
    .sb-sidenav-toggle {
        display: none;
        position: absolute;
        top: 10px;
        right: -40px;
        width: 40px;
        height: 40px;
        background: #2c3e50;
        border: none;
        border-radius: 0 5px 5px 0;
        color: #ecf0f1;
        cursor: pointer;
        box-shadow: 2px 0 8px rgba(0, 0, 0, 0.2);
        transition: background-color 0.3s ease;
        font-family: 'Roboto', sans-serif;
    }
    .sb-sidenav-toggle:hover {
        background-color: #34495e;
    }
    .sb-sidenav-toggle i {
        font-size: 1.2rem;
    }

    /* Ẩn text khi sidebar thu gọn */
    .d-none.d-md-inline {
        display: inline !important;
    }
    .sb-sidenav.collapsed .d-none.d-md-inline {
        display: none !important;
    }
    .sb-sidenav.collapsed .sb-nav-link-icon {
        margin-right: 0;
    }
    .sb-sidenav.collapsed .nav-link {
        justify-content: center;
    }

    /* Hiển thị nút toggle trên màn hình nhỏ */
    @media (max-width: 768px) {
        .sb-sidenav-toggle {
            display: block;
        }
        .sb-sidenav {
            position: fixed;
            top: 0;
            left: -250px;
            height: 100vh;
            z-index: 1000;
        }
        .sb-sidenav.expanded {
            left: 0;
        }
    }
</style>

<script>
    // Toggle sidebar
    document.getElementById('sidebarToggle').addEventListener('click', function() {
        const sidenav = document.querySelector('.sb-sidenav');
        sidenav.classList.toggle('collapsed');
        if (sidenav.classList.contains('collapsed')) {
            this.querySelector('i').classList.remove('fa-angle-left');
            this.querySelector('i').classList.add('fa-angle-right');
        } else {
            this.querySelector('i').classList.remove('fa-angle-right');
            this.querySelector('i').classList.add('fa-angle-left');
        }
    });

    // Toggle sidebar trên mobile
    document.getElementById('sidebarToggle').addEventListener('click', function() {
        const sidenav = document.querySelector('.sb-sidenav');
        sidenav.classList.toggle('expanded');
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="assets/demo/chart-area-demo.js"></script>
<script src="assets/demo/chart-bar-demo.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="js/datatables-simple-demo.js"></script>