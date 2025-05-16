document.addEventListener('DOMContentLoaded', function () {
    const shippingForm = document.getElementById('shipping-form');
    const paymentForm = document.getElementById('payment-form'); // Form đặt hàng

    const shippingSection = document.getElementById('shipping-info-section');
    const paymentSection = document.getElementById('payment-method-section');

    const btnToPayment = document.getElementById('btn-to-payment');
    const btnBackToShipping = document.getElementById('btn-back-to-shipping');
    const btnCompleteOrder = document.getElementById('btn-complete-order'); // Nút "Hoàn tất đơn hàng"

    const breadcrumbBackToShippingLink = document.getElementById('breadcrumb-back-to-shipping');
    const changeContactLink = document.getElementById('change-shipping-info-contact');
    const changeAddressLink = document.getElementById('change-shipping-info-address');

    // Review elements
    const reviewEmail = document.getElementById('review-email');
    const reviewAddress = document.getElementById('review-address');
    const reviewNotesRow = document.getElementById('review-notes-row');
    const reviewShippingNotes = document.getElementById('review-shipping-notes');

    // Form fields (shipping)
    const fullNameInput = document.getElementById('fullName');
    const emailInput = document.getElementById('email');
    const phoneInput = document.getElementById('phone');
    const addressInput = document.getElementById('address');
    const provinceInput = document.getElementById('province');
    const districtInput = document.getElementById('district');
    const wardInput = document.getElementById('ward');
    const shippingNotesInput = document.getElementById('shippingNotes');

    // Form fields (billing)
    const billingFullNameInput = document.getElementById('billingFullName');
    const billingAddressInput = document.getElementById('billingAddress');
    const billingProvinceInput = document.getElementById('billingProvince');
    const billingDistrictInput = document.getElementById('billingDistrict');
    const billingWardInput = document.getElementById('billingWard');
    const billingPhoneInput = document.getElementById('billingPhone');

    // Hidden fields for payment form
    const hiddenShippingFullName = document.getElementById('hiddenShippingFullName');
    const hiddenShippingEmail = document.getElementById('hiddenShippingEmail');
    const hiddenShippingPhone = document.getElementById('hiddenShippingPhone');
    const hiddenShippingAddressDetail = document.getElementById('hiddenShippingAddressDetail');
    const hiddenShippingProvince = document.getElementById('hiddenShippingProvince');
    const hiddenShippingDistrict = document.getElementById('hiddenShippingDistrict');
    const hiddenShippingWard = document.getElementById('hiddenShippingWard');
    const hiddenShippingNotes = document.getElementById('hiddenShippingNotes');
    const hiddenPaymentMethodValue = document.getElementById('hiddenPaymentMethodValue');


    // Billing address form elements
    const billingAddressRadios = document.querySelectorAll('input[name="billingAddressOption"]');
    const differentBillingForm = document.getElementById('different-billing-address-form');

    // Payment Options
    const paymentOptions = document.querySelectorAll('.payment-option');
    const paymentOptionDetails = document.querySelectorAll('.payment-option-details');


    // --- Step Navigation ---
    function showShippingStep() {
        if(shippingSection) shippingSection.classList.remove('hidden');
        if(paymentSection) paymentSection.classList.add('hidden');
        window.scrollTo(0, 0);
    }

    function showPaymentStep() {
        // Populate review box with current shipping info
        if (reviewEmail && emailInput) reviewEmail.textContent = emailInput.value || 'N/A';

        const fullAddressParts = [
            fullNameInput?.value,
            addressInput?.value,
            wardInput?.value,
            districtInput?.value,
            provinceInput?.value
        ];
        if (reviewAddress) reviewAddress.textContent = fullAddressParts.filter(Boolean).join(', ') || 'N/A';

        if (reviewShippingNotes && reviewNotesRow && shippingNotesInput) {
            if (shippingNotesInput.value.trim() !== "") {
                reviewShippingNotes.textContent = shippingNotesInput.value;
                reviewNotesRow.style.display = 'flex';
            } else {
                reviewNotesRow.style.display = 'none';
            }
        }

        // Populate hidden fields in payment form
        if(hiddenShippingFullName && fullNameInput) hiddenShippingFullName.value = fullNameInput.value;
        if(hiddenShippingEmail && emailInput) hiddenShippingEmail.value = emailInput.value;
        if(hiddenShippingPhone && phoneInput) hiddenShippingPhone.value = phoneInput.value;
        if(hiddenShippingAddressDetail && addressInput) hiddenShippingAddressDetail.value = addressInput.value;
        if(hiddenShippingProvince && provinceInput) hiddenShippingProvince.value = provinceInput.value;
        if(hiddenShippingDistrict && districtInput) hiddenShippingDistrict.value = districtInput.value;
        if(hiddenShippingWard && wardInput) hiddenShippingWard.value = wardInput.value;
        if(hiddenShippingNotes && shippingNotesInput) hiddenShippingNotes.value = shippingNotesInput.value;

        const selectedPaymentMethodRadio = document.querySelector('input[name="paymentMethod"]:checked');
        if(hiddenPaymentMethodValue && selectedPaymentMethodRadio) hiddenPaymentMethodValue.value = selectedPaymentMethodRadio.value;


        if(shippingSection) shippingSection.classList.add('hidden');
        if(paymentSection) paymentSection.classList.remove('hidden');
        window.scrollTo(0, 0);
    }

    if (shippingForm && btnToPayment) {
        shippingForm.addEventListener('submit', function (event) {
            event.preventDefault();
            if (shippingForm.checkValidity()) {
                showPaymentStep();
            } else {
                shippingForm.reportValidity();
            }
        });
    }

    if (btnBackToShipping) {
        btnBackToShipping.addEventListener('click', function (event) {
            event.preventDefault();
            showShippingStep();
        });
    }
    if (breadcrumbBackToShippingLink) {
        breadcrumbBackToShippingLink.addEventListener('click', function (event) {
            event.preventDefault();
            showShippingStep();
        });
    }

    if (changeContactLink && emailInput) {
        changeContactLink.addEventListener('click', function (e) {
            e.preventDefault();
            showShippingStep();
            emailInput.focus();
        });
    }
    if (changeAddressLink && addressInput) {
        changeAddressLink.addEventListener('click', function (e) {
            e.preventDefault();
            showShippingStep();
            addressInput.focus();
        });
    }

    // --- Billing Address Logic ---
    if (billingAddressRadios.length > 0 && differentBillingForm) {
        billingAddressRadios.forEach(radio => {
            radio.addEventListener('change', function () {
                const isDifferent = this.value === 'different_billing';
                differentBillingForm.classList.toggle('hidden', !isDifferent);
                Array.from(differentBillingForm.querySelectorAll('input[type="text"], input[type="tel"]')).forEach(el => {
                    if (['billingFullName', 'billingAddress', 'billingProvince', 'billingDistrict', 'billingWard', 'billingPhone'].includes(el.id)) {
                        el.required = isDifferent;
                    }
                });
            });
        });
        const initiallyDifferentBilling = document.querySelector('input[name="billingAddressOption"]:checked')?.value === 'different_billing';
        differentBillingForm.classList.toggle('hidden', !initiallyDifferentBilling);
        Array.from(differentBillingForm.querySelectorAll('input[type="text"], input[type="tel"]')).forEach(el => {
            if (['billingFullName', 'billingAddress', 'billingProvince', 'billingDistrict', 'billingWard', 'billingPhone'].includes(el.id)) {
                el.required = initiallyDifferentBilling;
            }
        });
    }

    // --- Payment Option Selection & Details ---
    if (paymentOptions.length > 0) {
        paymentOptions.forEach(option => {
            option.addEventListener('click', function () {
                paymentOptions.forEach(opt => {
                    opt.classList.remove('selected');
                    const radioInside = opt.querySelector('input[type="radio"]');
                    if (radioInside) radioInside.checked = false;
                });
                paymentOptionDetails.forEach(detail => detail.classList.add('hidden'));

                this.classList.add('selected');
                const radioInsideThis = this.querySelector('input[type="radio"]');
                if (radioInsideThis) radioInsideThis.checked = true;

                // Update hidden field for payment method when an option is clicked
                if(hiddenPaymentMethodValue && radioInsideThis) hiddenPaymentMethodValue.value = radioInsideThis.value;


                const detailsFor = this.dataset.value;
                const detailToShow = document.querySelector(`.payment-option-details[data-details-for="${detailsFor}"]`);
                if (detailToShow) {
                    detailToShow.classList.remove('hidden');
                }
            });
        });
        const initiallyCheckedPaymentRadio = document.querySelector('.payment-option input[type="radio"]:checked');
        if (initiallyCheckedPaymentRadio) {
            const parentOption = initiallyCheckedPaymentRadio.closest('.payment-option');
            if (parentOption) {
                parentOption.classList.add('selected');
                const detailsFor = parentOption.dataset.value;
                const detailToShow = document.querySelector(`.payment-option-details[data-details-for="${detailsFor}"]`);
                if (detailToShow) {
                    detailToShow.classList.remove('hidden');
                }
                // Set initial value for hidden payment method
                if(hiddenPaymentMethodValue) hiddenPaymentMethodValue.value = initiallyCheckedPaymentRadio.value;
            }
        }
    }

    // Logic cho việc submit form thanh toán (btnCompleteOrder)
    // Sẽ submit form #payment-form theo cách truyền thống
    // Không cần JavaScript đặc biệt ở đây nếu không có AJAX
    // Đảm bảo form #payment-form có action và method phù hợp.

    // Kiểm tra nếu có tham số step=payment trên URL để hiển thị đúng bước khi trang tải lại (sau khi áp dụng voucher)
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('step') === 'payment') {
        showPaymentStep();
    } else {
        showShippingStep(); // Mặc định hiển thị bước shipping
    }

});