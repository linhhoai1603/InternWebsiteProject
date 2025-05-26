<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Error 404 - Page Not Found</title>
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
  <div>
    <img src="https://th.bing.com/th/id/R.3972efa083b80894bfcd5c99737c7cab?rik=ohS%2fS1CCbqm5kA&pid=ImgRaw&r=0">
  </div>
  <p class="error-description">Oops! The page you are looking for does not exist.</p>
  <a href="<%= request.getContextPath() %>/home" class="btn btn-primary">
    Return to Homepage
  </a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
