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
                transition: transform 0.5s ease;
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
                opacity: 0;
                animation: fadeIn 1.5s ease forwards;
            }
            .banner-overlay h1 {
                font-size: 2.5rem;
                font-weight: bold;
                text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.7);
                transform: translateY(20px);
                animation: slideUp 1s ease 0.5s forwards;
            }
            .banner-overlay p {
                font-size: 1.1rem;
                max-width: 500px;
                transform: translateY(30px);
                animation: slideUp 1s ease 0.7s forwards;
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
                transition: all 0.3s ease;
                transform: translateY(40px);
                animation: slideUp 1s ease 0.9s forwards;
            }
            .cta-button:hover {
                background-color: #2980b9;
                transform: scale(1.1);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
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
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .feature-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
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

            /* Keyframes cho animation */
            @keyframes fadeIn {
                to {
                    opacity: 1;
                }
            }
            @keyframes slideUp {
                to {
                    transform: translateY(0);
                }
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
                    <p>Streamline your rice warehouse operations with our cutting-edge management system.</p>
                    <a href="#features" class="cta-button">Discover Features</a>
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
                            <i class="fas fa-users feature-icon"></i>
                            <h3>Employee Management</h3>
                            <p>Effortlessly manage your staff and porters with our advanced tools. Access employee details and optimize workforce efficiency via our <a href="AdminServlet">Admin</a> and <a href="index.html">Porter</a> features.</p>
                        </div>
                    </div>
                    <!-- Quản lý Kho -->
                    <div class="col-md-4">
                        <div class="feature-card">
                            <i class="fas fa-box feature-icon"></i>
                            <h3>Warehouse Management</h3>
                            <p>Track rice inventory, monitor warehouse status, and streamline operations with our <a href="WarehouseRiceServlet">Warehouse Rice</a> and <a href="index.html">Rice</a> modules.</p>
                        </div>
                    </div>
                    <!-- Quản lý Tài chính -->
                    <div class="col-md-4">
                        <div class="feature-card">
                            <i class="fas fa-dollar-sign feature-icon"></i>
                            <h3>Financial Management</h3>
                            <p>Handle debts, payments, and transactions seamlessly with our <a href="DebtController">Debt</a> and <a href="PaymentController">Transaction History</a> controllers.</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Call to Action Section -->
            <section class="cta-section">
                <h2>Ready to Optimize Your Warehouse?</h2>
                <p>Sign up today and experience the power of Warehouse Rice management system!</p>
                <a href="LoginServlet" class="cta-button">Get Started Now</a>
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
        <script>
            // Hiệu ứng Parallax cho banner
            window.addEventListener('scroll', function() {
                const bannerImg = document.querySelector('.banner-wrapper img');
                const scrollPosition = window.pageYOffset;
                bannerImg.style.transform = `translateY(${scrollPosition * 0.4}px)`;
            });

            // Hiệu ứng hover cho feature cards (nếu cần thêm)
            document.querySelectorAll('.feature-card').forEach(card => {
                card.addEventListener('mouseover', function() {
                    this.style.transform = 'translateY(-5px)';
                    this.style.boxShadow = '0 6px 15px rgba(0, 0, 0, 0.2)';
                });
                card.addEventListener('mouseout', function() {
                    this.style.transform = 'translateY(0)';
                    this.style.boxShadow = '0 4px 8px rgba(0, 0, 0, 0.1)';
                });
            });
        </script>
    </body>
</html>