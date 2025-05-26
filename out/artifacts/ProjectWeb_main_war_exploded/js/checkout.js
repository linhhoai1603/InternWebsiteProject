console.log("checkout.js loaded!");
document.addEventListener('DOMContentLoaded', function () {
    console.log("DOMContentLoaded event fired!");
    const shippingForm = document.getElementById('shipping-form');
    const paymentForm = document.getElementById('payment-form');

    const shippingSection = document.getElementById('shipping-info-section');
    const paymentSection = document.getElementById('payment-method-section');

    const btnToPayment = document.getElementById('btn-to-payment');
    // Nút "Quay lại thông tin giao hàng" trong footer của payment-form
    const btnBackToShippingFooter = document.getElementById('btn-back-to-shipping'); // ID từ HTML của bạn
    const btnCompleteOrder = document.getElementById('btn-complete-order');

    const breadcrumbBackToShippingLink = document.getElementById('breadcrumb-back-to-shipping');
    const changeContactLink = document.getElementById('change-shipping-info-contact');
    const changeAddressLink = document.getElementById('change-shipping-info-address');

    const reviewEmail = document.getElementById('review-email');
    const reviewAddress = document.getElementById('review-address');
    const reviewNotesRow = document.getElementById('review-notes-row');
    const reviewShippingNotes = document.getElementById('review-shipping-notes');

    const fullNameInput = document.getElementById('fullName');
    const emailInput = document.getElementById('email');
    const phoneInput = document.getElementById('phone');
    const addressInput = document.getElementById('address');
    const provinceInput = document.getElementById('province');
    const districtInput = document.getElementById('district');
    const wardInput = document.getElementById('ward');
    const shippingNotesInput = document.getElementById('shippingNotes');

    const differentBillingForm = document.getElementById('different-billing-address-form');
    let billingInputs = [];
    if (differentBillingForm) {
        billingInputs = differentBillingForm.querySelectorAll('input[type="text"], input[type="tel"]');
    }

    const hiddenShippingFullName = document.getElementById('shippingFullNameHidden');
    // const hiddenShippingEmail = document.getElementById('shippingEmailHidden'); // Bỏ qua nếu không có trong HTML
    const hiddenShippingPhone = document.getElementById('shippingPhoneHidden');
    const hiddenShippingAddressDetail = document.getElementById('shippingDetailHidden');
    const hiddenShippingProvince = document.getElementById('shippingProvinceHidden');
    const hiddenShippingDistrict = document.getElementById('shippingDistrictHidden');
    const hiddenShippingWard = document.getElementById('shippingWardHidden');
    const hiddenShippingNotes = document.getElementById('shippingNotesHidden');

    const billingAddressRadios = document.querySelectorAll('input[name="SameOtherAddress"]');

    const paymentOptionsRadios = document.querySelectorAll('#payment-form input[name="payment"]');
    const paymentOptionDivs = document.querySelectorAll('#payment-form .payment-option');
    const paymentOptionDetails = document.querySelectorAll('#payment-form .payment-option-details');

    function showShippingStep() {
        if (shippingSection) shippingSection.classList.remove('hidden');
        if (paymentSection) paymentSection.classList.add('hidden');
        window.scrollTo(0, 0);
    }

    function updateReviewBoxAndHiddenFields() {
        console.log("updateReviewBoxAndHiddenFields CALLED!");
        console.log("addressInput value:", addressInput ? addressInput.value : 'addressInput not found');
        console.log("provinceInput value:", provinceInput ? provinceInput.value : 'provinceInput not found');
        console.log("districtInput value:", districtInput ? districtInput.value : 'districtInput not found');
        console.log("wardInput value:", wardInput ? wardInput.value : 'wardInput not found');
        if (reviewEmail && emailInput) reviewEmail.textContent = emailInput.value || 'N/A';
        const fullAddressDisplayParts = [addressInput?.value, wardInput?.value, districtInput?.value, provinceInput?.value].filter(Boolean).join(', ');
        if (reviewAddress) reviewAddress.textContent = fullAddressDisplayParts || 'N/A';

        if (reviewShippingNotes && reviewNotesRow && shippingNotesInput) {
            if (shippingNotesInput.value.trim() !== "") {
                reviewShippingNotes.textContent = shippingNotesInput.value;
                reviewNotesRow.style.display = 'flex';
            } else {
                reviewNotesRow.style.display = 'none';
            }
        }

        if (hiddenShippingFullName && fullNameInput) hiddenShippingFullName.value = fullNameInput.value;
        //if (hiddenShippingEmail && emailInput) hiddenShippingEmail.value = emailInput.value;
        if (hiddenShippingPhone && phoneInput) hiddenShippingPhone.value = phoneInput.value;
        if (hiddenShippingAddressDetail && addressInput) hiddenShippingAddressDetail.value = addressInput.value;
        if (hiddenShippingProvince && provinceInput) hiddenShippingProvince.value = provinceInput.value;
        if (hiddenShippingDistrict && districtInput) hiddenShippingDistrict.value = districtInput.value;
        if (hiddenShippingWard && wardInput) hiddenShippingWard.value = wardInput.value;
        if (hiddenShippingNotes && shippingNotesInput) hiddenShippingNotes.value = shippingNotesInput.value;

        console.log("hiddenShippingDetailHidden value set to:", hiddenShippingAddressDetail ? hiddenShippingAddressDetail.value : 'hidden field not found');
        console.log("hiddenShippingProvinceHidden value set to:", hiddenShippingProvince ? hiddenShippingProvince.value : 'hidden field not found');
    }

    function showPaymentStep() {
        updateReviewBoxAndHiddenFields();
        if (shippingSection) shippingSection.classList.add('hidden');
        if (paymentSection) paymentSection.classList.remove('hidden');
        window.scrollTo(0, 0);
    }

    // Hàm xử lý submit của shippingForm
    const shippingFormSubmitHandler = function (event) {
        event.preventDefault();
        if (shippingForm.checkValidity()) {
            sessionStorage.setItem('shippingFormValid', 'true');
            showPaymentStep(); // Gọi hàm showPaymentStep đã có updateReviewBoxAndHiddenFields
        } else {
            sessionStorage.setItem('shippingFormValid', 'false');
            shippingForm.reportValidity();
        }
    };

    if (shippingForm && btnToPayment) {
        shippingForm.removeEventListener('submit', shippingFormSubmitHandler); // Xóa listener cũ nếu có
        shippingForm.addEventListener('submit', shippingFormSubmitHandler);
    }

    if (btnBackToShippingFooter) {
        btnBackToShippingFooter.addEventListener('click', function (event) {
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

    if (changeContactLink && (emailInput || fullNameInput)) {
        changeContactLink.addEventListener('click', function (e) {
            e.preventDefault();
            showShippingStep();
            if (fullNameInput) fullNameInput.focus();
            else if (emailInput) emailInput.focus();
        });
    }
    if (changeAddressLink && addressInput) {
        changeAddressLink.addEventListener('click', function (e) {
            e.preventDefault();
            showShippingStep();
            addressInput.focus();
        });
    }

    function handleBillingAddressSelection() {
        const selectedBillingOption = document.querySelector('input[name="SameOtherAddress"]:checked');
        if (differentBillingForm && selectedBillingOption) {
            const isDifferent = selectedBillingOption.value === 'different_billing';
            differentBillingForm.classList.toggle('hidden', !isDifferent);
            billingInputs.forEach(input => {
                input.disabled = !isDifferent;
                input.required = isDifferent;
                if (!isDifferent) {
                    input.value = '';
                }
            });
            if (isDifferent && billingInputs.length > 0) {
                // billingInputs[0].focus(); // Tạm thời comment out để tránh lỗi nếu billingInputs[0] không tồn tại
            }
        }
    }

    if (billingAddressRadios.length > 0) {
        billingAddressRadios.forEach(radio => {
            radio.addEventListener('change', handleBillingAddressSelection);
        });
        handleBillingAddressSelection();
    }

    if (paymentOptionsRadios.length > 0) {
        paymentOptionsRadios.forEach(radio => {
            radio.addEventListener('change', function () {
                paymentOptionDetails.forEach(detail => detail.classList.add('hidden'));
                paymentOptionDivs.forEach(div => div.classList.remove('selected'));
                if (this.checked) {
                    const parentOptionDiv = this.closest('.payment-option');
                    if (parentOptionDiv) {
                        parentOptionDiv.classList.add('selected');
                        const detailsFor = parentOptionDiv.dataset.value;
                        const detailToShow = document.querySelector(`.payment-option-details[data-details-for="${detailsFor}"]`);
                        if (detailToShow) {
                            detailToShow.classList.remove('hidden');
                        }
                    }
                }
            });
        });
        const initiallyCheckedPaymentRadio = document.querySelector('#payment-form input[name="payment"]:checked');
        if (initiallyCheckedPaymentRadio) {
            initiallyCheckedPaymentRadio.dispatchEvent(new Event('change'));
        }
    }

    if (paymentForm) {
        paymentForm.addEventListener('submit', function (event) {
            updateReviewBoxAndHiddenFields(); // Cập nhật lần cuối trước khi submit

            const selectedBillingOption = document.querySelector('input[name="SameOtherAddress"]:checked');
            if (selectedBillingOption && selectedBillingOption.value === 'different_billing') {
                let isBillingFormValid = true;
                billingInputs.forEach(input => {
                    if (input.required && !input.value.trim()) {
                        isBillingFormValid = false;
                    }
                });
                if (!isBillingFormValid) {
                    event.preventDefault();
                    alert('Vui lòng điền đầy đủ các trường bắt buộc cho địa chỉ thanh toán.');
                    const firstInvalidBillingInput = Array.from(billingInputs).find(input => input.required && !input.value.trim());
                    if (firstInvalidBillingInput) {
                        firstInvalidBillingInput.focus();
                    }
                    return;
                }
            }

            const selectedPaymentMethod = document.querySelector('input[name="payment"]:checked');
            if (!selectedPaymentMethod) {
                event.preventDefault();
                alert('Vui lòng chọn phương thức thanh toán.');
                const paymentOptionsArea = document.querySelector('#payment-form h2');
                if (paymentOptionsArea) {
                    paymentOptionsArea.scrollIntoView({ behavior: 'smooth' });
                }
                return;
            }
        });
    }

    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('step') === 'payment') {
        const shippingFormIsValid = sessionStorage.getItem('shippingFormValid') === 'true';
        if (shippingForm && (shippingForm.checkValidity() || shippingFormIsValid)) { // Kiểm tra cả trạng thái hiện tại và session
            updateReviewBoxAndHiddenFields();
            showPaymentStep();
        } else {
            showShippingStep();
        }
    } else {
        showShippingStep();
    }
});