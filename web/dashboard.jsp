<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="utils.EnumHelper" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Invoice Management - Warehouse Rice Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
    <style>
        body { background-color: #f5f7fa; font-family: Arial, sans-serif; }
        .card { border: none; box-shadow: 0 2px 10px rgba(0,0,0,0.1); background-color: #fff; }
        .card-header { background-color: #007bff; color: white; }
        canvas { max-height: 400px; }
    </style>
</head>
<body>
    <%@include file="/components/header.jsp"%>

    <div id="layoutSidenav">
        <%@include file="/components/sidebar.jsp"%>

        <div id="layoutSidenav_content">
            <main class="p-4">
                <h2 class="text-primary mb-4">📊 Dashboard - Doanh Thu</h2>

                <!-- Bộ lọc thời gian -->
                <div class="mb-4">
                    <label for="timeRange" class="form-label fw-bold">Chọn khoảng thời gian:</label>
                    <select id="timeRange" class="form-select w-25">
                        <option value="7">7 ngày gần nhất</option>
                        <option value="30">30 ngày gần nhất</option>
                        <option value="quarter">Quý hiện tại</option>
                        <option value="year">Năm hiện tại</option>
                    </select>
                </div>

                <div class="row g-4">
                    <!-- Biểu đồ cột: Doanh thu theo ngày -->
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">📊 Doanh Thu Theo Ngày</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="barChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- Biểu đồ đường: Xu hướng doanh thu -->
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">📈 Xu Hướng Doanh Thu</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="lineChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- Biểu đồ tròn: Doanh thu theo danh mục -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">🛒 Doanh Thu Theo Danh Mục</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="pieChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- Biểu đồ thanh ngang: Top 5 sản phẩm bán chạy -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">🏆 Top 5 Sản Phẩm Bán Chạy</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="barHorizontalChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- Biểu đồ doughnut: Tỷ lệ thanh toán -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">💰 Tỷ Lệ Thanh Toán</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="doughnutChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <%@include file="/components/footer.jsp"%>
        </div>
    </div>

    <!-- Scripts -->
    <script src="js/scripts.js"></script>
    <script>
        // Dữ liệu mẫu (giả lập)
        const revenueByDay = {
            labels: ['01/03', '02/03', '03/03', '04/03', '05/03', '06/03', '07/03'],
            data: [5000, 7000, 6000, 8000, 9000, 7500, 8500]
        };

        const revenueTrend = {
            labels: ['01/03', '02/03', '03/03', '04/03', '05/03', '06/03', '07/03'],
            data: [5000, 6500, 6200, 7800, 8500, 7200, 8800]
        };

        const revenueByCategory = {
            labels: ['Jasmine Rice', 'Sticky Rice', 'Brown Rice'],
            data: [15000, 10000, 8000]
        };

        const topProducts = {
            labels: ['Jasmine Rice', 'Sticky Rice', 'Brown Rice', 'White Rice', 'Black Rice'],
            data: [500, 300, 200, 150, 100]
        };

        const paymentStatus = {
            labels: ['Đã thanh toán', 'Thanh toán thiếu', 'Chưa thanh toán'],
            data: [70, 20, 10]
        };

        // Biểu đồ cột
        new Chart(document.getElementById('barChart'), {
            type: 'bar',
            data: {
                labels: revenueByDay.labels,
                datasets: [{
                    label: 'Doanh thu ($)',
                    data: revenueByDay.data,
                    backgroundColor: '#007bff',
                    borderColor: '#007bff',
                    borderWidth: 1
                }]
            },
            options: { scales: { y: { beginAtZero: true } } }
        });

        // Biểu đồ đường
        new Chart(document.getElementById('lineChart'), {
            type: 'line',
            data: {
                labels: revenueTrend.labels,
                datasets: [{
                    label: 'Doanh thu ($)',
                    data: revenueTrend.data,
                    borderColor: '#28a745',
                    fill: false,
                    tension: 0.1
                }]
            },
            options: { scales: { y: { beginAtZero: true } } }
        });

        // Biểu đồ tròn
        new Chart(document.getElementById('pieChart'), {
            type: 'pie',
            data: {
                labels: revenueByCategory.labels,
                datasets: [{
                    data: revenueByCategory.data,
                    backgroundColor: ['#007bff', '#28a745', '#ffc107']
                }]
            }
        });

        // Biểu đồ thanh ngang
        new Chart(document.getElementById('barHorizontalChart'), {
            type: 'bar',
            data: {
                labels: topProducts.labels,
                datasets: [{
                    label: 'Số lượng bán',
                    data: topProducts.data,
                    backgroundColor: '#17a2b8',
                    borderColor: '#17a2b8',
                    borderWidth: 1
                }]
            },
            options: {
                indexAxis: 'y',
                scales: { x: { beginAtZero: true } }
            }
        });

        // Biểu đồ doughnut
        new Chart(document.getElementById('doughnutChart'), {
            type: 'doughnut',
            data: {
                labels: paymentStatus.labels,
                datasets: [{
                    data: paymentStatus.data,
                    backgroundColor: ['#28a745', '#ffc107', '#dc3545']
                }]
            }
        });

        // Xử lý bộ lọc thời gian (chỉ để minh họa)
        document.getElementById('timeRange').addEventListener('change', function() {
            console.log('Time range changed to:', this.value);
            // Gọi AJAX để lấy dữ liệu mới từ server ở đây
        });
    </script>
</body>
</html>