<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>Edit Staff</title>
    </head>
    <body>
        <%@include file="/components/header.jsp"%>

        <div class="container-fluid px-4">
            <a href="owner" class="btn btn-secondary mb-3">Back to List</a>
            <h1 class="mt-4">Edit Staff</h1>
            <form method="post" action="editStaff">
                <input type="hidden" name="staffId" value="${staff.staffId}" />
                <div class="mb-3">
                    <label for="fullName" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" value="${staff.fullName}" required />
                </div>

                <div class="mb-3">
                    <label for="phoneNumber" class="form-label">Phone Number</label>
                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${staff.phoneNumber}" required />
                </div>

                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" class="form-control" id="address" name="address" value="${staff.address}" required />
                </div>

                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" value="${staff.username}" required />
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" value="${staff.passwordHash}" required />
                </div>

                <div class="mb-3">
                    <label for="ownerId" class="form-label">Owner ID</label>
                    <input type="number" class="form-control" id="ownerId" name="ownerId" value="${staff.ownerId}" required readonly />
                </div>

                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>

        <%@include file="/components/footer.jsp"%>
    </body>
</html>
