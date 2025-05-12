    document.addEventListener('DOMContentLoaded', function () {
    const shippingForm = document.getElementById('shipping-form');
    const paymentForm = document.getElementById('payment-form');

    const shippingSection = document.getElementById('shipping-info-section');
    const paymentSection = document.getElementById('payment-method-section');

    const btnToPayment = document.getElementById('btn-to-payment');
    const btnBackToShipping = document.getElementById('btn-back-to-shipping');
    const btnCompleteOrder = document.getElementById('btn-complete-order');

    const breadcrumbBackToShipping = document.getElementById('breadcrumb-back-to-shipping');
    const changeContactLink = document.getElementById('change-shipping-info-contact');
    const changeAddressLink = document.getElementById('change-shipping-info-address');

    // Review elements
    const reviewEmail = document.getElementById('review-email');
    const reviewAddress = document.getElementById('review-address');
    const reviewNotesRow = document.getElementById('review-notes-row');
    const reviewShippingNotes = document.getElementById('review-shipping-notes');

    // Billing address form elements
    const billingAddressRadios = document.querySelectorAll('input[name="billingAddressOption"]');
    const differentBillingForm = document.getElementById('different-billing-address-form');

    // Payment Options
    const paymentOptions = document.querySelectorAll('.payment-option');
    const paymentOptionDetails = document.querySelectorAll('.payment-option-details');

    // Form fields (shipping) - IDs for input text fields
    const fullNameInput = document.getElementById('fullName');
    const emailInput = document.getElementById('email');
    const phoneInput = document.getElementById('phone');
    const addressInput = document.getElementById('address');
    const provinceInput = document.getElementById('province');
    const districtInput = document.getElementById('district');
    const wardInput = document.getElementById('ward');
    const shippingNotesInput = document.getElementById('shippingNotes');

    // Form fields (billing) - IDs for input text fields
    const billingFullNameInput = document.getElementById('billingFullName');
    const billingAddressInput = document.getElementById('billingAddress');
    const billingProvinceInput = document.getElementById('billingProvince');
    const billingDistrictInput = document.getElementById('billingDistrict');
    const billingWardInput = document.getElementById('billingWard');
    const billingPhoneInput = document.getElementById('billingPhone');


    // --- Step Navigation ---
    function showShippingStep() {
    shippingSection.classList.remove('hidden');
    paymentSection.classList.add('hidden');
}

    function showPaymentStep() {
    // Populate review box
    reviewEmail.textContent = emailInput.value || 'N/A';

    const fullAddress = [
    fullNameInput.value,
    addressInput.value,
    wardInput.value,
    districtInput.value,
    provinceInput.value
    ].filter(Boolean).join(', ');
    reviewAddress.textContent = fullAddress || 'N/A';

    if (shippingNotesInput.value.trim() !== "") {
    reviewShippingNotes.textContent = shippingNotesInput.value;
    reviewNotesRow.style.display = 'flex';
} else {
    reviewNotesRow.style.display = 'none';
}

    shippingSection.classList.add('hidden');
    paymentSection.classList.remove('hidden');
}

    shippingForm.addEventListener('submit', function (event) {
    event.preventDefault();
    if (shippingForm.checkValidity()) {
    showPaymentStep();
    document.getElementById('shipping-fee-display').textContent = "30,000₫";
    document.getElementById('total-price-display').textContent = "1,439,000₫";
} else {
    shippingForm.reportValidity();
}
});

    btnBackToShipping.addEventListener('click', function (event) {
    event.preventDefault();
    showShippingStep();
});
    breadcrumbBackToShipping.addEventListener('click', function (event) {
    event.preventDefault();
    showShippingStep();
});
    changeContactLink.addEventListener('click', function (e) {
    e.preventDefault();
    showShippingStep();
    emailInput.focus();
});
    changeAddressLink.addEventListener('click', function (e) {
    e.preventDefault();
    showShippingStep();
    addressInput.focus();
});

    paymentForm.addEventListener('submit', function (event) {
    event.preventDefault();
    if (paymentForm.checkValidity()) {
    const shippingData = {
    fullName: fullNameInput.value,
    email: emailInput.value,
    phone: phoneInput.value,
    address: addressInput.value,
    province: provinceInput.value,
    district: districtInput.value,
    ward: wardInput.value,
    notes: shippingNotesInput.value
};

    const selectedPaymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
    const selectedBillingOption = document.querySelector('input[name="billingAddressOption"]:checked').value;

    let billingData = {};
    if (selectedBillingOption === 'different_billing') {
    billingData = {
    fullName: billingFullNameInput.value,
    address: billingAddressInput.value,
    province: billingProvinceInput.value,
    district: billingDistrictInput.value,
    ward: billingWardInput.value,
    phone: billingPhoneInput.value,
};
    // Basic validation for billing form if visible
    const billingFormFields = Array.from(differentBillingForm.querySelectorAll('input[required], select[required]')); // select[required] won't match now
    let isBillingFormValid = true;
    for (const field of billingFormFields) {
    if (!field.value && field.hasAttribute('required')) {
    isBillingFormValid = false;
    break;
}
}
    if (!isBillingFormValid) {
    alert("Vui lòng điền đầy đủ thông tin địa chỉ thanh toán.");
    billingFormFields.find(f => f.hasAttribute('required') && !f.value)?.focus();
    return;
}
} else {
    billingData = "Same as shipping";
}

    const orderData = {
    shipping: shippingData,
    paymentMethod: selectedPaymentMethod,
    billing: billingData,
};

    console.log("Order Data:", orderData);
    alert('Đơn hàng đã được đặt thành công! (Kiểm tra console để xem dữ liệu)');
} else {
    paymentForm.reportValidity();
}
});

    // --- Billing Address Logic ---
    billingAddressRadios.forEach(radio => {
    radio.addEventListener('change', function () {
    const isDifferent = this.value === 'different_billing';
    differentBillingForm.classList.toggle('hidden', !isDifferent);
    // Set 'required' attribute for inputs in the billing form if it's shown
    Array.from(differentBillingForm.querySelectorAll('input[type="text"], input[type="tel"]')).forEach(el => {
    // Only set required for the main fields, not necessarily all of them unless specified
    if (['billingFullName', 'billingAddress', 'billingProvince', 'billingDistrict', 'billingWard', 'billingPhone'].includes(el.id)) {
    el.required = isDifferent;
}
});
});
});
    // Initialize billing form state based on checked radio
    const initiallyDifferentBilling = document.querySelector('input[name="billingAddressOption"]:checked').value === 'different_billing';
    differentBillingForm.classList.toggle('hidden', !initiallyDifferentBilling);
    Array.from(differentBillingForm.querySelectorAll('input[type="text"], input[type="tel"]')).forEach(el => {
    if (['billingFullName', 'billingAddress', 'billingProvince', 'billingDistrict', 'billingWard', 'billingPhone'].includes(el.id)) {
    el.required = initiallyDifferentBilling;
}
});

    // --- Payment Option Selection & Details ---
    paymentOptions.forEach(option => {
    option.addEventListener('click', function () {
    paymentOptions.forEach(opt => {
    opt.classList.remove('selected');
    opt.querySelector('input[type="radio"]').checked = false;
});
    paymentOptionDetails.forEach(detail => detail.classList.add('hidden'));

    this.classList.add('selected');
    this.querySelector('input[type="radio"]').checked = true;

    const detailsFor = this.dataset.value;
    const detailToShow = document.querySelector(`.payment-option-details[data-details-for="${detailsFor}"]`);
    if (detailToShow) {
    detailToShow.classList.remove('hidden');
}
});
});
    const initiallyCheckedPayment = document.querySelector('.payment-option input[type="radio"]:checked');
    if (initiallyCheckedPayment) {
    const parentOption = initiallyCheckedPayment.closest('.payment-option');
    parentOption.classList.add('selected');
    const detailsFor = parentOption.dataset.value;
    const detailToShow = document.querySelector(`.payment-option-details[data-details-for="${detailsFor}"]`);
    if (detailToShow) {
    detailToShow.classList.remove('hidden');
}
}
});
    // --- GOOGLE MAPS INTEGRATION ---
    let map;
    let marker;
    let autocomplete;
    let geocoder;

    const googleMapsSearchInput = document.getElementById('google-maps-address-search');
    const mapDiv = document.getElementById('map');
    const btnUseManualAddress = document.getElementById('btn-use-manual-address');

    // Các trường form địa chỉ thủ công
    const manualAddressInput = document.getElementById('address');
    const manualProvinceInput = document.getElementById('province');
    const manualDistrictInput = document.getElementById('district');
    const manualWardInput = document.getElementById('ward');

    // Nút chuyển sang nhập thủ công (nếu cần)
    if (btnUseManualAddress) {
        btnUseManualAddress.addEventListener('click', function() {
            mapDiv.style.display = 'none';
            googleMapsSearchInput.style.display = 'none';
            this.style.display = 'none';

            manualAddressInput.style.display = 'block';
        });
    }