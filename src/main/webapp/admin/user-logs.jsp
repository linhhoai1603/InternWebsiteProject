<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Logs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>User Activity Logs</h2>
        
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Log ID</th>
                    <th>User ID</th>
                    <th>Action</th>
                    <th>Description</th>
                    <th>Timestamp</th>
                    <th>IP Address</th>
                    <th>User Agent</th>
                    <th>Level</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="log" items="${requestScope.userLogs}">
                    <tr>
                        <td>${log.id}</td>
                        <td>${log.userId}</td>
                        <td>${log.action}</td>
                        <td>${log.description}</td>
                        <td>${log.createdAt}</td>
                        <td>${log.ipAddress}</td>
                        <td>${log.userAgent}</td>
                        <td>${log.level}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Pagination Controls -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <!-- Previous button -->
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                
                <!-- Page numbers -->
                <c:set var="startPage" value="${currentPage - 2 > 1 ? currentPage - 2 : 1}"/>
                <c:set var="endPage" value="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}"/>

                <c:if test="${startPage > 1}">
                    <li class="page-item disabled"><span class="page-link">...</span></li>
                </c:if>

                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                
                <c:if test="${endPage < totalPages}">
                    <li class="page-item disabled"><span class="page-link">...</span></li>
                </c:if>

                <!-- Next button -->
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
        
        <a href="<%= request.getContextPath() %>/admin/dashboard" class="btn btn-secondary mt-3">Back to Dashboard</a>
    </div>
</body>
</html> 