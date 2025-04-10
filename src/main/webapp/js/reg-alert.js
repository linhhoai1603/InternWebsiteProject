// document.addEventListener('DOMContentLoaded', function () {
//     // Get form elements
//     const form = document.getElementById('registrationForm');
//     const emailInput = document.getElementById('email');
//     const firstNameInput = document.getElementById('firstName');
//     const lastNameInput = document.getElementById('lastname'); // Keep variable name consistent
//     const phoneNumberInput = document.getElementById('phoneNumber');
//     const usernameInput = document.getElementById('username');
//     const passwordInput = document.getElementById('password');
//
//     // Get error display elements
//     const emailError = document.getElementById('emailError');
//     const firstNameError = document.getElementById('firstNameError');
//     const lastNameError = document.getElementById('lastnameError'); // Keep variable name consistent
//     const phoneNumberError = document.getElementById('phoneNumberError');
//     const usernameError = document.getElementById('usernameError');
//     const passwordError = document.getElementById('passwordError');
//
//     // Regular expressions
//     const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
//     const phoneRegex = /^[+]?[\d\s-]{8,}$/; // Min 8 digits, allows +, space, hyphen
//     const uppercaseRegex = /[A-Z]/;
//     const lowercaseRegex = /[a-z]/;
//     const digitRegex = /\d/;
//     const specialCharRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
//
//     // --- Helper Functions ---
//     function showError(inputElement, errorElement, message) {
//         if (errorElement) { // Check if errorElement exists
//             errorElement.textContent = message;
//             errorElement.classList.add('d-block');
//         }
//         if (inputElement) { // Check if inputElement exists
//             inputElement.classList.add('is-invalid');
//         }
//     }
//
//     function clearError(inputElement, errorElement) {
//         if (errorElement) {
//             errorElement.textContent = '';
//             errorElement.classList.remove('d-block');
//         }
//         if (inputElement) {
//             inputElement.classList.remove('is-invalid');
//         }
//     }
//
//     // --- Asynchronous Check Function ---
//     async function checkDuplicate(field, value) {
//         // Basic check before sending request
//         if (!value) return false; // Don't check empty values here
//
//         try {
//             console.log(`Sending request to check ${field}: ${value}`);
//             const response = await fetch('/CheckDuplicate', { // Ensure this endpoint is correct
//                 method: 'POST',
//                 headers: { 'Content-Type': 'application/json' },
//                 body: JSON.stringify({ field, value })
//             });
//
//             if (!response.ok) {
//                 // Try to get error message from server if available
//                 let errorMsg = `HTTP error! status: ${response.status}`;
//                 try {
//                     const errorData = await response.json();
//                     if(errorData && errorData.message) errorMsg = errorData.message;
//                 } catch (e) { /* Ignore if response body isn't JSON */ }
//                 throw new Error(errorMsg);
//             }
//
//             const data = await response.json();
//             console.log('Server response:', data);
//             return data.exists; // Expecting { "exists": true/false }
//         } catch (error) {
//             console.error(`Check duplicate failed for ${field}:`, error);
//             // Re-throw a more specific error or handle it
//             throw new Error(`Could not verify ${field}. Please try again.`);
//         }
//     }
//
//     // --- Validation Logic Functions ---
//
//     // Validate simple required field
//     function validateRequired(input, errorEl, fieldName) {
//         clearError(input, errorEl);
//         if (input.value.trim() === '') {
//             showError(input, errorEl, `${fieldName} is required.`);
//             return false;
//         }
//         return true;
//     }
//
//     // Validate Password Complexity
//     function validatePassword() {
//         clearError(passwordInput, passwordError);
//         const passwordValue = passwordInput.value; // Don't trim password
//         let isValid = true;
//
//         if (passwordValue === '') {
//             showError(passwordInput, passwordError, 'Password is required.');
//             isValid = false;
//         } else if (passwordValue.length < 8) {
//             showError(passwordInput, passwordError, 'Password must be at least 8 characters long.');
//             isValid = false;
//         } else if (!lowercaseRegex.test(passwordValue)) {
//             showError(passwordInput, passwordError, 'Password must contain at least one lowercase letter.');
//             isValid = false;
//         } else if (!uppercaseRegex.test(passwordValue)) { // Added Uppercase Check
//             showError(passwordInput, passwordError, 'Password must contain at least one uppercase letter.');
//             isValid = false;
//         } else if (!digitRegex.test(passwordValue)) {
//             showError(passwordInput, passwordError, 'Password must contain at least one number.');
//             isValid = false;
//         } else if (!specialCharRegex.test(passwordValue)) {
//             showError(passwordInput, passwordError, 'Password must contain at least one special character.');
//             isValid = false;
//         }
//         return isValid;
//     }
//
//     // Validate Phone Number
//     function validatePhoneNumber() {
//         clearError(phoneNumberInput, phoneNumberError);
//         const phoneValue = phoneNumberInput.value.trim();
//         if (phoneValue === '') {
//             showError(phoneNumberInput, phoneNumberError, 'Phone Number is required.');
//             return false;
//         } else if (!phoneRegex.test(phoneValue)) {
//             showError(phoneNumberInput, phoneNumberError, 'Please enter a valid phone number (at least 8 digits).');
//             return false;
//         }
//         return true;
//     }
//
//
//     // Validate Username (including async check)
//     async function validateUsername() {
//         clearError(usernameInput, usernameError);
//         const usernameValue = usernameInput.value.trim();
//         if (usernameValue === '') {
//             showError(usernameInput, usernameError, 'Username is required.');
//             return false;
//         } else if (usernameValue.length < 4) {
//             showError(usernameInput, usernameError, 'Username must be at least 4 characters.');
//             return false;
//         }
//         // Only check duplicate if basic sync validation passes
//         try {
//             const isDuplicate = await checkDuplicate('username', usernameValue);
//             if (isDuplicate) {
//                 showError(usernameInput, usernameError, 'Username already exists.');
//                 return false;
//             }
//         } catch (error) {
//             // Show the error from checkDuplicate (e.g., network issue)
//             showError(usernameInput, usernameError, error.message || 'Could not validate username.');
//             return false;
//         }
//         return true; // Valid if no errors and not a duplicate
//     }
//
//     // Validate Email (including async check)
//     async function validateEmail() {
//         clearError(emailInput, emailError);
//         const emailValue = emailInput.value.trim();
//
//         if (emailValue === '') {
//             showError(emailInput, emailError, 'Email is required.');
//             return false;
//         } else if (!emailRegex.test(emailValue)) {
//             showError(emailInput, emailError, 'Please enter a valid email address.');
//             return false;
//         }
//         // Only check duplicate if basic sync validation passes
//         try {
//             const isDuplicate = await checkDuplicate('email', emailValue);
//             if (isDuplicate) {
//                 showError(emailInput, emailError, 'Email already exists.');
//                 return false;
//             }
//         } catch (error) {
//             // Show the error from checkDuplicate (e.g., network issue)
//             showError(emailInput, emailError, error.message || 'Could not validate email.');
//             return false;
//         }
//         return true; // Valid if no errors and not a duplicate
//     }
//
//
//     // --- SINGLE Submit Event Listener ---
//     form.addEventListener('submit', async function (event) {
//         event.preventDefault(); // Prevent submission initially
//
//         let isSyncValid = true; // Track sync validation results
//
//         // --- Run Synchronous Validations ---
//         isSyncValid = validateRequired(firstNameInput, firstNameError, 'First Name') && isSyncValid;
//         isSyncValid = validateRequired(lastNameInput, lastNameError, 'Last Name') && isSyncValid;
//         isSyncValid = validatePhoneNumber() && isSyncValid;
//         isSyncValid = validatePassword() && isSyncValid;
//         // Note: Basic required/format checks for username/email happen within their async functions
//
//         // If any synchronous validation failed, stop here
//         if (!isSyncValid) {
//             console.log("Synchronous validation failed.");
//             return;
//         }
//
//         // --- Run Asynchronous Validations (Only if Sync passed) ---
//         console.log("Running asynchronous validations...");
//         try {
//             // Use Promise.all to run checks concurrently
//             const [isUsernameValid, isEmailValid] = await Promise.all([
//                 validateUsername(),
//                 validateEmail()
//             ]);
//
//             // Check results of async validations
//             if (isUsernameValid && isEmailValid) {
//                 console.log("All validations passed. Submitting form.");
//                 // ALL VALID: Allow the form to submit
//                 form.submit();
//             } else {
//                 console.log("Asynchronous validation failed.");
//                 // An error message should already be displayed by the specific validation function
//             }
//         } catch (error) {
//             // This catch is for errors *during* the Promise.all execution itself,
//             // though individual errors are caught within validateUsername/validateEmail.
//             console.error("Error during async validation execution:", error);
//             // Optionally show a generic form error message here
//             // e.g., showError(null, someGeneralErrorDiv, 'Validation could not be completed. Please try again.');
//         }
//     });
//
//     // Optional: Add real-time validation on input blur
//     // setupInputValidation(emailInput, emailError, validateEmail); // Note: This would trigger AJAX on blur
//     // setupInputValidation(usernameInput, usernameError, validateUsername); // Note: This would trigger AJAX on blur
//     // setupInputValidation(passwordInput, passwordError, validatePassword);
//     // ... add for other fields if needed using the validation functions ...
//
//     // Example setup function (if you uncomment the above lines)
//     function setupInputValidation(input, errorDiv, validationFn) {
//         input.addEventListener('blur', async () => { // Make it async if validationFn can be async
//             await validationFn(); // Run the specific validation on blur
//         });
//     }
//     // You might want debouncing for AJAX calls on blur/input to avoid excessive requests
//
// });

// js/registrationValidation.js
import { checkEmailExists, checkUsernameExists } from './duplicateChecker.js'; // Import hàm cần thiết

document.addEventListener('DOMContentLoaded', function () {
    // Get form elements
    const form = document.getElementById('registrationForm');
    const emailInput = document.getElementById('email');
    const firstNameInput = document.getElementById('firstName');
    const lastNameInput = document.getElementById('lastname');
    const phoneNumberInput = document.getElementById('phoneNumber');
    const usernameInput = document.getElementById('username');
    const passwordInput = document.getElementById('password');

    // Get error display elements
    const emailError = document.getElementById('emailError');
    const firstNameError = document.getElementById('firstNameError');
    const lastNameError = document.getElementById('lastnameError');
    const phoneNumberError = document.getElementById('phoneNumberError');
    const usernameError = document.getElementById('usernameError');
    const passwordError = document.getElementById('passwordError');

    // Regular expressions
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phoneRegex = /^[+]?[\d\s-]{8,}$/;
    const uppercaseRegex = /[A-Z]/;
    const lowercaseRegex = /[a-z]/;
    const digitRegex = /\d/;
    const specialCharRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;

    // --- Helper Functions ---
    function showError(inputElement, errorElement, message) {
        if (errorElement) {
            errorElement.textContent = message;
            errorElement.classList.add('d-block'); // Assuming Bootstrap classes
        }
        if (inputElement) {
            inputElement.classList.add('is-invalid'); // Assuming Bootstrap classes
        }
    }

    function clearError(inputElement, errorElement) {
        if (errorElement) {
            errorElement.textContent = '';
            errorElement.classList.remove('d-block');
        }
        if (inputElement) {
            inputElement.classList.remove('is-invalid');
        }
    }

    // --- KHÔNG CẦN HÀM checkDuplicate Ở ĐÂY NỮA ---
    // async function checkDuplicate(field, value) { ... } // ĐÃ CHUYỂN SANG FILE KHÁC

    // --- Validation Logic Functions ---

    function validateRequired(input, errorEl, fieldName) {
        clearError(input, errorEl);
        if (input.value.trim() === '') {
            showError(input, errorEl, `${fieldName} là bắt buộc.`);
            return false;
        }
        return true;
    }

    function validatePassword() {
        clearError(passwordInput, passwordError);
        const passwordValue = passwordInput.value;
        let isValid = true;
        const messages = [];

        if (passwordValue === '') {
            messages.push('Mật khẩu là bắt buộc.');
            isValid = false;
        } else {
            if (passwordValue.length < 8) messages.push('Ít nhất 8 ký tự.');
            if (!lowercaseRegex.test(passwordValue)) messages.push('Ít nhất 1 chữ thường.');
            if (!uppercaseRegex.test(passwordValue)) messages.push('Ít nhất 1 chữ HOA.');
            if (!digitRegex.test(passwordValue)) messages.push('Ít nhất 1 chữ số.');
            if (!specialCharRegex.test(passwordValue)) messages.push('Ít nhất 1 ký tự đặc biệt.');
        }

        if (messages.length > 0) {
            // Hiển thị tất cả lỗi hoặc chỉ lỗi đầu tiên tùy ý
            showError(passwordInput, passwordError, 'Mật khẩu phải chứa: ' + messages.join(' '));
            isValid = false;
        }
        return isValid;
    }

    function validatePhoneNumber() {
        clearError(phoneNumberInput, phoneNumberError);
        const phoneValue = phoneNumberInput.value.trim();
        if (phoneValue === '') {
            showError(phoneNumberInput, phoneNumberError, 'Số điện thoại là bắt buộc.');
            return false;
        } else if (!phoneRegex.test(phoneValue)) {
            showError(phoneNumberInput, phoneNumberError, 'Nhập số điện thoại hợp lệ (ít nhất 8 chữ số).');
            return false;
        }
        return true;
    }

    // Validate Username (including async check using imported function)
    async function validateUsername() {
        clearError(usernameInput, usernameError);
        const usernameValue = usernameInput.value.trim();

        // Basic synchronous checks first
        if (usernameValue === '') {
            showError(usernameInput, usernameError, 'Username là bắt buộc.');
            return false;
        } else if (usernameValue.length < 4) {
            showError(usernameInput, usernameError, 'Username phải có ít nhất 4 ký tự.');
            return false;
        }

        // If basic checks pass, perform the asynchronous duplicate check
        try {
            // --> SỬ DỤNG HÀM ĐÃ IMPORT <--
            const isDuplicate = await checkUsernameExists(usernameValue);
            if (isDuplicate) {
                showError(usernameInput, usernameError, 'Username này đã tồn tại.');
                return false; // Username không hợp lệ vì trùng lặp
            }
        } catch (error) {
            // Hiển thị lỗi trả về từ checkUsernameExists (lỗi mạng, lỗi server...)
            console.error("Error validating username:", error);
            showError(usernameInput, usernameError, error.message || 'Không thể kiểm tra username.');
            return false; // Coi như không hợp lệ nếu không kiểm tra được
        }

        // Nếu không có lỗi đồng bộ và không trùng lặp
        return true; // Username hợp lệ
    }

    // Validate Email (including async check using imported function)
    async function validateEmail() {
        clearError(emailInput, emailError);
        const emailValue = emailInput.value.trim();

        // Basic synchronous checks first
        if (emailValue === '') {
            showError(emailInput, emailError, 'Email là bắt buộc.');
            return false;
        } else if (!emailRegex.test(emailValue)) {
            showError(emailInput, emailError, 'Nhập địa chỉ email hợp lệ.');
            return false;
        }

        // If basic checks pass, perform the asynchronous duplicate check
        try {
            // --> SỬ DỤNG HÀM ĐÃ IMPORT <--
            const isDuplicate = await checkEmailExists(emailValue);
            if (isDuplicate) {
                showError(emailInput, emailError, 'Email này đã tồn tại.');
                return false; // Email không hợp lệ vì trùng lặp
            }
        } catch (error) {
            // Hiển thị lỗi trả về từ checkEmailExists
            console.error("Error validating email:", error);
            showError(emailInput, emailError, error.message || 'Không thể kiểm tra email.');
            return false; // Coi như không hợp lệ nếu không kiểm tra được
        }

        // Nếu không có lỗi đồng bộ và không trùng lặp
        return true; // Email hợp lệ
    }


    // --- SINGLE Submit Event Listener ---
    form.addEventListener('submit', async function (event) {
        event.preventDefault(); // Ngăn chặn submit mặc định

        // Reset trạng thái lỗi trước khi validate lại toàn bộ
        clearError(firstNameInput, firstNameError);
        clearError(lastNameInput, lastNameError);
        clearError(phoneNumberInput, phoneNumberError);
        clearError(passwordInput, passwordError);
        clearError(usernameInput, usernameError);
        clearError(emailInput, emailError);

        let isSyncValid = true;

        // --- Chạy các validation đồng bộ ---
        isSyncValid = validateRequired(firstNameInput, firstNameError, 'Tên') && isSyncValid;
        isSyncValid = validateRequired(lastNameInput, lastNameError, 'Họ') && isSyncValid;
        isSyncValid = validatePhoneNumber() && isSyncValid;
        isSyncValid = validatePassword() && isSyncValid;
        // Validation cơ bản cho username/email (như rỗng, định dạng) sẽ được chạy bên trong hàm async

        // Nếu có lỗi đồng bộ, dừng lại
        if (!isSyncValid) {
            console.log("Validation đồng bộ thất bại.");
            // Focus vào trường lỗi đầu tiên (tùy chọn)
            const firstInvalid = form.querySelector('.is-invalid');
            if(firstInvalid) firstInvalid.focus();
            return;
        }

        // --- Chạy các validation bất đồng bộ (chỉ khi đồng bộ đã pass) ---
        console.log("Đang chạy validation bất đồng bộ...");
        let isAsyncValid = false; // Giả sử là không hợp lệ ban đầu
        try {
            // Chạy song song kiểm tra username và email
            const [usernameCheckResult, emailCheckResult] = await Promise.all([
                validateUsername(), // Hàm này đã bao gồm cả check đồng bộ và bất đồng bộ
                validateEmail()     // Hàm này đã bao gồm cả check đồng bộ và bất đồng bộ
            ]);

            // Chỉ hợp lệ nếu CẢ HAI đều trả về true
            isAsyncValid = usernameCheckResult && emailCheckResult;

            if (isAsyncValid) {
                console.log("Tất cả validation thành công. Đang gửi form...");
                // TẤT CẢ HỢP LỆ: Cho phép form submit
                form.submit(); // Gửi form đi thật
            } else {
                console.log("Validation bất đồng bộ thất bại.");
                // Focus vào trường lỗi đầu tiên (tùy chọn)
                const firstInvalid = form.querySelector('.is-invalid');
                if(firstInvalid) firstInvalid.focus();
                // Thông báo lỗi đã được hiển thị bởi các hàm validateUsername/validateEmail
            }
        } catch (error) {
            // Lỗi này xảy ra nếu Promise.all bị reject (ít khả năng vì lỗi đã được catch bên trong validate...)
            // Hoặc nếu có lỗi không mong muốn khác trong khối try
            console.error("Lỗi trong quá trình thực thi validation bất đồng bộ:", error);
            // Có thể hiển thị một thông báo lỗi chung ở đây
            showError(null, form.querySelector('#generalError'), 'Không thể hoàn tất kiểm tra. Vui lòng thử lại.'); // Cần thêm <div id="generalError"></div> vào HTML
        }
    });

    // Optional: Real-time validation on blur (Thêm nếu cần)
    function setupInputValidation(input, validationFn) {
        input.addEventListener('blur', async () => {
            await validationFn(); // Chạy validation tương ứng khi rời khỏi input
        });
    }

    setupInputValidation(emailInput, validateEmail); // Validate email khi blur
    setupInputValidation(usernameInput, validateUsername); // Validate username khi blur
    setupInputValidation(passwordInput, validatePassword); // Validate password khi blur
    setupInputValidation(phoneNumberInput, validatePhoneNumber); // Validate phone khi blur
    setupInputValidation(firstNameInput, () => validateRequired(firstNameInput, firstNameError, 'Tên'));
    setupInputValidation(lastNameInput, () => validateRequired(lastNameInput, lastNameError, 'Họ'));

});