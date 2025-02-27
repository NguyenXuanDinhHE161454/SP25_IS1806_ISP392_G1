<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--abcd-->
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
        <nav class="">
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button>
            <a class="navbar-brand ps-3" href="home">
                <i class=""></i>Warehouse Rice
            </a>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle ps-5" href="#" role="button" data-bs-toggle="dropdown">
                            <i class=""></i> Personnel
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="admin">Owner Manage</a></li>
                            <li><a class="dropdown-item" href="owner">Staff Manage</a></li>
                            <li><a class="dropdown-item" href="customer">Customer Manage</a></li>
                            <li><a class="dropdown-item" href="index.html">Porter</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle ps-5" href="#" role="button" data-bs-toggle="dropdown">
                            <i class=""></i> Warehouse
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="warehouserice">Warehouse Rice</a></li>
                            <li><a class="dropdown-item" href="index.html">Rice</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle ps-5" href="#" role="button" data-bs-toggle="dropdown">
                            <i class=""></i> Finance
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="DebtController">Debt</a></li>
                            <li><a class="dropdown-item" href="PaymentController">Transaction History</a></li>
                        </ul>
                    </li>
                </ul>

                <ul class="navbar-nav ms-auto me-3 me-lg-4">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user fa-fw"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <li><a class="dropdown-item" href="#!">Welcome, ${sessionScope.user.fullName}</a></li>
                                    <li><a class="dropdown-item" href="login">Logout</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a class="dropdown-item" href="login">Login</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </li>
                </ul>
            </div>
        </nav>

        <style>
            /* Bỏ hiệu ứng nổi và đổi màu khi click */
            .sb-topnav {
                background: linear-gradient(90deg, #2c3e50 0%, #3498db 100%);
                padding: 1rem;
                box-shadow: none;
            }

            .navbar-brand {
                font-size: 1.5rem;
                color: #fff;
                font-weight: bold;
            }

            .navbar-brand:hover, .navbar-brand:active {
                transform: none;
                color: #fff;
            }

            .nav-link {
                color: #ecf0f1;
                font-weight: 500;
                padding: 0.75rem 1.25rem;
            }

            .nav-link:hover, .nav-link:active {
                color: #ecf0f1 !important;
                background: none !important;
            }

            .dropdown-menu {
                background-color: #2c3e50;
                border: none;
                box-shadow: none;
            }

            .dropdown-item {
                color: #ecf0f1;
                padding: 0.5rem 1.5rem;
            }

            .dropdown-item:hover, .dropdown-item:active {
                background-color: transparent !important;
                color: #ecf0f1 !important;
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