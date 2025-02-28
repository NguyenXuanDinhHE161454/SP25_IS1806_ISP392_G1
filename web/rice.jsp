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
            <%@include file="/components/sidebar.jsp"%>

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

                        <!-- Dropdown for selecting number of records per page -->
                        <form method="get" action="RiceController" class="mb-3">
                            <label for="pageSize">Records per page:</label>
                            <select name="pageSize" id="pageSize" class="form-select w-auto d-inline" onchange="this.form.submit()">
                                <option value="2" ${pageSize == 2 ? 'selected' : ''}>2</option>
                                <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
                                <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                                <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                            </select>
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
                        <c:if test="${totalPages > 1}">
                            <nav>
                                <ul class="pagination">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="RiceController?page=1&pageSize=${pageSize}&riceName=${riceName}&description=${description}&price=${price}">First</a>
                                    </li>

                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="RiceController?page=${currentPage - 1}&pageSize=${pageSize}&riceName=${riceName}&description=${description}&price=${price}">Previous</a>
                                    </li>

                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="RiceController?page=${i}&pageSize=${pageSize}&riceName=${riceName}&description=${description}&price=${price}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="RiceController?page=${currentPage + 1}&pageSize=${pageSize}&riceName=${riceName}&description=${description}&price=${price}">Next</a>
                                    </li>

                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="RiceController?page=${totalPages}&pageSize=${pageSize}&riceName=${riceName}&description=${description}&price=${price}">Last</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>

                    </div>
                </main>
            </div>
        </div>

        <%@include file="/components/footer.jsp"%>

    </body>
</html>
