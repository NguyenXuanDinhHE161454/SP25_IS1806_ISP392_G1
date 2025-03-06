<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Rice Management</title>
        <link href="css/styles.css" rel="stylesheet">
    </head>
    <body>

        <%@include file="/components/header.jsp"%>

        <div id="layoutSidenav">
            

            <div id="layoutSidenav_content">
                <main>

                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Rice Management</h1>

                        <!-- Search Form -->
                        <form method="get" action="RiceController" class="row g-3 mb-4">
                            <div class="col-md-3">
                                <input type="text" name="riceName" value="${riceName}" class="form-control" placeholder="Search by Rice Name">
                            </div>
                            <div class="col-md-3">
                                <input type="text" name="description" value="${description}" class="form-control" placeholder="Search by Description">
                            </div>
                            <div class="col-md-3">
                                <input type="number" name="price" value="${price}" class="form-control" placeholder="Search by Price">
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">Search</button>
                            </div>
                        </form>
                        <!-- Add Rice Button -->
                        <div class="mb-3">
                            <a href="add_rice.jsp" class="btn btn-success">Add Rice</a>
                        </div>

                        <!-- Dropdown for selecting number of records per page -->
                        <form method="get" action="RiceController" class="mb-3">

                            <input type="hidden" name="riceName" value="${riceName}">
                            <input type="hidden" name="description" value="${description}">
                            <input type="hidden" name="price" value="${price}">
                        </form>

                        <!-- Rice List Table -->
                        <div class="card mb-4">
                            <div class="card-header">Rice List</div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Rice ID</th>
                                            <th>Rice Name</th>
                                            <th>Price</th>
                                            <th>Description</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="rice" items="${riceList}">
                                            <tr>
                                                <td>${rice.riceId}</td>
                                                <td>${rice.riceName}</td>
                                                <td>${rice.price}</td>
                                                <td>${rice.description}</td>
                                                <td>
                                                    <a href="RiceController?action=edit&riceId=${rice.riceId}" class="btn btn-warning btn-sm">Edit</a>
                                                    <a href="RiceController?action=delete&riceId=${rice.riceId}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this rice?')">Delete</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- Pagination -->
                        <div class="d-flex justify-content-center">
                            <nav>
                                <ul class="pagination">
                                    <!-- Previous Button -->
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="RiceController?page=${currentPage - 1}&riceName=${riceName}&description=${description}&price=${price}">Previous</a>
                                        </li>
                                    </c:if>

                                    <!-- Page Numbers -->
                                    <c:forEach var="page" begin="1" end="${totalPages}">
                                        <li class="page-item ${page == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="RiceController?page=${page}&riceName=${riceName}&description=${description}&price=${price}">${page}</a>
                                        </li>
                                    </c:forEach>

                                    <!-- Next Button -->
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="RiceController?page=${currentPage + 1}&riceName=${riceName}&description=${description}&price=${price}">Next</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>


                    </div>
                </main>
            </div>
        </div>

        <%@include file="/components/footer.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    </body>
</html>
