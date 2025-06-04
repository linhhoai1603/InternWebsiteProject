<%--
  Created by IntelliJ IDEA.
  User: mypc
  Date: 6/3/2025
  Time: 9:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý nhân viên</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="management-employee.jsp.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }

        .container {
            max-width: 1200px;
            padding: 2rem;
        }

        .header-bar {
            background-color: #fff;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }

        .top-actions {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .search-box {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .staff-list {
            display: grid;
            gap: 1rem;
        }

        .staff-item {
            background-color: #fff;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .staff-details {
            flex: 1;
        }

        .staff-actions {
            display: flex;
            gap: 0.5rem;
        }

        .btn-action {
            padding: 0.5rem 1rem;
        }

        .nav-tabs {
            margin-bottom: 2rem;
        }

        .card {
            border: none;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .alert-container {
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-bar">
        <h2 class="mb-0">Quản lý Nhân viên</h2>
    </div>
    <%
        Integer role = (Integer) session.getAttribute("role");
    %>
    <div class="top-actions">
        <a href="dashboard" class="btn btn-primary">
            <i class="fas fa-arrow-left"></i> Quay lại
        </a>
        <% if ((role != null && role == 3) || (role != null && role == 2)) { %>
        <button class="btn btn-success" id="toggleAddStaffForm">
            <i class="fas fa-user-plus me-2"></i>Thêm nhân viên mới
        </button>
        <% } %>
    </div>

    <%-- Display messages from session --%>
    <div class="alert-container">
        <c:if test="${not empty sessionScope.registrationMessage}">
            <div class="alert <c:choose><c:when test='${sessionScope.registrationStatus == true}'>alert-success</c:when><c:otherwise>alert-danger</c:otherwise></c:choose> alert-dismissible fade show"
                 role="alert">
                    ${sessionScope.registrationMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%-- Remove messages from session after displaying --%>
            <c:remove var="registrationStatus" scope="session"/>
            <c:remove var="registrationMessage" scope="session"/>
        </c:if>
    </div>

    <div class="collapse" id="addStaffForm">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title mb-4">Thông tin nhân viên mới</h4>
                <%-- Form submits directly to servlet --%>
                <form id="staffRegistrationForm" action="${pageContext.request.contextPath}/api/create-employee"
                      method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="newStaffEmail" class="form-label">Email *</label>
                            <input type="email" class="form-control" name="email" id="newStaffEmail" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="newStaffUsername" class="form-label">Username *</label>
                            <input type="text" class="form-control" name="username" id="newStaffUsername" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="newStaffFirstName" class="form-label">First Name *</label>
                            <input type="text" class="form-control" name="firstName" id="newStaffFirstName" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="newStaffLastName" class="form-label">Last Name *</label>
                            <input type="text" class="form-control" name="lastName" id="newStaffLastName" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="newStaffPhone" class="form-label">Phone Number *</label>
                            <input type="tel" class="form-control" name="phoneNumber" id="newStaffPhone" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="newStaffRole" class="form-label">Vai trò *</label>
                        <select class="form-select" name="role" id="newStaffRole" required>
                            <option value="4"${param.role == '3' ? 'selected' : ''}>Nhân viên (Staff)</option>
                            <c:if test="${currentUserRole == 2}">
                                <option value="3"${param.role == '4' ? 'selected' : ''}>Quản lý (Manager)</option>
                            </c:if>
                        </select>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-user-plus me-2"></i>Tạo nhân viên
                        </button>
                        <button type="button" class="btn btn-secondary" data-bs-toggle="collapse"
                                data-bs-target="#addStaffForm">
                            <i class="fas fa-times me-2"></i>Hủy
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="search-box">
        <div class="input-group">
            <input type="text" class="form-control" placeholder="Tìm kiếm theo tên hoặc email..." id="searchInput">
            <button class="btn btn-primary" id="searchButton">
                <i class="fas fa-search"></i> Tìm kiếm
            </button>
        </div>
    </div>

    <ul class="nav nav-tabs" id="staffTabs" role="tablist">
        <li class="nav-item">
            <button class="nav-link active" id="staff-tab" data-bs-toggle="tab" data-bs-target="#staff" type="button"
                    role="tab">Nhân viên
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link" id="managers-tab" data-bs-toggle="tab" data-bs-target="#managers" type="button"
                    role="tab">Quản lý
            </button>
        </li>
    </ul>

    <div class="tab-content" id="staffTabsContent">
        <div class="tab-pane fade show active" id="staff" role="tabpanel">
            <div class="staff-list">
                <c:forEach var="staff" items="${staffList}">
                    <div class="staff-item">
                        <div class="staff-details">
                            <h5 class="mb-1">${staff.firstname} ${staff.lastname}</h5>
                            <p class="mb-1 text-muted">Mã NV: ${staff.id}</p>
                            <p class="mb-0 text-muted">${staff.email}</p>
                        </div>
                        <div class="staff-actions">
                            <button class="btn btn-info btn-action" onclick="viewEmployeeDetail(${staff.id})">
                                <i class="fas fa-info-circle me-1"></i>Xem chi tiết
                            </button>
                            <c:if test="${currentUserRole == 2 || currentUserRole == 3}">
                                <button class="btn btn-danger btn-action" onclick="deleteEmployee(${staff.id})">
                                    <i class="fas fa-trash me-1"></i>Xóa
                                </button>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="tab-pane fade" id="managers" role="tabpanel">
            <div class="staff-list">
                <c:forEach var="manager" items="${managerList}">
                    <div class="staff-item">
                        <div class="staff-details">
                            <h5 class="mb-1">${manager.firstname} ${manager.lastname}</h5>
                            <p class="mb-1 text-muted">Mã QL: ${manager.id}</p>
                            <p class="mb-0 text-muted">${manager.email}</p>
                        </div>
                        <div class="staff-actions">
                            <button class="btn btn-info btn-action" onclick="viewEmployeeDetail(${manager.id})">
                                <i class="fas fa-info-circle me-1"></i>Xem chi tiết
                            </button>
                            <button class="btn btn-warning btn-action" onclick="demoteManager(${manager.id})">
                                <i class="fas fa-arrow-down me-1"></i>Hạ cấp
                            </button>
                            <c:if test="${currentUserRole == 2}">
                                <button class="btn btn-danger btn-action" onclick="deleteEmployee(${manager.id})">
                                    <i class="fas fa-trash me-1"></i>Xóa
                                </button>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!-- Modal xem chi tiết -->
<div class="modal fade" id="employeeDetailModal" tabindex="-1" aria-labelledby="employeeDetailModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="employeeDetailModalLabel">Thông tin chi tiết</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered">
                    <tbody>
                    <tr>
                        <th>Mã nhân viên</th>
                        <td id="detail-id"></td>
                    </tr>
                    <tr>
                        <th>Họ và tên</th>
                        <td id="detail-name"></td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td id="detail-email"></td>
                    </tr>
                    <tr>
                        <th>Username</th>
                        <td id="detail-username"></td>
                    </tr>
                    <tr>
                        <th>Số điện thoại</th>
                        <td id="detail-phone"></td>
                    </tr>
                    <tr>
                        <th>Vai trò</th>
                        <td id="detail-role"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/management_employee.js"></script>
<script>function viewEmployeeDetail(id) {
    fetch('${pageContext.request.contextPath}/admin/view-employee', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'id=' + id
    })
        .then(response => response.json())
        .then(data => {
            if (data.status) {
                document.getElementById("detail-id").innerText = data.employee.id;
                document.getElementById("detail-name").innerText = data.employee.firstname + ' ' + data.employee.lastname;
                document.getElementById("detail-email").innerText = data.employee.email;
                document.getElementById("detail-username").innerText = data.employee.username;
                document.getElementById("detail-phone").innerText = data.employee.phoneNumber;
                document.getElementById("detail-role").innerText = data.employee.roleName;

                const modal = new bootstrap.Modal(document.getElementById('employeeDetailModal'));
                modal.show();
            } else {
                alert("Không tìm thấy thông tin nhân viên.");
            }
        })
        .catch(err => {
            console.error(err);
            alert("Lỗi khi tải thông tin chi tiết.");
        });
}</script>
</body>
</html>
