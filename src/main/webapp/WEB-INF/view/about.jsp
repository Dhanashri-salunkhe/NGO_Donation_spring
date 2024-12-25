<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About - NGO Donation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <s:url var="url_bg" value="/static/images/1.jpg"/>
    <s:url var="url_logo" value="/static/images/logo1.jpg"/>

    <style>
        :root {
            --primary-color: #1a4066;
            --accent-color: #3498db;
            --text-color: #2c3e50;
            --bg-subtle: rgba(255, 255, 255, 0.97);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            min-height: 100vh;
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                        url('${url_bg}');
            background-size: cover;
            background-position: center;
        }

        .header {
            background-color: var(--primary-color);
            padding: 1rem 0;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            height:14%;
        }

        .header-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 2rem;
            font-size:17px;
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

        .about-container {
            max-width: 900px;
            margin: 120px auto 2rem;
            padding: 3rem;
            background: var(--bg-subtle);
            border-radius: 20px;
            box-shadow: 0 12px 45px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(52, 152, 219, 0.1);
        }
        .footer {
                    background-color: var(--primary-color);
                    color: white;
                    padding: 2rem 0;
                }

        .about-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                135deg,
                transparent 0%,
                rgba(52, 152, 219, 0.05) 50%,
                transparent 100%
            );
            transform: rotate(-45deg);
            z-index: -1;
        }

        .about-title {
            color: var(--primary-color);
            font-size: 2.2rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 2.5rem;
            position: relative;
            padding-bottom: 0.5rem;
        }

        .about-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background-color: var(--accent-color);
            border-radius: 2px;
        }

        .mission-section {
            background-color: rgba(52, 152, 219, 0.05);
            border-left: 4px solid var(--accent-color);
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            transition: all 0.3s ease;
        }

        .mission-section:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.1);
        }

        .mission-section h4 {
            color: var(--primary-color);
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .about-content {
            color: var(--text-color);
            text-align: justify;
            line-height: 1.8;
            letter-spacing: 0.3px;
        }

        .about-content p {
            margin-bottom: 1.5rem;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .about-container {
                margin: 100px 1rem 2rem;
                padding: 2rem;
                border-radius: 15px;
            }

            .about-title {
                font-size: 1.8rem;
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
                <a href="<s:url value="/"/>">Home</a>
                <a href="about">About</a>
                               <a href="<s:url value="/impact"/>">Our Impact</a>
                               <a href="<s:url value="/campaign"/>">Projects</a>
                               <c:if test="${not empty sessionScope.user}">
                                <a href="logout">Logout</a>
                                 </c:if> <c:if test="${empty sessionScope.user}">
                                 <a href="<s:url value='/login'/>">Login</a>
                                 </c:if>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="about-container">
            <h2 class="about-title">About Our NGO</h2>

            <div class="mission-section">
                <h4 class="mb-3">Our Mission</h4>
                <p>We are dedicated to creating sustainable change in communities through targeted interventions, empowerment programs, and strategic partnerships that address critical social challenges.</p>
            </div>

            <div class="about-content">
                <p>Our organization believes in the power of collective action and grassroots development. We work tirelessly to support vulnerable populations, promote education, healthcare, and economic opportunities, and drive meaningful social transformation.</p>

                <p>With a network of passionate volunteers and strategic collaborations, we aim to create lasting impact in areas of greatest need. Our approach combines direct aid, community engagement, and sustainable development strategies.</p>
            </div>
        </div>
    </div>


    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-4 text-center">
                    <h4>About Us</h4>
                    <p>Our NGO is dedicated to creating positive change through community engagement and sustainable development projects.</p>
                </div>
                <div class="col-md-4 text-center">
                    <h4>Contact Us</h4>
                    <p>
                        <i class="fas fa-envelope me-2"></i> info@NGODonation.org<br>
                        <i class="fas fa-phone me-2"></i> +123456789
                    </p>
                </div>
                <div class="col-md-4 text-center">
                    <h4>Follow Us</h4>
                    <div class="social-links">
                        <a href="#" class="text-white me-3"><i class="fab fa-facebook"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-linkedin"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>