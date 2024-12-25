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
    <title>Register - NGO Donation</title>
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

        .registration-container {
            max-width: 600px;
            margin: 120px auto 2rem;
            padding: 2.5rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }

        .registration-title {
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

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 500;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .input-group {
            margin-bottom: 1.5rem;
        }

        .input-group-text {
            background-color: #f8f9fa;
            border-color: #e1e1e1;
        }

        .footer {
            background-color: var(--primary-color);
            color: white;
            padding: 2rem 0;
            margin-top: auto;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .registration-container {
                margin: 100px 1rem 2rem;
                padding: 1.5rem;
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
                <a href="campaign">Projects</a>
                <a href="login">Login</a>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="registration-container">
            <h2 class="registration-title">Create Account</h2>

            <c:if test="${not empty err}">
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${err}
                </div>
            </c:if>
            <c:if test="${param.act eq 'reg'}">
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i>Registration Successful!
                </div>
            </c:if>

            <f:form action="register" modelAttribute="command">
                   <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <f:input path="user.name" class="form-control" placeholder="Enter your name"
                                         pattern="[A-Za-z\s]+" title="Name should only contain letters and spaces." required="required"/>
                            </div>

                <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                <f:input path="user.phone" class="form-control" placeholder="Enter your phone number"
                                         pattern="^(\+?\d{1,3}[- ]?)?\(?\d{3}\)?[- ]?\d{3}[- ]?\d{4}$"
                                         title="Phone number must be in a valid format." required="required"/>
                            </div>

                <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                <f:input path="user.address" class="form-control" placeholder="Enter your address"
                                         pattern="[A-Za-z0-9\s,.-]+" title="Address can contain letters, numbers, and some special characters." required="required"/>
                            </div>

                <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                <f:input path="user.email" class="form-control" placeholder="Enter your email"
                                         pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                                         title="Please enter a valid email address." required="required"/>
                            </div>

                <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user-circle"></i></span>
                                <f:input path="user.loginName" class="form-control" placeholder="Choose a username"
                                         pattern="^[a-zA-Z0-9_]{3,15}$"
                                         title="Username must be 3-15 characters long and can contain letters, numbers, and underscores." required="required"/>
                            </div>

                 <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <f:password path="user.password" class="form-control" placeholder="Choose a password"
                                            pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
                                            title="Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character." required="required"/>
                            </div>

                <button type="submit" class="btn btn-primary">
                    Register <i class="fas fa-arrow-right ms-2"></i>
                </button>

                <div class="text-center mt-3">
                    <a href="<s:url value="/login"/>" class="text-primary">Already have an account? Sign In</a>
                </div>
            </f:form>
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
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form[action$="/register"]');
            const nameInput = document.querySelector('input[name="user.name"]');
            const phoneInput = document.querySelector('input[name="user.phone"]');
            const addressInput = document.querySelector('input[name="user.address"]');
            const emailInput = document.querySelector('input[name="user.email"]');
            const loginNameInput = document.querySelector('input[name="user.loginName"]');
            const passwordInput = document.querySelector('input[name="user.password"]');

            function validateName(name) {
                const nameRegex = /^[A-Za-z\s]+$/;
                return nameRegex.test(name);
            }

            function validatePhone(phone) {
                const phoneRegex = /^(\+?\d{1,3}[- ]?)?\(?\d{3}\)?[- ]?\d{3}[- ]?\d{4}$/;
                return phoneRegex.test(phone);
            }

            function validateAddress(address) {
                const addressRegex = /^[A-Za-z0-9\s,.-]+$/;
                return addressRegex.test(address);
            }

            function validateEmail(email) {
                const emailRegex = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
                return emailRegex.test(email);
            }

            function validateLoginName(loginName) {
                const loginNameRegex = /^[a-zA-Z0-9_]{3,15}$/;
                return loginNameRegex.test(loginName);
            }

            function validatePassword(password) {
                const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
                return passwordRegex.test(password);
            }

            function showError(input, message) {
                const existingError = input.parentElement.querySelector('.validation-error');
                if (existingError) {
                    existingError.remove();
                }

                const errorElement = document.createElement('div');
                errorElement.className = 'validation-error text-danger small mt-1';
                errorElement.textContent = message;

                input.parentElement.appendChild(errorElement);
                input.classList.add('is-invalid');
            }

            function clearError(input) {
                const existingError = input.parentElement.querySelector('.validation-error');
                if (existingError) {
                    existingError.remove();
                }
                input.classList.remove('is-invalid');
            }

            nameInput.addEventListener('input', function() {
                const nameValue = this.value.trim();

                if (nameValue === '') {
                    clearError(this);
                    return;
                }

                if (!validateName(nameValue)) {
                    showError(this, 'Name should only contain letters and spaces.');
                } else {
                    clearError(this);
                }
            });

            phoneInput.addEventListener('input', function() {
                const phoneValue = this.value.trim();

                if (phoneValue === '') {
                    clearError(this);
                    return;
                }

                if (!validatePhone(phoneValue)) {
                    showError(this, 'Phone number must be in a valid format.');
                } else {
                    clearError(this);
                }
            });

            addressInput.addEventListener('input', function() {
                const addressValue = this.value.trim();

                if (addressValue === '') {
                    clearError(this);
                    return;
                }

                if (!validateAddress(addressValue)) {
                    showError(this, 'Address can contain letters, numbers, and some special characters.');
                } else {
                    clearError(this);
                }
            });

            emailInput.addEventListener('input', function() {
                const emailValue = this.value.trim();

                if (emailValue === '') {
                    clearError(this);
                    return;
                }

                if (!validateEmail(emailValue)) {
                    showError(this, 'Please enter a valid email address.');
                } else {
                    clearError(this);
                }
            });

            loginNameInput.addEventListener('input', function() {
                const loginNameValue = this.value.trim();

                if (loginNameValue === '') {
                    clearError(this);
                    return;
                }

                if (!validateLoginName(loginNameValue)) {
                    showError(this, 'Username must be 3-15 characters long and can contain letters, numbers, and underscores.');
                } else {
                    clearError(this);
                }
            });

            passwordInput.addEventListener('input', function() {
                const passwordValue = this.value.trim();

                if (passwordValue === '') {
                    clearError(this);
                    return;
                }

                if (!validatePassword(passwordValue)) {
                    showError(this, 'Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character.');
                     isValid = false;
                     } if (!isValid) {
                      event.preventDefault();
                       }
                       });
                       });
                       </script>


</body>
</html>