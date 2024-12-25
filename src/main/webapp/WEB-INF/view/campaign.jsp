<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NGO Donation - Making a Difference Together</title>
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
        }

        .header {
            background-color: var(--primary-color);
            padding: 1rem 0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
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
            font-size:17px
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

        .btn-light {
            background-color: white;
            color: var(--primary-color);
            padding: 8px 20px;
            border-radius: 5px;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-light:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(255, 255, 255, 0.2);
        }

        .project-card {
            display: flex;
            flex-direction: column;
            border-radius: 15px;
            overflow: hidden;
            background-color: var(--card-bg-color);
            box-shadow: 0 5px 15px var(--card-shadow);
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
            border: 1px solid rgba(52, 152, 219, 0.1);
            height: 100%;
            padding-bottom: 1rem;
        }

        .projects-section {
            position: relative;
            z-index: 1;
            padding: 6rem 2rem 2rem;
        }

        .project-card:hover {
            transform: translateY(-5px);
            background-color: var(--card-hover-color);
            box-shadow: 0 8px 20px var(--card-shadow);
        }

        .project-img {
            height: 250px;
            object-fit: cover;
        }

        .project-content {
            padding: 0.4rem;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .project-content h3 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 1.2rem;
        }

        .project-content p {
            color: var(--text-color);
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            flex-grow: 1;
        }

        .btn-primary {
            background-color: var(--accent-color);
            margin-top: 0.1rem;
            border: none;
            padding: 0.4rem 0.8rem;
            border-radius: 8px;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            align-self: flex-start;
        }

        .btn-primary:hover {
            background-color: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
        }

        .col-md-4 {
            margin-bottom: 1.5rem;
        }

        .footer {
            background-color: var(--primary-color);
            color: white;
            padding: 2rem 0;
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
                <a href="campaign">Projects</a>
                <c:if test="${not empty sessionScope.user}">

                    <a href="<s:url value='/logout'/>">Logout</a>
                </c:if>
                <c:if test="${empty sessionScope.user}">
                    <a href="<s:url value='/login'/>">Login</a>
                </c:if>
            </nav>
        </div>
    </header>

    <section id="projects" class="projects-section">
        <div class="container">
            <c:if test="${not empty sessionScope.user}">
                <div class="text-end mb-4">
                    <a href="<c:url value='/donation_history'/>" class="btn btn-light">
                        Donation History
                    </a>
                </div>
            </c:if>
            <h2 class="text-center mb-4 text-white">Our Current Projects</h2>
            <div class="row">
                <c:forEach var="campaign" items="${campaigns}">
                    <div class="col-md-4">
                        <div class="project-card">
                            <c:choose>
                                <c:when test="${not empty campaign.image}">
                                    <img src="data:image/jpeg;base64,<c:out value='${campaign.imageBase64}'/>" alt="${campaign.title}" class="project-img w-100" />
                                </c:when>
                                <c:otherwise>
                                    <img src="${url_logo}" alt="${campaign.title}" class="project-img w-100" />
                                </c:otherwise>
                            </c:choose>
                            <div class="project-content">
                                <h3>${campaign.title}</h3>
                                <p>${campaign.description}</p>
                                <c:choose>
                                    <c:when test="${sessionScope.userId != null}">
                                        <a href="<c:url value='/campaign_view/${campaign.campaignId}'/>" class="btn btn-primary mt-auto">Support This Campaign</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="<c:url value='/login'/>" class="btn btn-primary mt-auto">Login to Support</a>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${not empty message}">
                                    <div class="alert alert-info">${message}</div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

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