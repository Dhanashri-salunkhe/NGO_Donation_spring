<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donation History - NGO Donation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <s:url var="url_bg" value="/static/images/7.jpg" />
    <s:url var="url_logo" value="/static/images/logo1.jpg" />

    <style>
        :root {
            --primary-color: #1a4066;
            --accent-color: #3498db;
            --text-color: #2c3e50;
            --card-bg-color: #f0f8ff;
            --card-hover-color: #e1f0fe;
            --card-shadow: rgba(52, 152, 219, 0.2);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            min-height: 100vh;
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                url('${url_bg}');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: var(--text-color);
        }

        .header {
            background-color: var(--primary-color);
            padding: 1rem 0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .header-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 2rem;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: var(--accent-color);
        }

        .donation-history-section {
            position: relative;
            z-index: 1;
            padding: 6rem 2rem 2rem;
        }

        .donation-history-container {
            background-color: var(--card-bg-color);
            border-radius: 15px;
            box-shadow: 0 5px 15px var(--card-shadow);
            padding: 2rem;
            margin-top: 2rem;
            transition: all 0.3s ease;
        }

        .donation-history-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px var(--card-shadow);
        }

        .table-custom thead {
            background-color: var(--primary-color);
            color: white;
        }

        .table-custom tbody tr:hover {
            background-color: var(--card-hover-color);
        }

        .btn-primary, .btn-download {
            background-color: var(--accent-color);
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }

        .btn-primary:hover, .btn-download:hover {
            background-color: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
        }

        .btn-download {
            background-color: transparent;
            color: var(--accent-color);
            padding: 0.25rem 0.5rem;
            margin-left: 0.5rem;
        }

        .status-badge {
            font-weight: bold;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
        }

        .status-completed {
            background-color: #28a745;
            color: white;
        }

        .status-pending {
            background-color: #ffc107;
            color: #212529;
        }

        .welcome-message h4 {
            color: white;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-content">
            <div class="logo-container">
                <img src="${url_logo}" alt="Logo" style="height: 40px;">
                <span class="ms-2 text-white fs-4">NGO Donation</span>
            </div>
            <nav class="nav-links">
                <a href="index">Home</a>
                <a href="about">About</a>
                <a href="impact">Our Impact</a>
                <c:if test="${not empty sessionScope.user}">
                    <a href="donation_history">Donation History</a>
                </c:if>
                <a href="logout">Logout</a>
            </nav>
        </div>
    </header>

    <section class="donation-history-section">
        <div class="container donation-history-container">
            <div class="row">
                <div class="col-12">
                    <h2 class="mb-4 text-center text-primary">
                        <i class="fas fa-history me-2"></i>Donation History
                    </h2>

                    <c:if test="${not empty message}">
                        <div class="alert alert-info">${message}</div>
                    </c:if>

                    <c:choose>
                        <c:when test="${empty donationHistory}">
                            <div class="alert alert-warning text-center" role="alert">
                                <i class="fas fa-info-circle me-2"></i>
                                You have not made any donations yet.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover table-custom">
                                    <thead>
                                        <tr>
                                            <th>Donation ID</th>
                                            <th>Campaign</th>
                                            <th>Amount</th>
                                            <th>Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="donation" items="${donationHistory}">
                                            <tr>
                                                <td>#${donation.donationId}</td>
                                                <td>${donation.title}</td>
                                                <td>
                                                    <fmt:formatNumber value="${donation.donationAmount}"
                                                                    type="currency"
                                                                    currencySymbol="₹"/>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${donation.donationDate}"
                                                                   pattern="dd MMM yyyy"/>
                                                </td>
                                                <td>
                                                    <a href="downloadReceipt?donationId=${donation.donationId}"
                                                       class="btn btn-download"
                                                       title="Download Receipt">
                                                        <i class="fas fa-download"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="d-flex justify-content-between align-items-center mt-3 text-white">
                                <div>
                                    Total Donations: ${donationHistory.size()}
                                </div>
                                <div>
                                    Total Amount:
                                    <fmt:formatNumber value="${totalDonationAmount}"
                                                      type="currency"
                                                      currencySymbol="₹"/>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="text-center mt-4">
                        <a href="campaign" class="btn btn-primary">
                            <i class="fas fa-arrow-left me-2"></i>Back to Campaigns
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>