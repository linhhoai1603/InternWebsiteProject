<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Log Hệ thống</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .log-container {
            margin: 20px;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .log-table {
            width: 100%;
            border-collapse: collapse;
        }
        .log-table th, .log-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .log-table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }
        .log-level {
            padding: 4px 8px;
            border-radius: 4px;
            font-weight: 500;
        }
        .log-level-info { background-color: #e3f2fd; color: #0d47a1; }
        .log-level-warning { background-color: #fff3e0; color: #e65100; }
        .log-level-error { background-color: #ffebee; color: #c62828; }
        .filter-section {
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <jsp:include page="menu-admin.jsp"/>
    
    <div class="container-fluid">
        <div class="log-container">
            <h2 class="mb-4">Quản lý Log Hệ thống</h2>
            
            <!-- Filter Section -->
            <div class="filter-section">
                <form action="manager-logging" method="get" class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label">Cấp độ Log</label>
                        <select name="logLevel" class="form-select">
                            <option value="">Tất cả</option>
                            <option value="INFO" ${selectedLevel == 'INFO' ? 'selected' : ''}>Info</option>
                            <option value="WARNING" ${selectedLevel == 'WARNING' ? 'selected' : ''}>Warning</option>
                            <option value="ERROR" ${selectedLevel == 'ERROR' ? 'selected' : ''}>Error</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Từ ngày</label>
                        <input type="date" name="fromDate" class="form-control" value="${fromDate}">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Đến ngày</label>
                        <input type="date" name="toDate" class="form-control" value="${toDate}">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">&nbsp;</label>
                        <button type="submit" class="btn btn-primary d-block">Lọc</button>
                    </div>
                </form>
            </div>

            <!-- Log Table -->
            <div class="table-responsive">
                <table class="log-table">
                    <thead>
                        <tr>
                            <th>Thời gian</th>
                            <th>Người dùng</th>
                            <th>Hành động</th>
                            <th>Mô tả</th>
                            <th>IP</th>
                            <th>Cấp độ</th>
                            <th>Chi tiết</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${logs}" var="log">
                            <tr>
                                <td>${log.createdAt}</td>
                                <td>${log.user.fullname}</td>
                                <td>${log.action}</td>
                                <td>${log.description}</td>
                                <td>${log.ipAddress}</td>
                                <td>
                                    <span class="log-level log-level-${log.level.toLowerCase()}">
                                        ${log.level}
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-info" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#logDetailModal"
                                            data-log-id="${log.id}">
                                        <i class="fas fa-info-circle"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="d-flex justify-content-center mt-4">
                <nav>
                    <ul class="pagination">
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <!-- Log Detail Modal -->
    <div class="modal fade" id="logDetailModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chi tiết Log</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <strong>User Agent:</strong>
                        <pre class="bg-light p-3 rounded">${log.userAgent}</pre>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const logDetailModal = document.getElementById('logDetailModal');
            if (logDetailModal) {
                logDetailModal.addEventListener('show.bs.modal', function(event) {
                    const button = event.relatedTarget;
                    const logId = button.getAttribute('data-log-id');
                    // Here you would typically fetch the log details via AJAX
                    // For now, we'll just show a placeholder
                    document.getElementById('logDetailContent').textContent = 
                        'Loading log details for ID: ' + logId;
                });
            }
        });
    </script>
</body>
</html> 