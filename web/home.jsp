<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="Warehouse Rice Management System" />
        <meta name="author" content="" />
        <title>Home - Warehouse Rice</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            /* Banner Styling */
            .banner-wrapper {
                position: relative;
                height: 60vh;
                overflow: hidden;
            }
            .banner-wrapper img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                object-position: center;
            }
            .banner-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                display: flex;
                align-items: center;
                justify-content: center;
                color: #fff;
                text-align: center;
                opacity: 1;
            }
            .banner-overlay h1 {
                font-size: 2.5rem;
                font-weight: bold;
                text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.7);
            }
            .banner-overlay p {
                font-size: 1.1rem;
                max-width: 500px;
            }
            .cta-button {
                display: inline-block;
                margin-top: 20px;
                padding: 12px 30px;
                background-color: #3498db;
                color: #fff;
                text-decoration: none;
                border-radius: 25px;
                font-weight: 500;
            }

            /* Main Content Styling */
            main {
                padding: 60px 0;
                background-color: #f8f9fa;
            }
            .features-section {
                margin-bottom: 40px;
            }
            .feature-card {
                background: #fff;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .feature-icon {
                font-size: 2rem;
                color: #3498db;
                margin-bottom: 15px;
            }
            .cta-section {
                background: linear-gradient(90deg, #2c3e50 0%, #34495e 100%);
                color: #fff;
                padding: 40px 0;
                text-align: center;
            }
            .cta-section h2 {
                font-size: 2rem;
                margin-bottom: 20px;
            }

        </style>
    </head>
    <body>
        <%@include file="/components/header.jsp"%>

        <!-- Banner Section -->
        <div class="banner-wrapper">
            <img src="assets/img/banner.png" alt="Warehouse Rice Banner" />
            <div class="banner-overlay">
                <div>
                    <h1>Welcome to Warehouse Rice</h1>
                    <p>The best rice in Vietnam.</p>

                </div>
            </div>
        </div>

        <!-- Features Section -->
        <main class="container">
            <section class="features-section">
                <h2 class="text-center mb-5">Why Choose Warehouse Rice?</h2>
                <div class="row">
                    <!-- Quản lý Nhân sự -->
                    <div class="col-md-4">
                        <div class="feature-card">
                            <i class=""></i>
                            <h3>Employee Management</h3>
                            <p>Effortlessly manage your staff and porters with our advanced tools. Access employee details and optimize workforce efficiency via our Admin and Porter features.</p>
                        </div>
                    </div>
                    <!-- Quản lý Kho -->
                    <div class="col-md-4">
                        <div class="feature-card">
                            <i class=""></i>
                            <h3>Warehouse Management</h3>
                            <p>Track rice inventory, monitor warehouse status, and streamline operations with our Warehouse Rice and Rice modules.</p>
                        </div>
                    </div>
                    <!-- Quản lý Tài chính -->
                    <div class="col-md-4">
                        <div class="feature-card">
                            <i class=""></i>
                            <h3>Financial Management</h3>
                            <p>Handle debts, payments, and transactions seamlessly with our Debt and Transaction History controllers.</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Call to Action Section -->
            <section class="cta-section">
                <h2>Ready to Optimize Your Warehouse?</h2>
                <p>Sign up today and experience the power of Warehouse Rice management system!</p>
                <a href="login" class="cta-button">Get Started Now</a>
            </section>
        </main>

        <%@include file="/components/footer.jsp"%>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>