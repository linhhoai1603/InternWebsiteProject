<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Thông Tin Liên Hệ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-4">Quản lý Thông Tin Liên Hệ</h2>

    <form action="ContactServlet" method="post">
        <div class="row">
            <div class="col-md-6">
                <!-- Phần thông tin khác -->
                <h4>Thông Tin Liên Hệ</h4>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="website" class="form-label">Website</label>
                    <input type="url" class="form-control" id="website" name="website">
                </div>
                <div class="mb-3">
                    <label for="hotline" class="form-label">Hotline</label>
                    <input type="text" class="form-control" id="hotline" name="hotline">
                </div>
                <button type="button" class="btn btn-secondary" onclick="editContact()">Sửa</button>
            </div>

            <div class="col-md-6">
                <!-- Phần địa chỉ -->
                <h4>Địa Chỉ</h4>
                <div class="mb-3">
                    <label for="province" class="form-label">Tỉnh/Thành phố</label>
                    <select id="province" class="form-control" required></select>
                </div>
                <div class="mb-3">
                    <label for="district" class="form-label">Quận/Huyện</label>
                    <select id="district" class="form-control" required></select>
                </div>
                <div class="mb-3">
                    <label for="ward" class="form-label">Phường/Xã</label>
                    <select id="ward" class="form-control" required></select>
                </div>
                <div class="mb-3">
                    <label for="street" class="form-label">Địa chỉ cụ thể</label>
                    <input type="text" class="form-control" id="street" name="street">
                </div>
                <button type="button" class="btn btn-secondary" onclick="editAddress()">Sửa</button>
            </div>
        </div>
    </form>
</div>

<script>
    $(document).ready(function() {
        // Gọi API để lấy danh sách tỉnh/thành phố
        $.get("https://provinces.open-api.vn/api/?depth=1", function(data) {
            let provinceSelect = $("#province");
            provinceSelect.append('<option value="">Chọn tỉnh/thành phố</option>');
            data.forEach(function(province) {
                provinceSelect.append(`<option value="${province.code}">${province.name}</option>`);
            });
        });

        // Khi chọn tỉnh/thành phố, load quận/huyện tương ứng
        $("#province").change(function() {
            let provinceCode = $(this).val();
            $("#district").html('<option value="">Chọn quận/huyện</option>');
            $("#ward").html('<option value="">Chọn phường/xã</option>');

            if (provinceCode) {
                $.get(`https://provinces.open-api.vn/api/p/${provinceCode}?depth=2`, function(data) {
                    let districtSelect = $("#district");
                    data.districts.forEach(function(district) {
                        districtSelect.append(`<option value="${district.code}">${district.name}</option>`);
                    });
                });
            }
        });

        // Khi chọn quận/huyện, load phường/xã tương ứng
        $("#district").change(function() {
            let districtCode = $(this).val();
            $("#ward").html('<option value="">Chọn phường/xã</option>');

            if (districtCode) {
                $.get(`https://provinces.open-api.vn/api/d/${districtCode}?depth=2`, function(data) {
                    let wardSelect = $("#ward");
                    data.wards.forEach(function(ward) {
                        wardSelect.append(`<option value="${ward.code}">${ward.name}</option>`);
                    });
                });
            }
        });
    });

    function editContact() {
        // Logic để sửa thông tin liên hệ
        alert("Chức năng sửa thông tin liên hệ chưa được triển khai.");
    }

    function editAddress() {
        // Logic để sửa địa chỉ
        alert("Chức năng sửa địa chỉ chưa được triển khai.");
    }
</script>

</body>
</html>
