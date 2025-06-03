function previewImageAndSubmit(event) {
    const file = event.target.files[0];
    const reader = new FileReader();

    reader.onload = function () {
        // Cập nhật ảnh đại diện với ảnh người dùng đã chọn
        const userAvatar = document.getElementById('userAvatar');
        userAvatar.src = reader.result;

        // Sau khi chọn ảnh, tự động submit form
        document.getElementById('avatarForm').submit();
    }

    if (file) {
        reader.readAsDataURL(file);
    }
}

// Store loaded provinces and districts to avoid repeated API calls for codes
let loadedProvincesData = [];
let loadedDistrictsData = []; // This will store districts with their wards

// Function to load provinces from API
async function loadProvinces() {
    try {
        const response = await fetch('https://provinces.open-api.vn/api/?depth=1');
        loadedProvincesData = await response.json(); // Store data
        const provinceSelect = document.getElementById('province');
        provinceSelect.innerHTML = '<option value="">Chọn tỉnh/thành phố</option>';

        loadedProvincesData.forEach(province => {
            const option = document.createElement('option');
            option.value = province.code;
            option.textContent = province.name;
            provinceSelect.appendChild(option);
        });
        provinceSelect.disabled = false;
    } catch (error) {
        console.error('Error loading provinces:', error);
    }
}

// Function to load districts from API based on selected province code
async function loadDistricts(provinceCode) {
    console.log('loadDistricts called with provinceCode:', provinceCode);
    try {
        const response = await fetch(`https://provinces.open-api.vn/api/p/${provinceCode}?depth=2`);
        const data = await response.json();
        loadedDistrictsData = data.districts || []; // Store districts data
        const districtSelect = document.getElementById('district');
        districtSelect.innerHTML = '<option value="">Chọn quận/huyện</option>'; // Clear existing options
        districtSelect.disabled = true;

        if (loadedDistrictsData.length > 0) {
            loadedDistrictsData.forEach(district => {
                const option = document.createElement('option');
                option.value = district.code; // Use code as value
                option.textContent = district.name; // Use name for display
                districtSelect.appendChild(option);
            });
            districtSelect.disabled = false;
        }
        document.getElementById('ward').innerHTML = '<option value="">Chọn phường/xã</option>';
        document.getElementById('ward').disabled = true;

    } catch (error) {
        console.error('Error loading districts:', error);
    }
}

// Function to load wards from API based on selected district code
async function loadWards(districtCode) {
    try {
        const response = await fetch(`https://provinces.open-api.vn/api/d/${districtCode}?depth=2`);
        const data = await response.json();
        const wards = data.wards || [];

        const wardSelect = document.getElementById('ward');
        wardSelect.innerHTML = '<option value="">Chọn phường/xã</option>';
        wardSelect.disabled = true;

        if (wards.length > 0) {
            wards.forEach(ward => {
                const option = document.createElement('option');
                option.value = ward.code;
                option.textContent = ward.name;
                wardSelect.appendChild(option);
            });
            wardSelect.disabled = false;
        }
    } catch (error) {
        console.error('Error loading wards:', error);
    }
}

// Add event listeners for dropdown changes
document.getElementById('province').addEventListener('change', (e) => {
    const provinceCode = e.target.value; // Get the code from the selected option's value
    console.log('Selected province code:', provinceCode); // Log the selected province code
    if (provinceCode) {
        loadDistricts(provinceCode);
    } else {
        document.getElementById('district').innerHTML = '<option value="">Chọn quận/huyện</option>';
        document.getElementById('district').disabled = true;
        document.getElementById('ward').innerHTML = '<option value="">Chọn phường/xã</option>';
        document.getElementById('ward').disabled = true;
    }
});

document.getElementById('district').addEventListener('change', (e) => {
    const districtCode = e.target.value; // Get the code from the selected option's value
    if (districtCode) {
        loadWards(districtCode);
    } else {
        document.getElementById('ward').innerHTML = '<option value="">Chọn phường/xã</option>';
        document.getElementById('ward').disabled = true;
    }
});

// Load provinces when the page is ready
document.addEventListener('DOMContentLoaded', loadProvinces);
