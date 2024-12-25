<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campaign Details - NGO Donation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <s:url var="url_bg" value="/static/images/7.jpg"/>
    <s:url var="url_logo" value="/static/images/logo1.jpg"/>

    <style>
        :root {
            --primary-color: #2c3e50;
            --accent-color: #3498db;
            --success-color: #2ecc71;
            --text-color: #34495e;
            --card-bg-color: rgba(255, 255, 255, 0.95);
            --card-hover-color: #ffffff;
            --card-shadow: rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            min-height: 100vh;
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                        url('${url_bg}');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: var(--text-color);
        }

        .header {
            background-color: rgba(44, 62, 80, 0.95);
            padding: 1rem 0;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            backdrop-filter: blur(10px);
            height:14%;
        }

        .header-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 2rem;
            font-size:17px;
        }

        .logo-container {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .logo-container img {
            border-radius: 8px;
            transition: transform 0.3s ease;
        }

        .logo-container:hover img {
            transform: scale(1.05);
        }

        .nav-links {
            display: flex;
            gap: 2rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .nav-links a:hover {
            background-color: var(--accent-color);
            transform: translateY(-2px);
        }

        .campaign-details {
            background-color: var(--card-bg-color);
            border-radius: 20px;
            padding: 3rem;
            margin-top: 8rem;
            box-shadow: 0 10px 30px var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .campaign-details:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px var(--card-shadow);
        }

        .campaign-header {
            color: var(--primary-color);
            margin-bottom: 2rem;
            text-align: center;
            font-weight: 700;
            position: relative;
            padding-bottom: 1rem;
        }

        .campaign-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background: linear-gradient(to right, var(--accent-color), var(--success-color));
            border-radius: 2px;
        }

        .campaign-info {
            color: var(--text-color);
            font-size: 1.1rem;
        }

        .campaign-info p {
            margin-bottom: 1.5rem;
            padding: 1rem;
            background-color: rgba(52, 152, 219, 0.1);
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .campaign-info p:hover {
            background-color: rgba(52, 152, 219, 0.15);
            transform: translateX(5px);
        }

        .campaign-info strong {
            color: var(--primary-color);
            margin-right: 0.5rem;
        }

        .progress {
            height: 25px;
            margin: 2rem 0;
            border-radius: 12px;
            background-color: rgba(52, 152, 219, 0.1);
        }

        .progress-bar {
            background: linear-gradient(to right, var(--accent-color), var(--success-color));
            border-radius: 12px;
            transition: width 1s ease-in-out;
        }

        .btn-donate {
                    background-color: var(--accent-color);
                    color: white;
                    padding: 1rem 2.5rem;
                    font-size: 1.2rem;
                    border-radius: 50px;
                    text-transform: uppercase;
                    font-weight: 600;
                    transition: all 0.3s ease;
                }

        .btn-donate:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
            background: linear-gradient(to right, var(--success-color), var(--accent-color));
        }

        .progress-container {
            margin: 2rem 0;
        }

        .progress-stats {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
        }

        .progress-stat {
            text-align: center;
        }

        .progress-stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        .progress-stat-label {
            font-size: 0.9rem;
            color: var(--text-color);
            opacity: 0.8;
        }

        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 1rem;
                padding: 1rem;
            }

            .nav-links {
                gap: 1rem;
                flex-wrap: wrap;
                justify-content: center;
            }

            .campaign-details {
                margin-top: 12rem;
                padding: 2rem;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-content">
            <div class="logo-container">
                <img src="${url_logo}" alt="Logo" style="height: 40px;">
                <span class="text-white fs-4">NGO Donation</span>
            </div>
            <nav class="nav-links">
                <a href="<s:url value="/index"/>"><i class="fas fa-home"></i> Home</a>
                <a href="<s:url value="/about"/>"><i class="fas fa-info-circle"></i> About</a>
                <a href="<s:url value="/impact"/>"><i class="fas fa-chart-line"></i> Our Impact</a>
                <a href="<s:url value="/logout"/>"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="campaign-details">
            <h2 class="campaign-header">${campaign.title}</h2>

            <div class="campaign-info">
                <p><strong><i class="fas fa-hashtag"></i> Campaign ID:</strong> ${campaign.campaignId}</p>
                <p><strong><i class="fas fa-info-circle"></i> Description:</strong> ${campaign.description}</p>

                <div class="progress-container">
                    <div class="progress-stats">
                        <div class="progress-stat">
                            <div class="progress-stat-value">${campaign.targetAmount}</div>
                            <div class="progress-stat-label">Target Amount</div>
                        </div>
                        <div class="progress-stat">
                            <div class="progress-stat-value">${campaign.fundRaised}</div>
                            <div class="progress-stat-label">Funds Raised</div>
                        </div>
                        <div class="progress-stat">
                            <div class="progress-stat-value">${campaign.endDate}</div>
                            <div class="progress-stat-label">End Date</div>
                        </div>
                    </div>

                    <div class="progress">
                        <div class="progress-bar" role="progressbar"
                             style="width: ${(campaign.fundRaised/campaign.targetAmount) * 100}%"
                             aria-valuenow="${(campaign.fundRaised/campaign.targetAmount) * 100}"
                             aria-valuemin="0"
                             aria-valuemax="100">
                            ${(campaign.fundRaised/campaign.targetAmount) * 100}%
                        </div>
                    </div>
                </div>

                <p><strong><i class="far fa-calendar-alt"></i> Campaign Period:</strong> ${campaign.startDate} to ${campaign.endDate}</p>

                <div class="text-center mt-5">
                    <c:choose>
                        <c:when test="${sessionScope.userId != null}">
                           <a href="${pageContext.request.contextPath}/donation_form?campaignId=${campaign.campaignId}"
                              class="btn btn-donate">
                              <i class="fas fa-heart ms-2"></i> Donate Now
                           </a>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/login'/>" class="btn btn-donate">
                                <i class="fas fa-sign-in-alt"></i> Login to Donate
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>