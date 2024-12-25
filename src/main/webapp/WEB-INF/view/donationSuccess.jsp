<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donation Successful - NGO Donations</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <s:url var="url_bg" value="/static/images/1.jpg" />
    <s:url var="url_logo" value="/static/images/logo1.jpg" />

    <style>
        :root {
            --primary-color: #1a4066;
            --accent-color: #3498db;
            --text-color: #2c3e50;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            min-height: 100vh;
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                        url('${url_bg}') center/cover no-repeat fixed;
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

        .success-container {
            max-width: 600px;
            margin: 120px auto 2rem;
            padding: 2.5rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .success-icon {
            color: #28a745;
            font-size: 4rem;
            margin-bottom: 1.5rem;
        }

        .success-title {
            color: var(--text-color);
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .success-message {
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }

        .btn-return, .btn-download {
            background-color: var(--accent-color);
            color: white;
            padding: 0.8rem 2rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .btn-return:hover, .btn-download:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            color: white;
        }

        .btn-download {
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-content">
            <div class="logo-container">
                <img src="${url_logo}" alt="Logo" style="height: 40px;">
                <span class="ms-2 text-white fs-4">NGO Connect</span>
            </div>
            <nav class="nav-links">
                <a href="campaign">Projects</a>
                <a href="logout">Logout</a>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="success-container">
            <i class="fas fa-check-circle success-icon"></i>
            <h1 class="success-title">Thank You for Your Donation!</h1>
            <p class="success-message">Your generous contribution will help make a difference in the lives of those we serve.</p>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success mb-4">
                    ${successMessage}
                </div>
            </c:if>
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/" class="btn-return">
                    <i class="fas fa-home me-2"></i>Return to Dashboard
                </a>
               <a href="${pageContext.request.contextPath}/downloadReceipt?donationId=${sessionScope.donationId}" class="btn-download">
                   <i class="fas fa-file-pdf me-2"></i>Download Receipt
               </a>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
