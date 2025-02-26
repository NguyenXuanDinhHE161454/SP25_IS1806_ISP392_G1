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
        <nav class="sb-topnav navbar navbar-expand navbar-dark">
            <a class="navbar-brand ps-3" href="home">
                <i class=""></i>Warehouse Rice
            </a>
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!">
                <i class="fas fa-bars"></i>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Personnel</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="admin">Seller</a></li>
                            <li><a class="dropdown-item" href="index.html">Porter</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Warehouse</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="warehouserice">Zone</a></li>
                            <li><a class="dropdown-item" href="index.html">Rice</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Finance</a>
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
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <li><a class="dropdown-item" href="#!">Welcome, ${sessionScope.user.fullName}</a></li>
                                    <li><a class="dropdown-item" href="logout">Logout</a></li>
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
            .sb-topnav {
                background: linear-gradient(90deg, #2c3e50 0%, #3498db 100%);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                padding: 1rem;
            }
            .navbar-brand {
                font-size: 1.5rem;
                color: #fff;
                font-weight: bold;
                transition: none; /* Bỏ hiệu ứng phóng to */
            }
            .navbar-brand:hover {
                transform: none; /* Bỏ hiệu ứng phóng to */
                color: #fff; /* Giữ nguyên màu khi hover */
            }
            .nav-link {
                color: #ecf0f1;
                font-weight: 500;
                padding: 0.75rem 1.25rem;
                transition: none; /* Bỏ hiệu ứng đổi màu */
            }
            .nav-link:hover {
                color: #ecf0f1; /* Giữ nguyên màu khi hover */
            }
        </style>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>
