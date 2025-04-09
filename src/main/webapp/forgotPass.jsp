<%--
  Created by IntelliJ IDEA.
  User: mypc
  Date: 4/9/2025
  Time: 3:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reset Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

        .reset-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 2rem;
        }

        .step {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background-color: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            color: #6c757d;
            position: relative;
            z-index: 1;
        }

        .step.active {
            background-color: #0d6efd;
            color: white;
        }

        .step.completed {
            background-color: #198754;
            color: white;
        }

        .step-connector {
            width: 100px;
            height: 2px;
            background-color: #e9ecef;
            margin: 17px 10px;
        }

        .step-connector.active {
            background-color: #0d6efd;
        }

        .password-strength {
            height: 5px;
            border-radius: 2px;
            margin-top: 0.5rem;
            background-color: #e9ecef;
            overflow: hidden;
        }

        .strength-meter {
            height: 100%;
            width: 0;
            transition: all 0.3s ease;
        }

        .requirement-list li {
            font-size: 0.875rem;
            color: #6c757d;
            margin-bottom: 0.5rem;
        }

        .requirement-list li.valid {
            color: #198754;
        }

        .requirement-list li i {
            width: 20px;
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
        }

        .password-toggle {
            cursor: pointer;
            color: #6c757d;
        }

        .success-checkmark {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: #198754;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            margin: 0 auto 2rem;
        }

        .verification-input {
            width: 50px;
            height: 50px;
            text-align: center;
            font-size: 1.5rem;
            border-radius: 10px;
            border: 2px solid #dee2e6;
            margin: 0 5px;
        }

        .verification-input:focus {
            border-color: #0d6efd;
            box-shadow: none;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="text-center mb-4">
                <h2 class="mb-2">Reset Password</h2>
                <p class="text-muted">Follow the steps to reset your password securely</p>
            </div>

            <div class="card reset-card">
                <div class="card-body p-4">
                    <!-- Step Indicator -->
                    <div class="step-indicator mb-4">
                        <div class="step active">1</div>
                        <div class="step-connector"></div>
                        <div class="step">2</div>
                        <div class="step-connector"></div>
                        <div class="step">3</div>
                    </div>

                    <div id="errorMessage" class="alert alert-danger d-none" role="alert">
                    </div>

                    <!-- Step 1: Email Verification -->
                    <div class="step-content" id="step1">
                        <h5 class="mb-4">Email Verification</h5>
                        <form id="formStep1">
                            <div class="mb-4">
                                <label class="form-label">Email Address</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                            <i class="fas fa-envelope"></i>
                                        </span>
                                    <input id="emailStep1" name="email" type="email" class="form-control"
                                           placeholder="Enter your email">
                                </div>
                                <div class="form-text">We'll send a verification code to this email</div>
                            </div>
                            <button class="btn btn-primary w-100" type="submit">Send Verification Code</button>
                        </form>
                    </div>

                    <!-- Step 2: Code Verification -->
                    <div class="step-content d-none" id="step2">
                        <h5 class="mb-4">Enter Verification Code</h5>
                        <p class="text-muted mb-4">We've sent a verification code to your email. Please enter it
                            below.</p>
                        <div class="d-flex justify-content-center mb-4">
                            <input type="text" class="verification-input" maxlength="1">
                            <input type="text" class="verification-input" maxlength="1">
                            <input type="text" class="verification-input" maxlength="1">
                            <input type="text" class="verification-input" maxlength="1">
                            <input type="text" class="verification-input" maxlength="1">
                        </div>
                        <div class="text-center mb-4">
                            <span class="text-muted">Didn't receive the code? </span>
                            <a href="#" class="text-decoration-none">Resend</a>
                        </div>
                        <button class="btn btn-primary w-100">Verify Code</button>
                    </div>

                    <!-- Step 3: New Password -->
                    <div class="step-content d-none" id="step3">
                        <h5 class="mb-4">Create New Password</h5>
                        <form id="formStep3">
                            <div class="mb-4">
                                <label class="form-label">New Password</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                    <input name="password" id="passwordStep3" type="password" class="form-control"
                                           placeholder="Enter new password">
                                    <span class="input-group-text password-toggle">
                                            <i class="fas fa-eye"></i>
                                        </span>
                                </div>
                                <div class="password-strength mt-2">
                                    <div class="strength-meter bg-danger" style="width: 60%"></div>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Confirm Password</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                    <input id="confirmPasswordStep3" name="confirmPassword" type="password"
                                           class="form-control" placeholder="Confirm new password">
                                    <span class="input-group-text password-toggle">
                                            <i class="fas fa-eye"></i>
                                        </span>
                                </div>
                            </div>

                            <div class="mb-4">
                                <h6 class="mb-2">Password Requirements:</h6>
                                <ul class="requirement-list list-unstyled">
                                    <li class="valid">
                                        <i class="fas fa-check-circle me-2"></i>
                                        At least 8 characters
                                    </li>
                                    <li>
                                        <i class="fas fa-circle me-2"></i>
                                        Include uppercase letters
                                    </li>
                                    <li>
                                        <i class="fas fa-circle me-2"></i>
                                        Include special characters
                                    </li>
                                    <li>
                                        <i class="fas fa-circle me-2"></i>
                                        Include numbers
                                    </li>
                                </ul>
                            </div>

                            <button class="btn btn-primary w-100" type="submit">Reset Password</button>
                        </form>
                    </div>

                    <!-- Success State -->
                    <div class="step-content d-none text-center" id="success">
                        <div class="success-checkmark">
                            <i class="fas fa-check"></i>
                        </div>
                        <h5 class="mb-3">Password Reset Successful!</h5>
                        <p class="text-muted mb-4">Your password has been successfully reset. You can now log in
                            with your new password.</p>
                        <a href="login.jsp" class="btn btn-primary">Back to Login</a>
                    </div>

                    <div class="text-center mt-4" id="backToLoginLinkContainer">
                        <a href="login.jsp" class="text-decoration-none">
                            <i class="fas fa-arrow-left me-1"></i> Back to Login
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const step1Content = document.getElementById('step1');
        const step2Content = document.getElementById('step2');
        const step3Content = document.getElementById('step3');
        const successContent = document.getElementById('success');
        const allStepContents = [step1Content, step2Content, step3Content, successContent];

        const steps = document.querySelectorAll('.step-indicator .step');
        const connectors = document.querySelectorAll('.step-indicator .step-connector');

        const step1Form = document.getElementById('formStep1');
        const btnVerifyCode = step2Content?.querySelector('button.btn-primary');
        const step3Form = document.getElementById('formStep3');
        const btnBackToLogin = successContent?.querySelector('a.btn');
        const errorDiv = document.getElementById('errorMessage');

        function showError(message) {
            if (errorDiv) {
                errorDiv.textContent = message;
                errorDiv.classList.remove('d-none');
            }
            console.error("Error:", message);
        }

        function hideError() {
            if (errorDiv) {
                errorDiv.classList.add('d-none');
            }
        }

        async function sendAjaxRequest(url, data) {
            let buttonToDisable = null;
            if (data.method === 'confirmEmail' && step1Form) buttonToDisable = step1Form.querySelector('button[type="submit"]');
            else if (data.method === 'confirmCode') buttonToDisable = btnVerifyCode;
            else if (data.method === 'resetPassword' && step3Form) buttonToDisable = step3Form.querySelector('button[type="submit"]');

            const originalButtonText = buttonToDisable ? buttonToDisable.textContent : '';
            if (buttonToDisable) {
                buttonToDisable.disabled = true;
                buttonToDisable.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Processing...';
            }

            hideError();

            try {
                const response = await fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: new URLSearchParams(data)
                });

                if (buttonToDisable) {
                    buttonToDisable.disabled = false;
                    buttonToDisable.textContent = originalButtonText;
                }

                const responseData = await response.json();

                if (!response.ok) {
                    throw new Error(responseData.message || `HTTP error! status: ${response.status} ${response.statusText}`);
                }

                if (typeof responseData.success === 'undefined') {
                    throw new Error('Invalid response format from server.');
                }
                return responseData;

            } catch (error) {
                console.error('AJAX request failed:', error);
                // Kích hoạt lại nút nếu có lỗi xảy ra trước khi nhận response
                if (buttonToDisable && buttonToDisable.disabled) {
                    buttonToDisable.disabled = false;
                    buttonToDisable.textContent = originalButtonText;
                }
                showError(error.message || 'An network or server error occurred. Please try again.');
                return {success: false, message: error.message || 'An network or server error occurred.'}; // Trả về cấu trúc lỗi chuẩn
            }
        }

        function goToStep(stepIndex) {
            hideError();
            allStepContents.forEach(content => content?.classList.add('d-none'));
            if (allStepContents[stepIndex]) {
                allStepContents[stepIndex].classList.remove('d-none');
            }

            steps.forEach((step, index) => {
                step.classList.remove('active', 'completed');
                if (index < stepIndex) step.classList.add('completed');
                else if (index === stepIndex) step.classList.add('active');
            });

            connectors.forEach((connector, index) => {
                connector.classList.remove('active');
                if (index < stepIndex) connector.classList.add('active');
            });

            if (stepIndex === 3) {
                if (steps[2]) steps[2].classList.replace('active', 'completed');
                if (connectors[1]) connectors[1].classList.add('active');
            }

            if (stepIndex === 1) {
                step2Content?.querySelector('.verification-input')?.focus();
            } else if (stepIndex === 2) {
                step3Form?.querySelector('input[name="password"]')?.focus();
            }
        }

        // Form Step 1 (Send Code)
        if (step1Form) {
            step1Form.addEventListener('submit', async function (event) {
                event.preventDefault();
                const emailInput = document.getElementById('emailStep1');
                const email = emailInput ? emailInput.value : '';

                if (!email) {
                    showError('Please enter your email address.');
                    return;
                }

                const formData = {
                    method: 'confirmEmail',
                    email: email
                };

                const result = await sendAjaxRequest('<%= request.getContextPath() %>/forget-password', formData);

                if (result && result.success) {
                    console.log('Email confirmation request successful.');
                    // Hiển thị email ở bước 2 (Tùy chọn)
                    const emailDisplayStep2 = document.getElementById('emailDisplayStep2'); // Cần thêm thẻ này vào HTML step 2
                    if (emailDisplayStep2) {
                        emailDisplayStep2.textContent = email;
                    }
                    goToStep(1); // Chuyển đến Step 2
                } else if (result && result.message) {
                    showError(result.message); // Hiển thị lỗi từ server
                }
            });
        }

        // (Step 2)
        if (btnVerifyCode) {
            const codeInputs = step2Content.querySelectorAll('.verification-input');
            codeInputs.forEach((input, index) => {
                input.addEventListener('input', (e) => { // Dùng 'input' thay vì 'keyup' để bắt cả paste
                    const value = input.value;
                    if (value && index < codeInputs.length - 1) {
                        codeInputs[index + 1].focus();
                    }
                    if (value.length > 1 && index < codeInputs.length - 1) {
                        let current = index + 1;
                        for (let i = 1; i < value.length && current < codeInputs.length; i++) {
                            codeInputs[current].value = value[i];
                            current++;
                        }
                        if (current < codeInputs.length) {
                            codeInputs[current].focus();
                        } else {
                            codeInputs[codeInputs.length - 1].focus();
                        }
                        input.value = value[0];
                    }
                });

                input.addEventListener('keydown', (e) => {
                    if (e.key === 'Backspace' && !input.value && index > 0) {
                        codeInputs[index - 1].focus();
                    }
                });
            });

            btnVerifyCode.addEventListener('click', async function (event) {
                event.preventDefault();
                let verificationCode = '';
                let isComplete = true;
                codeInputs.forEach(input => {
                    if (!input.value) isComplete = false;
                    verificationCode += input.value;
                });

                if (!isComplete || verificationCode.length !== 5) { // Giả sử mã 6 chữ số
                    showError('Please enter the complete 5-digit verification code.');
                    return;
                }

                const formData = {
                    method: 'confirmCode',
                    verificationCode: verificationCode
                };

                const result = await sendAjaxRequest('<%= request.getContextPath() %>/forget-password', formData);

                if (result && result.success) {
                    console.log('Code verification successful.');
                    goToStep(2); // Chuyển đến Step 3
                } else if (result && result.message) {
                    showError(result.message);
                }
            });
        }

        // Form Step 3 (Reset Password)
        if (step3Form) {
            step3Form.addEventListener('submit', async function (event) {
                event.preventDefault();
                const passwordInput = document.getElementById('passwordStep3');
                const confirmPasswordInput = document.getElementById('confirmPasswordStep3');
                const password = passwordInput ? passwordInput.value : '';
                const confirmPassword = confirmPasswordInput ? confirmPasswordInput.value : '';

                if (!password || !confirmPassword) {
                    showError('Please enter and confirm your new password.');
                    return;
                }
                if (password !== confirmPassword) {
                    showError('Passwords do not match.');
                    return;
                }
                // Thêm kiểm tra độ mạnh mật khẩu cơ bản (ví dụ: độ dài)
                if (password.length < 8) {
                    showError('Password must be at least 8 characters long.');
                    return;
                }

                const formData = {
                    method: 'resetPassword',
                    password: password,
                    confirmPassword: confirmPassword // Gửi cả 2 để server có thể check lại nếu muốn
                    // Email vẫn nằm trong session ở server side
                };

                const result = await sendAjaxRequest('<%= request.getContextPath() %>/forget-password', formData);

                if (result && result.success) {
                    console.log('Password reset successful.');
                    goToStep(3); // Chuyển đến Success Screen
                } else if (result && result.message) {
                    showError(result.message);
                }
            });
        }

        // (Nút Back to Login và khởi tạo như cũ)
        if (btnBackToLogin) {
            btnBackToLogin.addEventListener('click', function (event) {
            });
        }

    });
</script>
</body>
</html>
