<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="layoutSidenav_nav">
    <nav class="sb-sidenav sb-sidenav-dark">
        <div class="sb-sidenav-menu">
            <div class="nav">
                <div class="sb-sidenav-menu-heading">Dashboard</div>
                <a class="nav-link" href="home">
                    <div class=""><i class=""></i></div>
                    Home Dashboard
                </a>
                <div class="sb-sidenav-menu-heading">Personnel</div>
                <a class="nav-link" href="owner">
                    <div class=""><i class=""></i></div>
                    Staff Management
                </a>
                <a class="nav-link" href="index.html">
                    <div class=""><i class=""></i></div>
                    Porter Management
                </a>
                <div class="sb-sidenav-menu-heading">Warehouse</div>
                <a class="nav-link" href="warehouserice">
                    <div class=""><i class=""></i></div>
                    Warehouse Rice
                </a>
                <a class="nav-link" href="index.html">
                    <div class=""><i class=""></i></div>
                    Rice Inventory
                </a>
                <div class="sb-sidenav-menu-heading">Finance</div>
                <a class="nav-link" href="DebtController">
                    <div class=""><i class=""></i></div>
                    Debt Management
                </a>
                <a class="nav-link" href="PaymentController">
                    <div class=""><i class=""></i></div>
                    Transaction History
                </a>
                <div class="sb-sidenav-menu-heading">Tools</div>
                <a class="nav-link" href="ExportRiceController">
                    <div class=""><i class=""></i></div>
                    Export Rice
                </a>
                <a class="nav-link" href="EditUserServlet">
                    <div class=""><i class=""></i></div>
                    Edit User Profile
                </a>
            </div>
        </div>
        <div class="sb-sidenav-footer">
            <div class="small text-muted">Logged in as:</div>
            <span class="text-white">Welcome, ${sessionScope.user.fullName}</span>
        </div>
    </nav>
</div>

<style>
    .sb-sidenav {
        background-color: #2c3e50;
        width: 250px;
        height: 100vh;
        padding-top: 1rem;
        font-family: 'Roboto', sans-serif;
    }
    .sb-sidenav-menu-heading {
        color: #a8b2b9;
        font-size: 0.9rem;
        padding: 0.5rem 1rem;
        text-transform: uppercase;
        font-weight: 500;
    }
    .nav-link {
        color: #ecf0f1;
        padding: 0.75rem 1rem;
        display: flex;
        align-items: center;
        font-size: 0.9rem;
    }
    .nav-link:hover {
        background-color: rgba(255, 255, 255, 0.1);
        color: #3498db;
    }
    .sb-nav-link-icon {
        margin-right: 0.5rem;
    }
    .sb-sidenav-footer {
        background: #2c3e50;
        padding: 1rem;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
    }
    .sb-sidenav-footer .text-muted {
        color: #a8b2b9 !important;
        font-size: 0.8rem;
    }
    .sb-sidenav-footer span {
        font-weight: 500;
        color: #ecf0f1;
        font-size: 0.9rem;
    }
</style>
