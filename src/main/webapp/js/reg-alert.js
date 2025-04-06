document.addEventListener('DOMContentLoaded', function () {
    // Get form elements
    const form = document.getElementById('registrationForm');
    const emailInput = document.getElementById('email');
    const firstNameInput = document.getElementById('firstName');
    const lastNameInput = document.getElementById('lastname'); // Corrected ID
    const phoneNumberInput = document.getElementById('phoneNumber');
    const passwordInput = document.getElementById('password');

    // Get error display elements
    const emailError = document.getElementById('emailError');
    const firstNameError = document.getElementById('firstNameError');
    const lastNameError = document.getElementById('lastnameError'); // Corrected ID
    const phoneNumberError = document.getElementById('phoneNumberError');
    const passwordError = document.getElementById('passwordError');

    // Regular expression for basic email validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    // Regular expression for phone number (allows digits, optional +, spaces, hyphens) - adjust if needed
    const phoneRegex = /^[+]?[\d\s-]{8,}$/; // Example: At least 8 digits, allows +, space, hyphen
    const uppercaseRegex = /[A-Z]/;
    const lowercaseRegex = /[a-z]/;
    const digitRegex = /\d/; // Matches any digit (0-9)
    // Optional: More specific special character regex if needed
    const specialCharRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;

    // Function to show an error message
    function showError(inputElement, errorElement, message) {
        errorElement.textContent = message;
        errorElement.classList.add('d-block'); // Show the error message div
        inputElement.classList.add('is-invalid'); // Add red border to input
    }

    // Function to clear error messages
    function clearError(inputElement, errorElement) {
        errorElement.textContent = '';
        errorElement.classList.remove('d-block'); // Hide the error message div
        inputElement.classList.remove('is-invalid'); // Remove red border
    }

    // Add submit event listener to the form
    form.addEventListener('submit', function (event) {
        let isValid = true; // Flag to track overall validity

        // --- Clear previous errors ---
        clearError(emailInput, emailError);
        clearError(firstNameInput, firstNameError);
        clearError(lastNameInput, lastNameError); // Corrected variable
        clearError(phoneNumberInput, phoneNumberError);
        clearError(passwordInput, passwordError);

        // --- Validate Email ---
        const emailValue = emailInput.value.trim();
        if (emailValue === '') {
            showError(emailInput, emailError, 'Email is required.');
            isValid = false;
        } else if (!emailRegex.test(emailValue)) {
            showError(emailInput, emailError, 'Please enter a valid email address.');
            isValid = false;
        }

        // --- Validate First Name ---
        if (firstNameInput.value.trim() === '') {
            showError(firstNameInput, firstNameError, 'First Name is required.');
            isValid = false;
        }

        // --- Validate Last Name ---
        if (lastNameInput.value.trim() === '') { // Corrected variable
            showError(lastNameInput, lastNameError, 'Last Name is required.'); // Corrected variable
            isValid = false;
        }

        // --- Validate Phone Number ---
        const phoneValue = phoneNumberInput.value.trim();
        if (phoneValue === '') {
            showError(phoneNumberInput, phoneNumberError, 'Phone Number is required.');
            isValid = false;
        } else if (!phoneRegex.test(phoneValue)) {
            showError(phoneNumberInput, phoneNumberError, 'Please enter a valid phone number (at least 8 digits).');
            isValid = false;
        }

        const passwordValue = passwordInput.value;
        // --- Validate Password ---
        if (passwordInput.value === '') { // Don't trim password typically
            showError(passwordInput, passwordError, 'Password is required.');
            isValid = false;
        } else if (passwordInput.value.length < 8) {
            showError(passwordInput, passwordError, 'Password must be at least 8 characters long.');
            isValid = false;
        } else if (!lowercaseRegex.test(passwordValue)) {
            // Check for at least one lowercase letter
            showError(passwordInput, passwordError, 'Password must contain at least one lowercase letter.');
            isValid = false;
        } else if (!digitRegex.test(passwordValue)) {
            // Check for at least one number
            showError(passwordInput, passwordError, 'Password must contain at least one number.');
            isValid = false;
        } else if (!specialCharRegex.test(passwordValue)) {
            showError(passwordInput, passwordError, 'Password must contain at least one special character (e.g., !@#$%).');
            isValid = false;
        }

        if (!isValid) {
            event.preventDefault(); // Stop the form from submitting
        }
    });

    // Optional: Add real-time validation on input blur (when user clicks away)
    function setupInputValidation(input, errorDiv, validationFn) {
        input.addEventListener('blur', () => {
            clearError(input, errorDiv); // Clear previous error first
            validationFn(); // Run the specific validation
        });
    }

    // // Setup blur validation (example for email)
    // setupInputValidation(emailInput, emailError, () => {
    //     const emailValue = emailInput.value.trim();
    //     if (emailValue === '') {
    //         showError(emailInput, emailError, 'Email is required.');
    //     } else if (!emailRegex.test(emailValue)) {
    //         showError(emailInput, emailError, 'Please enter a valid email address.');
    //     }
    // });
    // Add similar setupInputValidation calls for other fields if desired


    const usernameInput = document.getElementById('username');
    const usernameError = document.getElementById('usernameError');

    // Hàm kiểm tra trùng lặp bằng AJAX
    async function checkDuplicate(field, value) {
        try {
            console.log(`Sending request to check ${field}: ${value}`); // Debug log

            const response = await fetch('/CheckDuplicate', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ field, value })
            });

            if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

            const data = await response.json();
            console.log('Server response:', data); // Debug log

            return data.exists;
        } catch (error) {
            console.error('Check duplicate failed:', error);
            throw error; // Re-throw để hàm gọi xử lý
        }
    }

    // Thêm validation cho username
    async function validateUsername() {
        const usernameValue = usernameInput.value.trim();
        if (usernameValue === '') {
            showError(usernameInput, usernameError, 'Username is required.');
            return false;
        } else if (usernameValue.length < 4) {
            showError(usernameInput, usernameError, 'Username must be at least 4 characters.');
            return false;
        } else if (await checkDuplicate('username', usernameValue, usernameError, 'Username')) {
            showError(usernameInput, usernameError, 'Username already exists.');
            return false;
        }
        clearError(usernameInput, usernameError);
        return true;
    }

    async function validateEmail() {
        const emailValue = emailInput.value.trim();

        // Kiểm tra định dạng trước
        if (emailValue === '') {
            showError(emailInput, emailError, 'Email is required.');
            return false;
        } else if (!emailRegex.test(emailValue)) {
            showError(emailInput, emailError, 'Please enter a valid email address.');
            return false;
        }

        // Kiểm tra trùng lặp
        try {
            const isDuplicate = await checkDuplicate('email', emailValue, emailError, 'Email');
            if (isDuplicate) {
                showError(emailInput, emailError, 'Email already exists.');
                return false;
            }
            clearError(emailInput, emailError);
            return true;
        } catch (error) {
            console.error('Validation error:', error);
            showError(emailInput, emailError, 'Email already exists.');
            return false;
        }
    }

    form.addEventListener('submit', async function (event) {
        event.preventDefault(); // Tạm dừng submit để kiểm tra

        let isValid = true;

        // Clear previous errors
        clearError(usernameInput, usernameError);
        clearError(emailInput, emailError);
        // ... (clear các lỗi khác như cũ)

        // Validate các trường đồng bộ
        if (firstNameInput.value.trim() === '') {
            showError(firstNameInput, firstNameError, 'First Name is required.');
            isValid = false;
        }
        // ... (các validate khác như cũ)

        // Validate username và email bất đồng bộ
        const [isUsernameValid, isEmailValid] = await Promise.all([
            validateUsername(),
            validateEmail()
        ]);

        isValid = isValid && isUsernameValid && isEmailValid;

        if (isValid) {
            // Nếu tất cả đều hợp lệ, submit form
            form.submit();
        }
    });
});