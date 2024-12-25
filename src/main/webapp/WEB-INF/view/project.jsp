<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Details - NGO DonationS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

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
        }

        .project-details-container {
            padding: 3rem 0;
        }

        .project-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .project-header {
            background-color: var(--primary-color);
            color: white;
            padding: 2rem;
        }

        .progress {
            height: 25px;
            border-radius: 12px;
        }

        .date-badge {
            background-color: var(--accent-color);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            display: inline-block;
            margin: 0.5rem 0;
        }

        .donation-stats {
            background-color: #f8f9fa;
            padding: 1.5rem;
            border-radius: 10px;
            margin: 1rem 0;
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
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>

    <header class="header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div class="logo-container">
                    <img src="${url_logo}" alt="Logo" style="height: 40px;">
                    <span class="ms-2 text-white fs-4">NGO Donation</span>
                </div>
                <nav>
                    <a href="<s:url value="/home"/>" class="btn btn-outline-light">Back to Home</a>
                </nav>
            </div>
        </div>
    </header>

    <div class="project-details-container">
        <div class="container">
            <div class="project-card">
                <div class="project-header">
                    <h1 class="mb-3">${campaign.campaignName}</h1>
                    <p class="lead mb-0">${campaign.description}</p>
                </div>

                <div class="container py-4">
                    <div class="donation-stats">
                        <div class="row text-center">
                            <div class="col-md-4">
                                <h3>₹${campaign.fundRaised}</h3>
                                <p class="text-muted">Funds Raised</p>
                            </div>
                            <div class="col-md-4">
                                <h3>₹${campaign.targetAmount}</h3>
                                <p class="text-muted">Target Amount</p>
                            </div>
                            <div class="col-md-4">
                                <h3>${(campaign.fundRaised / campaign.targetAmount) * 100}%</h3>
                                <p class="text-muted">Progress</p>
                            </div>
                        </div>

                        <div class="progress mt-4">
                            <div class="progress-bar progress-bar-striped progress-bar-animated"
                                 role="progressbar"
                                 style="width: ${(campaign.fundRaised / campaign.targetAmount) * 100}%">
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="date-badge">
                                <i class="fas fa-calendar-alt me-2"></i>Start Date: ${campaign.startDate}
                            </div>
                        </div>
                        <div class="col-md-6 text-md-end">
                            <div class="date-badge">
                                <i class="fas fa-calendar-check me-2"></i>End Date: ${campaign.endDate}
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-5">
                        <a href="<s:url value="/donate/${campaign.id}"/>" class="btn btn-donate">
                            Donate Now <i class="fas fa-heart ms-2"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>