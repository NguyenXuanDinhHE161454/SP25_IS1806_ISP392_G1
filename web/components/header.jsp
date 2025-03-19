<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Warehouse Management</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

    </head>
    <body>
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button>
            <a class="navbar-brand ps-3" href="home">
                <i class="fas fa-warehouse me-2"></i>Kho Gạo
            </a>



            <!-- Hiển thị thông tin người dùng -->
            <ul class="navbar-nav ms-auto me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user fa-fw"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <!-- Navbar Links -->

                                <li class="dropdown-item text-center">
                                    <ul class="navbar-nav ms-auto">
                                        <li class="nav-item">
                                            <a class="nav-link" href="dashboard">
                                                <i class="fas fa-chart-line me-1"></i> Trang Quản Lý
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown-item text-center">
                                    <ul class="navbar-nav ms-auto">
                                        <li class="nav-item">
                                            <a class="nav-link" href="about">
                                                <i class="fas fa-info-circle me-1"></i> Giới thiệu
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown-item text-center">
                                    <ul class="navbar-nav ms-auto">
                                        <li class="nav-item">
                                            <a class="nav-link" href="about">
                                                <i class="fas fa-info-circle me-1"></i> Tên tài khoản
                                            </a>
                                        </li>
                                    </ul>
                                    <strong>${sessionScope.user.fullName}</strong><br>
                                    <small class="text-muted">${sessionScope.user.role}</small>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="account-settings">
                                        <i class="fas fa-user-cog me-2"></i> Cài đặt tài khoản</a>
                                </li>
                                <li><a class="dropdown-item" href="logout">
                                        <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li><a class="dropdown-item" href="login">
                                        <i class="fas fa-sign-in-alt me-2"></i> Đăng nhập</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </li>
            </ul>
        </nav>



        <style>
            .sb-topnav {
                background: linear-gradient(90deg, #2c3e50 0%, #3498db 100%);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                padding: 1rem;
            }
            .navbar-brand {
                font-size: 1.5rem;
                color: #fff;
                font-weight: bold;
                transition: transform 0.3s ease;
            }
            .navbar-brand:hover {
                transform: scale(1.05);
                color: #ecf0f1;
            }
            .nav-link {
                color: #ecf0f1;
                font-weight: 500;
                padding: 0.75rem 1.25rem;
                transition: all 0.3s ease;
            }
            .nav-link:hover {
                color: #f1c40f;
            }
            .dropdown-menu {
                background-color: #2c3e50;
                border: none;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            }
            .dropdown-item {
                color: #ecf0f1;
                padding: 0.5rem 1.5rem;
            }
            .dropdown-item:hover {
                background-color: #3498db;
                color: #fff;
            }
        </style>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>