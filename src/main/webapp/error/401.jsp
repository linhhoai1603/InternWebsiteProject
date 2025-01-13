<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error 401 - Unauthorized</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            color: #333;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .error-container {
            text-align: center;
        }
        .error-code {
            font-size: 120px;
            font-weight: bold;
            color: #dc3545;
        }
        .error-message {
            font-size: 24px;
            font-weight: 500;
        }
        .error-description {
            font-size: 16px;
            color: #6c757d;
        }
        .btn-primary {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-code">401</div>
    <div class="error-message">Unauthorized</div>
    <p class="error-description">You are not authorized to access this page. Please log in with valid credentials.</p>
    <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-primary">
        Go to Login Page
    </a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
