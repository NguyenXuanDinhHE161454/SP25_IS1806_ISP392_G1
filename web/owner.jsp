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
                        <h1 class="mt-4">Owner Dashboard</h1>
                        <a href="createStaff.jsp" class="btn btn-primary btn-info mb-4">Create Staff</a>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Staff Management
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>Staff ID</th>
                                            <th>Full Name</th>
                                            <th>Phone Number</th>
                                            <th>Username</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>Staff ID</th>
                                            <th>Full Name</th>
                                            <th>Phone Number</th>
                                            <th>Username</th>
                                            <th>Actions</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <c:forEach var="staff" items="${staffList}">
                                            <tr>
                                                <td>${staff.staffId}</td>
                                                <td>${staff.fullName}</td>
                                                <td>${staff.phoneNumber}</td>
                                                <td>${staff.username}</td>
                                                <td>
                                                    <a href="editStaff?staffId=${staff.staffId}" class="btn btn-primary btn-sm">Edit</a>
                                                    <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal" 
                                                            onclick="setDeleteUser(${staff.staffId}, '${staff.fullName}')">
                                                        Delete
                                                    </button>
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

                <!-- Delete Modal -->
                <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form method="post" action="owner?action=delete">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <p>Are you sure you want to delete the user <strong id="deleteUserName"></strong>?</p>
                                    <input type="hidden" id="deleteUserId" name="userId">
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-danger">Delete</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <%@include file="/components/footer.jsp"%>
            </div>
        </div>
        <script>
            function setDeleteUser(userId, fullName) {
                document.getElementById('deleteUserId').value = userId;
                document.getElementById('deleteUserName').textContent = fullName;
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    </body>
</html>
