<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>

<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NGO Admin Dashboard - Campaigns</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
        }
        .stat-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
            height: 100%;
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
        }
    </style>
</head>
<body>
    <!-- Header -->
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

    <!-- Sidebar -->
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
            <a href="users" class="nav-link">
                <i class="fas fa-users"></i>
                <span>Users</span>
            </a>
            <a href="Campaign_Details" class="nav-link active">
                <i class="fas fa-bullhorn"></i>
                <span>Campaigns</span>
            </a>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container-fluid">
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Campaign Management</h2>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCampaignModal">
                    <i class="fas fa-plus me-2"></i>Add Campaign
                </button>
            </div>

            <!-- Success/Error Message -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Campaign Statistics -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="stat-card">
                        <h6 class="text-muted">Total Campaigns</h6>
                        <h3 class="mb-0">${totalCampaigns}</h3>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <h6 class="text-muted">Active Campaigns</h6>
                        <h3 class="mb-0">${activeCampaigns}</h3>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <h6 class="text-muted">Total Raised</h6>
                        <h3 class="mb-0">₹${totalRaised}</h3>
                    </div>
                </div>
            </div>

            <!-- Campaigns Table -->
            <div class="table-card">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Campaign ID</th>
                                <th>Title</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Target Amount</th>
                                <th>Raised Amount</th>

                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty campaignList}">
                                    <c:forEach var="campaign" items="${campaignList}">
                                        <tr>
                                            <td>${campaign.campaignId}</td>
                                            <td>${campaign.title}</td>
                                            <td><fmt:formatDate value="${campaign.startDate}" pattern="dd-MM-yyyy"/></td>
                                            <td><fmt:formatDate value="${campaign.endDate}" pattern="dd-MM-yyyy"/></td>
                                            <td>₹${campaign.targetAmount}</td>
                                            <td>₹${campaign.fundRaised}</td>


                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="text-center">
                                            <div class="alert alert-info mb-0">
                                                <i class="fas fa-info-circle me-2"></i>No campaigns found
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

        <div class="modal fade" id="addCampaignModal" tabindex="-1" aria-labelledby="addCampaignModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addCampaignModalLabel">Add New Campaign</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <f:form action="${pageContext.request.contextPath}/add" method="post" modelAttribute="campaignCommand" enctype="multipart/form-data">
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="title" class="form-label">Campaign Title</label>
                                    <f:input path="title" class="form-control" required="required" />
                                </div>
                                <div class="mb-3">
                                    <label for="description" class="form-label">Description</label>
                                    <f:textarea path="description" class="form-control" rows="3" required="required"></f:textarea>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="startDate" class="form-label">Start Date</label>
                                        <f:input type="date" path="startDate" class="form-control" required="required" />
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="endDate" class="form-label">End Date</label>
                                        <f:input type="date" path="endDate" class="form-control" required="required" />
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="targetAmount" class="form-label">Target Amount</label>
                                    <f:input type="number" path="targetAmount" class="form-control" required="required" min="0" step="0.01" />
                                </div>
                            </div>
                            <div class="mb-3"> <label for="image" class="form-label">Upload Image</label> <f:input path="image" type="file" class="form-control" /> </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Save Campaign</button>
                            </div>
                        </f:form>
                    </div>
                </div>
            </div>
    </main>



<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>