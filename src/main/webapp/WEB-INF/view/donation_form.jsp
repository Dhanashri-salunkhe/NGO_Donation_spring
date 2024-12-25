<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page isELIgnored="false"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donate - NGO Donation</title>
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
            min-height: 100vh;
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                        url('${url_bg}') center/cover no-repeat fixed;
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

        .donation-container {
            max-width: 500px;
            margin: 120px auto 2rem;
            padding: 2.5rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }

        .donation-title {
            color: var(--text-color);
            font-size: 2rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-control {
            border-radius: 8px;
            padding: 0.8rem 1rem;
            border: 1px solid #e1e1e1;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.25);
        }

        .btn-primary {
            background-color: var(--accent-color);
            border: none;
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 1rem;
        }

        .btn-primary:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .input-group {
            margin-bottom: 1.5rem;
        }

        .input-group-text {
            background-color: #f8f9fa;
            border-color: #e1e1e1;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .donation-container {
                margin: 100px 1rem 2rem;
                padding: 1.5rem;
            }
        }


        .document-info {
            border-top: 1px solid #e1e1e1;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
        }

        .document-info h5 {
            color: var(--text-color);
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }
        .welcome-message h4 {
            color: white;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        .validation-error {
            display: block;
            margin-top: 0.5rem;
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
                <a href="index">Home</a>
                <a href="about">About</a>
                <a href="impact">Our Impact</a>
                <a href="campaign">Projects</a>
                <a href="logout">Logout</a>


            </nav>
        </div>
    </header>

    <div class="container">

        <div class="donation-container">

            <h2 class="donation-title">Make a Donation</h2>

            <c:if test="${not empty err}">
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${err}
                </div>
            </c:if>

            <c:if test="${empty sessionScope.user}">
                <c:redirect url="/login"/>
            </c:if>

            <c:if test="${param.act eq 'donate'}">
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i>Donation Successful! Thank you for your generosity.
                </div>
            </c:if>

         <f:form action="${pageContext.request.contextPath}/create-order"
                 modelAttribute="donationCommand"
                 method="POST">
                  <f:hidden path="userId" value="${sessionScope.userId}" />
                  <f:hidden path="campaignId" value="${param.campaignId}" />

             <div class="input-group">
                 <span class="input-group-text"><i class="fas fa-dollar-sign"></i></span>
                 <f:input path="donationAmount" type="number" step="0.01" class="form-control" placeholder="Enter donation amount"/>
             </div>

             <div class="input-group">
                 <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                 <f:input path="donationDate" type="date" class="form-control"/>
             </div>
             <div class="document-info">
                 <h5>Document Information</h5>
                 <div class="mb-4">
                     <label class="form-label">Aadhaar Number</label>
                     <div class="input-group">
                         <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                         <f:input path="aadhaarNumber" class="form-control" placeholder="Enter Aadhaar Number"/>
                     </div>
                 </div>

                 <div class="mb-4">
                     <label class="form-label">PAN Card Number</label>
                     <div class="input-group">
                         <span class="input-group-text"><i class="fas fa-file-alt"></i></span>
                         <f:input path="panCardNumber" class="form-control" placeholder="Enter PAN Card Number"/>
                     </div>
                 </div>
             </div>
             <button type="submit" class="btn btn-primary">
                 Donate Now <i class="fas fa-heart ms-2"></i>
             </button>
         </f:form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
     <script>
         document.addEventListener('DOMContentLoaded', function() {
             const form = document.querySelector('form[action$="/donate"]');
             const aadhaarInput = document.querySelector('input[name="aadhaarNumber"]');
             const panCardInput = document.querySelector('input[name="panCardNumber"]');

             function validateAadhaarNumber(aadhaar) {
                 const aadhaarRegex = /^\d{12}$/;
                 return aadhaarRegex.test(aadhaar);
             }

             function validatePanCardNumber(panCard) {
                 const panCardRegex = /^[A-Z]{5}\d{4}[A-Z]$/;
                 return panCardRegex.test(panCard);
             }

             function showError(input, message) {
                 // Remove ALL existing errors for this input
                 const existingErrors = input.closest('.input-group').parentElement.querySelectorAll('.validation-error');
                 existingErrors.forEach(error => error.remove());

                 // Create error element
                 const errorElement = document.createElement('div');
                 errorElement.className = 'validation-error text-danger small mt-1 w-100';
                 errorElement.textContent = message;

                 // Find the parent input group and insert the error after it
                 const inputGroup = input.closest('.input-group');
                 inputGroup.after(errorElement);
                 input.classList.add('is-invalid');
             }

             function clearError(input) {
                 // Remove ALL error messages for this input
                 const existingErrors = input.closest('.input-group').parentElement.querySelectorAll('.validation-error');
                 existingErrors.forEach(error => error.remove());
                 input.classList.remove('is-invalid');
             }

             aadhaarInput.addEventListener('input', function() {
                 const originalValue = this.value;
                 this.value = this.value.replace(/[^\d]/g, '');

                 // Clear any existing errors first
                 clearError(this);

                 if (originalValue !== this.value) {
                     showError(this, 'Only Numeric values are allowed in Aadhaar number');
                     return;
                 }

                 const aadhaarValue = this.value.trim();

                 if (aadhaarValue === '') {
                     clearError(this);
                     return;
                 }

                 if (!validateAadhaarNumber(aadhaarValue)) {
                     showError(this, 'Aadhaar number must be 12 digits');
                 } else {
                     clearError(this);
                 }
             });

             panCardInput.addEventListener('input', function() {
                 // Clear any existing errors first
                 clearError(this);

                 const panCardValue = this.value.trim().toUpperCase();

                 if (panCardValue === '') {
                     clearError(this);
                     return;
                 }

                 if (!validatePanCardNumber(panCardValue)) {
                     showError(this, 'Invalid PAN Card number format (e.g., ABCDE1234F)');
                 } else {
                     clearError(this);
                 }
             });

             form.addEventListener('submit', function(event) {
                 let isValid = true;

                 const aadhaarValue = aadhaarInput.value.trim();
                 if (aadhaarValue !== '' && !validateAadhaarNumber(aadhaarValue)) {
                     showError(aadhaarInput, 'Aadhaar number must be 12 digits');
                     isValid = false;
                 }

                 const panCardValue = panCardInput.value.trim().toUpperCase();
                 if (panCardValue !== '' && !validatePanCardNumber(panCardValue)) {
                     showError(panCardInput, 'Invalid PAN Card number format (e.g., ABCDE1234F)');
                     isValid = false;
                 }

                 if (!isValid) {
                     event.preventDefault();
                 }
             });
         });
            </script>
</body>
</html>