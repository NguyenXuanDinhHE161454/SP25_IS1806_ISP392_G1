<%-- 
    Document   : admin
    Created on : Feb 23, 2025, 9:18:01 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Dashboard - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body>

        <%@include file="/components/header.jsp"%>

        <div id="layoutSidenav">

            


            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Warehouse Rice Dashboard</h1>
                        <!--<a href="" class="btn btn-primary btn-info mb-4">Create Owner</a>-->
                        <div class="row">
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-primary text-white mb-4">
                                    <div class="card-body">Rice Export</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="ExportRiceController">Go To</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-success text-white mb-4">
                                    <div class="card-body">Import Rice</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="ImportRiceController">Go To</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Warehouse Rice Management
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Section Name</th>
                                            <th>Rice Type</th>
                                            <th>Load Capacity</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>ID</th>
                                            <th>Section Name</th>
                                            <th>Rice Type</th>
                                            <th>Load Capacity</th>
                                            <th>Actions</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <!-- Loop through the warehouseRiceList -->
                                        <c:forEach var="warehouseRice" items="${warehouseRiceList}">
                                            <tr>
                                                <td>${warehouseRice.sectionId}</td>
                                                <td>${warehouseRice.sectionName}</td>
                                                <td>${warehouseRice.riceName}</td>
                                                <td>${warehouseRice.loadCapacity} / 500 kg</td>
                                                <td>
                                                    <a href="detailWarehouseRice?sectionId=${warehouseRice.sectionId}" class="btn btn-primary btn-sm">Detail</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                            <script>
                                                                document.addEventListener("DOMContentLoaded", function () {
                                                                    new simpleDatatables.DataTable("#datatablesSimple", {
                                                                        perPage: 5, // Đặt số dòng mặc định là 5
                                                                        perPageSelect: false, // Ẩn menu chọn số entries
                                                                        labels: { info: "" }
                                                                    });
                                                                });
                                    </script>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                    </div>
                </main>

                <%@include file="/components/footer.jsp"%>
            </div>
        </div>

    </body>
</html>
