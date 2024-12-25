<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid ">
        <a class="navbar-brand mt-4" href="#">NGO Donation</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse mt-4" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <c:if test="${sessionScope.userId == null}">
                    <s:url var="home_url" value="/index"/>
                    <s:url var="login_url" value="/index"/>
                    <s:url var="reg_url" value="/reg_form"/>
                    <s:url var="camp_url" value="/campaign"/>
                    <li class="nav-item">
                        <a class="nav-link" href="${home_url}">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${login_url}">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${reg_url}">Register</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${camp_url}">Campaign</a>
                    </li>
                </c:if>

                <c:if test="${sessionScope.userId != null && sessionScope.role == 1}">
                    <s:url var="admin_users_url" value="/admin/users"/>
                    <s:url var="logout_url" value="/logout"/>
                    <s:url var="camp_url" value="/campaign"/>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${admin_users_url}">User  List</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${logout_url}">Logout</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${camp_url}">Campaign</a>
                    </li>
                </c:if>

                <c:if test="${sessionScope.userId != null && sessionScope.role == 2}">
                    <li class="nav-item">
                        <a class="nav-link" href="user_dashboard">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="campaign">Campaign</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout">Logout</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>