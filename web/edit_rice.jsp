<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Rice</title>
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>

    <%@include file="/components/header.jsp"%>

    <div id="layoutSidenav">
        

        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Edit Rice</h1>

                    <!-- Form to edit rice details -->
                    <form action="RiceController" method="post">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="riceId" value="${rice.riceId}">

                        <div class="mb-3">
                            <label for="riceName" class="form-label">Rice Name</label>
                            <input type="text" name="riceName" class="form-control" id="riceName" value="${rice.riceName}" required>
                        </div>

                        <div class="mb-3">
                            <label for="price" class="form-label">Price</label>
                            <input type="number" step="0.01" name="price" class="form-control" id="price" value="${rice.price}" required>
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea name="description" class="form-control" id="description" rows="4">${rice.description}</textarea>
                        </div>

                        <button type="submit" class="btn btn-primary">Save Changes</button>
                        <a href="RiceController" class="btn btn-secondary">Cancel</a>
                    </form>
                </div>
            </main>
        </div>
    </div>

    <%@include file="/components/footer.jsp"%>

</body>
</html>
