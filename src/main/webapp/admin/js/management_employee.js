document.addEventListener('DOMContentLoaded', function () {
    const staffTab = document.getElementById('staff-tab');
    if (staffTab) staffTab.click();

    const toggleButton = document.getElementById('toggleAddStaffForm');
    const addStaffForm = document.getElementById('addStaffForm');
    if (toggleButton && addStaffForm) {
        toggleButton.addEventListener('click', function () {
            const bsCollapse = new bootstrap.Collapse(addStaffForm, {
                toggle: true
            });
        });
    }
});

function deleteEmployee(id) {
    if (!confirm("Bạn có chắc chắn muốn xóa nhân viên này?")) return;

    fetch('${pageContext.request.contextPath}/admin/delete-employee', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'id=' + id
    })
        .then(response => response.json())
        .then(data => {
            alert(data.message);
            if (data.status) {
                location.reload();
            }
        })
        .catch(err => console.error(err));
}

function demoteManager(id) {
    if (!confirm("Bạn có chắc muốn hạ cấp người này?")) return;

    fetch('${pageContext.request.contextPath}/admin/demote-manager', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'id=' + id
    })
        .then(response => response.json())
        .then(data => {
            alert(data.message);
            if (data.status) {
                location.reload();
            }
        })
        .catch(err => console.error(err));
}

const searchInput = document.getElementById('searchInput');
const searchButton = document.getElementById('searchButton');

function filterEmployeeList() {
    const searchTerm = searchInput.value.toLowerCase().trim();

    const staffItems = document.querySelectorAll('#staff .staff-item');
    staffItems.forEach(item => {
        const name = item.querySelector('.staff-details h5').textContent.toLowerCase();
        const email = item.querySelector('.staff-details p:last-of-type').textContent.toLowerCase();

        if (name.includes(searchTerm) || email.includes(searchTerm)) {
            item.style.display = 'flex';
        } else {
            item.style.display = 'none';
        }
    });

    // Lọc danh sách quản lý (tab Managers)
    const managerItems = document.querySelectorAll('#managers .staff-item');
    managerItems.forEach(item => {
        const name = item.querySelector('.staff-details h5').textContent.toLowerCase();
        const email = item.querySelector('.staff-details p:last-of-type').textContent.toLowerCase();
        if (name.includes(searchTerm) || email.includes(searchTerm)) {
            item.style.display = 'flex';
        } else {
            item.style.display = 'none';
        }
    });
}

if (searchButton) {
    searchButton.addEventListener('click', filterEmployeeList);
}
if (searchInput) {
    searchInput.addEventListener('input', filterEmployeeList);
}