document.addEventListener('DOMContentLoaded', function() {
    const useUserAddress = document.getElementById('use-user-address');
    const useNewAddress = document.getElementById('use-new-address');
    const userAddressSection = document.getElementById('user-address-section');
    const newAddressSection = document.getElementById('new-address-section');
    const provinceSelect = document.getElementById('new-province');
    const districtSelect = document.getElementById('new-district');
    const wardSelect = document.getElementById('new-ward');
    const shippingFeeDisplay = document.getElementById('shipping-fee-display');
    const totalPriceDisplay = document.getElementById('total-price-display');

    // Handle address type selection
    useUserAddress.addEventListener('change', function() {
        if (this.checked) {
            userAddressSection.style.display = 'block';
            newAddressSection.style.display = 'none';
            calculateShippingFee('user');
        }
    });

    useNewAddress.addEventListener('change', function() {
        if (this.checked) {
            userAddressSection.style.display = 'none';
            newAddressSection.style.display = 'block';
            calculateShippingFee('new');
        }
    });

    // Load provinces when the page loads
    loadProvinces();

    // Handle province selection
    provinceSelect.addEventListener('change', function() {
        const provinceCode = this.value;
        if (provinceCode) {
            loadDistricts(provinceCode);
            districtSelect.disabled = false;
            wardSelect.disabled = true;
            wardSelect.innerHTML = '<option value="">Chọn phường/xã</option>';
        } else {
            districtSelect.disabled = true;
            wardSelect.disabled = true;
            districtSelect.innerHTML = '<option value="">Chọn quận/huyện</option>';
            wardSelect.innerHTML = '<option value="">Chọn phường/xã</option>';
        }
        // No need to calculate fee here, district change will trigger it
    });

    // Handle district selection
    districtSelect.addEventListener('change', function() {
        const districtCode = this.value;
        if (districtCode) {
            loadWards(districtCode);
            wardSelect.disabled = false;
        } else {
            wardSelect.disabled = true;
            wardSelect.innerHTML = '<option value="">Chọn phường/xã</option>';
        }
        // No need to calculate fee here, ward change will trigger it
    });

    // Handle ward selection
    wardSelect.addEventListener('change', function() {
        calculateShippingFee('new');
    });

    // Get user address input fields
    const userProvinceInput = document.getElementById('province');
    const userDistrictInput = document.getElementById('district');
    const userWardInput = document.getElementById('ward');

    // Add event listeners to user address fields for immediate calculation
    userProvinceInput.addEventListener('change', () => calculateShippingFee('user'));
    userDistrictInput.addEventListener('change', () => calculateShippingFee('user'));
    userWardInput.addEventListener('change', () => calculateShippingFee('user'));

    // Function to calculate shipping fee
    function calculateShippingFee(addressType) {
        let provinceName, districtName, wardName;

        if (addressType === 'user') {
            provinceName = userProvinceInput.value;
            districtName = userDistrictInput.value;
            wardName = userWardInput.value;
        } else { // addressType === 'new'
            provinceName = provinceSelect.options[provinceSelect.selectedIndex]?.text || '';
            districtName = districtSelect.options[districtSelect.selectedIndex]?.text || '';
            wardName = wardSelect.options[wardSelect.selectedIndex]?.text || '';
        }

        if (!provinceName || !districtName || !wardName) {
            shippingFeeDisplay.textContent = '..';
            // Optionally update total price to base cart total if address is incomplete
            // This might require getting the base cart total price from somewhere
            // For now, we'll just clear the shipping fee display.
            return;
        }

        // Show loading state
        shippingFeeDisplay.textContent = 'Đang tính...';

        // Call the backend API to calculate shipping fee using address names
        fetch('/ProjectWeb/api/calculate-shipping', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                province: provinceName,
                district: districtName,
                ward: wardName
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                throw new Error(data.error);
            }
            // Update shipping fee display
            const formattedFee = new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
            }).format(data.shipping_fee);
            shippingFeeDisplay.textContent = formattedFee;

            // Update total price
            const formattedTotal = new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
            }).format(data.total_price);
            totalPriceDisplay.textContent = formattedTotal;
        })
        .catch(error => {
            console.error('Error calculating shipping fee:', error);
            shippingFeeDisplay.textContent = 'Lỗi tính phí';
        });
    }

    // Function to load provinces
    function loadProvinces() {
        fetch('https://provinces.open-api.vn/api/?depth=1')
            .then(response => response.json())
            .then(data => {
                provinceSelect.innerHTML = '<option value="">Chọn tỉnh/thành</option>';
                data.forEach(province => {
                    const option = document.createElement('option');
                    option.value = province.code;
                    option.textContent = province.name;
                    provinceSelect.appendChild(option);
                });
            })
            .catch(error => console.error('Error loading provinces:', error));
    }

    // Function to load districts
    function loadDistricts(provinceCode) {
        fetch(`https://provinces.open-api.vn/api/p/${provinceCode}?depth=2`)
            .then(response => response.json())
            .then(data => {
                districtSelect.innerHTML = '<option value="">Chọn quận/huyện</option>';
                data.districts.forEach(district => {
                    const option = document.createElement('option');
                    option.value = district.code;
                    option.textContent = district.name;
                    districtSelect.appendChild(option);
                });
            })
            .catch(error => console.error('Error loading districts:', error));
    }

    // Function to load wards
    function loadWards(districtCode) {
        fetch(`https://provinces.open-api.vn/api/d/${districtCode}?depth=2`)
            .then(response => response.json())
            .then(data => {
                wardSelect.innerHTML = '<option value="">Chọn phường/xã</option>';
                data.wards.forEach(ward => {
                    const option = document.createElement('option');
                    option.value = ward.code;
                    option.textContent = ward.name;
                    wardSelect.appendChild(option);
                });
            })
            .catch(error => console.error('Error loading wards:', error));
    }

    // Calculate shipping fee on page load if user address is selected
    if (useUserAddress.checked) {
        // Delay to ensure user address fields are populated (if coming from session)
        setTimeout(() => calculateShippingFee('user'), 100);
    }
}); 