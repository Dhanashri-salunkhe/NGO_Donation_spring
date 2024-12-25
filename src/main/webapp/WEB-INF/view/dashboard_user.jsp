<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>User Dashboard</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <header>
            <jsp:include page="include/header.jsp"/>
        </header>

        <nav>
            <jsp:include page="include/menu.jsp"/>
        </nav>

        <main class="mt-4">
            <h1>User Dashboard</h1>
            <p>Todo form</p>

        </main>

        <footer class="mt-5">
            <jsp:include page="include/footer.jsp"/>
        </footer>
    </div>
</body>
</html>