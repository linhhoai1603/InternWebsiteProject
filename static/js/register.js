document.addEventListener("DOMContentLoaded", () => {
    const registrationForm = document.getElementById("registrationForm");
    const successMessage = document.getElementById("successMessage");
    const submissionError = document.getElementById("submissionError");

    // Hàm reset trạng thái validation
    function resetValidation() {
      const inputs = registrationForm.querySelectorAll(".form-control");
      inputs.forEach((input) => {
        input.classList.remove("is-invalid");
        input.classList.remove("is-valid");
      });
      successMessage.style.display = "none";
      submissionError.style.display = "none";
    }

    // Hàm kiểm tra validation của form
    function validateForm() {
      let isValid = true;

      // Email
      const email = document.getElementById("email");
      const emailError = document.getElementById("emailError");
      const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailPattern.test(email.value.trim())) {
        email.classList.add("is-invalid");
        emailError.textContent = "Vui lòng nhập một địa chỉ email hợp lệ.";
        isValid = false;
      } else {
        email.classList.remove("is-invalid");
        email.classList.add("is-valid");
      }

      // Xác nhận Email
      const confirmEmail = document.getElementById("confirmEmail");
      const confirmEmailError =
        document.getElementById("confirmEmailError");
      if (confirmEmail.value.trim() === "") {
        confirmEmail.classList.add("is-invalid");
        confirmEmailError.textContent = "Vui lòng xác nhận email của bạn.";
        isValid = false;
      } else if (confirmEmail.value.trim() !== email.value.trim()) {
        confirmEmail.classList.add("is-invalid");
        confirmEmailError.textContent = "Email xác nhận không khớp.";
        isValid = false;
      } else {
        confirmEmail.classList.remove("is-invalid");
        confirmEmail.classList.add("is-valid");
      }

      // Mật khẩu
      const password = document.getElementById("password");
      const passwordError = document.getElementById("passwordError");
      if (password.value.trim().length < 6) {
        password.classList.add("is-invalid");
        passwordError.textContent =
          "Vui lòng nhập mật khẩu (ít nhất 6 ký tự).";
        isValid = false;
      } else {
        password.classList.remove("is-invalid");
        password.classList.add("is-valid");
      }

      // Xác nhận Mật khẩu
      const confirmPassword = document.getElementById("confirmPassword");
      const confirmPasswordError = document.getElementById(
        "confirmPasswordError"
      );
      if (confirmPassword.value.trim() === "") {
        confirmPassword.classList.add("is-invalid");
        confirmPasswordError.textContent =
          "Vui lòng xác nhận mật khẩu của bạn.";
        isValid = false;
      } else if (confirmPassword.value.trim() !== password.value.trim()) {
        confirmPassword.classList.add("is-invalid");
        confirmPasswordError.textContent = "Mật khẩu xác nhận không khớp.";
        isValid = false;
      } else {
        confirmPassword.classList.remove("is-invalid");
        confirmPassword.classList.add("is-valid");
      }

      return isValid;
    }

    // Xử lý sự kiện submit form
    registrationForm.addEventListener("submit", async (e) => {
      e.preventDefault(); // Ngăn chặn hành động mặc định của form

      // Reset các trạng thái trước đó
      resetValidation();

      if (validateForm()) {
        // Thu thập dữ liệu form
        const formData = {
          email: document.getElementById("email").value.trim(),
          password: document.getElementById("password").value.trim(),
        };

        try {
          // Hiển thị loader hoặc disable nút submit nếu cần
          const submitButton = registrationForm.querySelector(
            'button[type="submit"]'
          );
          submitButton.disabled = true;
          submitButton.textContent = "Đang xử lý...";

          // Gọi API thực tế ở đây
          // Ví dụ:
          // const response = await fetch('/api/register', {
          //     method: 'POST',
          //     headers: { 'Content-Type': 'application/json' },
          //     body: JSON.stringify(formData)
          // });
          // if (!response.ok) throw new Error('Network response was not ok');

          // Giả lập API call thành công với setTimeout
          await new Promise((resolve) => setTimeout(resolve, 2000));

          // Hiển thị thông báo thành công
          successMessage.style.display = "block";
          registrationForm.reset();
        } catch (error) {
          console.error("Error during registration:", error);
          submissionError.style.display = "block";
        } finally {
          // Kích hoạt lại nút submit
          const submitButton = registrationForm.querySelector(
            'button[type="submit"]'
          );
          submitButton.disabled = false;
          submitButton.textContent = "ĐĂNG KÝ";
        }
      } else {
        submissionError.style.display = "none"; // Ẩn thông báo lỗi chung nếu có
      }
    });

    // Sự kiện cho nút Facebook
    const facebookLogin = document.getElementById("facebookLogin");
    facebookLogin.addEventListener("click", () => {
      console.log("Đăng nhập bằng Facebook");
      alert("Đăng nhập qua Facebook thành công!");
    });

    // Sự kiện cho nút Google
    const googleLogin = document.getElementById("googleLogin");
    googleLogin.addEventListener("click", () => {
      console.log("Đăng nhập bằng Google");
      alert("Đăng nhập qua Google thành công!");
    });

    // Nút Back to Top
    const backToTopButton = document.getElementById("back-to-top");

    // Hàm kiểm tra và toggle hiển thị nút Back to Top
    function toggleBackToTopButton() {
      if (window.scrollY > 200) {
        backToTopButton.classList.add("show");
      } else {
        backToTopButton.classList.remove("show");
      }
    }

    // Lắng nghe sự kiện scroll để hiển thị hoặc ẩn nút Back to Top
    window.addEventListener("scroll", toggleBackToTopButton);

    // Xử lý sự kiện click vào nút Back to Top
    backToTopButton.addEventListener("click", () => {
      window.scrollTo({
        top: 0,
        behavior: "smooth",
      });
    });

    // Kiểm tra trạng thái nút khi tải trang
    toggleBackToTopButton();
  });