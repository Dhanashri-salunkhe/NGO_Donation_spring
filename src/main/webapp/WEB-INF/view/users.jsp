<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NGO Admin Dashboard - Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <s:url var="url_bg" value="/static/images/1.jpg"/>
    <s:url var="url_logo" value="/static/images/logo1.jpg"/>

    <style>
        :root {
            --primary-color: #1a4066;
            --accent-color: #3498db;
            --text-color: #2c3e50;
            --sidebar-width: 250px;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            min-height: 100vh;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 60px;
            background-color: var(--primary-color);
            z-index: 1000;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .header-content {
            padding: 0 20px;
            height: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .sidebar {
            position: fixed;
            top: 60px;
            left: 0;
            width: var(--sidebar-width);
            height: calc(100vh - 60px);
            background-color: white;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            padding-top: 20px;
            overflow-y: auto;
            z-index: 999;
        }

        .sidebar .nav-link {
            padding: 12px 20px;
            color: var(--text-color);
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .sidebar .nav-link:hover {
            background-color: #f8f9fa;
            color: var(--accent-color);
        }

        .sidebar .nav-link.active {
            background-color: #e9ecef;
            color: var(--accent-color);
            border-left: 4px solid var(--accent-color);
        }

        .main-content {
            margin-left: var(--sidebar-width);
            margin-top: 60px;
            padding: 20px;
            min-height: calc(100vh - 60px);
            background-color: #f8f9fa;
        }

        .table-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 20px;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 60px;
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }

            .sidebar:hover {
                width: var(--sidebar-width);
                transform: translateX(0);
            }

            .sidebar .nav-link span {
                display: none;
            }

            .sidebar:hover .nav-link span {
                display: inline;
            }

            .main-content {
                margin-left: 0;
            }

            .search-box {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-content">
            <div class="d-flex align-items-center">
                <img src="${pageContext.request.contextPath}/static/images/logo1.jpg" alt="Logo" style="height: 40px;">
                <span class="ms-2 text-white fs-4">NGO Admin Dashboard</span>
            </div>
            <div class="d-flex align-items-center">
                <span class="text-white me-3">Welcome, Admin</span>
                <a href="logout" class="btn btn-light btn-sm">
                    <i class="fas fa-sign-out-alt me-1"></i> Logout
                </a>
            </div>
        </div>
    </header>

    <nav class="sidebar">
        <div class="nav flex-column">
            <a href="admin_dashboard" class="nav-link">
                <i class="fas fa-home"></i>
                <span>Dashboard</span>
            </a>
            <a href="admin_dashboard" class="nav-link">
                <i class="fas fa-hand-holding-heart"></i>
                <span>Donations</span>
            </a>
            <a href="users" class="nav-link active">
                <i class="fas fa-users"></i>
                <span>Users</span>
            </a>
             <a href="Campaign_Details" class="nav-link">
                                        <i class="fas fa-users"></i>
                                        <span>Campaigns</span>
                                    </a>
        </div>
    </nav>

    <main class="main-content">
        <div class="container-fluid">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>User Management</h2>

            </div>

            <c:if test="${param.msg != null}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${param.msg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="table-card">


                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>User ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Address</th>

                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty userList}">
                                    <c:forEach var="user" items="${userList}">
                                        <tr>
                                            <td>${user.userId}</td>
                                            <td>${user.name}</td>
                                            <td>${user.email}</td>
                                            <td>${user.phone}</td>
                                            <td>${user.address}</td>

                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="text-center">
                                            <div class="alert alert-info mb-0">
                                                <i class="fas fa-info-circle me-2"></i>No users found
                                            </div>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>