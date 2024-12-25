<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Impact - NGO Donation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <s:url var="url_bg" value="/static/images/1.jpg"/>
    <s:url var="url_logo" value="/static/images/logo1.jpg"/>

    <style>
        :root {
            --primary-color: #1a4066;
            --accent-color: #3498db;
            --text-color: #2c3e50;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            padding-top: 76px;
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

        .impact-banner {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                        url('${url_bg}') center/cover no-repeat;
            padding: 4rem 0;
            color: white;
            text-align: center;
        }

        .impact-stats {
            padding: 4rem 0;
            background-color: #f8f9fa;
        }

        .stat-card {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s ease;
            margin-bottom: 2rem;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            font-size: 2.5rem;
            color: var(--accent-color);
            margin-bottom: 1rem;
        }

        .impact-stories {
            padding: 4rem 0;
        }

        .story-card {
            height: 100%;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            transition: transform 0.3s ease;
        }

        .story-card:hover {
            transform: translateY(-5px);
        }

        .story-img {
        width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .story-content {
            flex-grow: 1;
                display: flex;
                flex-direction: column;
                padding: 1.5rem;
        }

        .timeline-section {
            padding: 4rem 0;
            background-color: #f8f9fa;
        }

        .timeline-item {
            position: relative;
            padding: 2rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .footer {
            background-color: var(--primary-color);
            color: white;
            padding: 2rem 0;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
        }
         .fixed-image {
                    width: 100%;
                    height: 250px;
                    object-fit: cover;
                    object-position: center;
                }

                .project-card {
                    height: 100%;
                    display: flex;
                    flex-direction: column;
                }

                .project-content {
                    flex-grow: 1;
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                    padding: 1rem;
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
                <a href="<s:url value="/about"/>">About</a>
                <a href="impact">Our Impact</a>
                <a href="<s:url value="/campaign"/>">Projects</a>
                <c:if test="${not empty sessionScope.user}">
                                 <a href="logout">Logout</a>
                                 </c:if> <c:if test="${empty sessionScope.user}">
                                 <a href="<s:url value='/login'/>">Login</a>
                                 </c:if>
            </nav>
        </div>
    </header>

    <section class="impact-banner">
        <div class="container">
            <h1 class="display-4 mb-4">Our Impact Journey</h1>
            <p class="lead">Transforming lives and building sustainable communities</p>
        </div>
    </section>

    <section class="impact-stats">
        <div class="container">
            <h2 class="text-center mb-5">Impact by Numbers</h2>
            <div class="row">
                <div class="col-md-3">
                    <div class="stat-card">
                        <i class="fas fa-hands-helping stat-icon"></i>
                        <h3>100+</h3>
                        <p>Lives Impacted</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <i class="fas fa-globe-americas stat-icon"></i>
                        <h3>50+</h3>
                        <p>Communities Served</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <i class="fas fa-project-diagram stat-icon"></i>
                        <h3>10+</h3>
                        <p>Projects Completed</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <i class="fas fa-users stat-icon"></i>
                        <h3>100+</h3>
                        <p>Active Volunteers</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

  <section id="projects" class="projects-section">
         <div class="container">
             <h2 class="text-center mb-5">Our Current Projects</h2>
             <div class="row">
                 <c:forEach var="campaign" items="${campaigns}">
                     <div class="col-md-4 mb-4">
                         <div class="project-card">
                             <c:choose>
                                 <c:when test="${not empty campaign.imageBase64}">
                                     <img src="data:image/jpeg;base64,<c:out value='${campaign.imageBase64}'/>"
                                          alt="${campaign.title}"
                                          class="fixed-image">
                                 </c:when>
                                 <c:otherwise>
                                     <img src="${url_logo}"
                                          alt="${campaign.title}"
                                          class="fixed-image">
                                 </c:otherwise>
                             </c:choose>
                             <div class="project-content">
                                 <div>
                                     <h3>${campaign.title}</h3>
                                     <p>${campaign.description}</p>
                                 </div>

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
                <div class="col-md-4">
                    <h4>About Us</h4>
                    <p>Our NGO is dedicated to creating positive change through community engagement and sustainable development projects.</p>
                </div>
                <div class="col-md-4">
                    <h4>Contact Us</h4>
                    <p>
                        <i class="fas fa-envelope me-2"></i> info@NGODonation.org<br>
                        <i class="fas fa-phone me-2"></i> +123456789
                    </p>
                </div>
                <div class="col-md-4">
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