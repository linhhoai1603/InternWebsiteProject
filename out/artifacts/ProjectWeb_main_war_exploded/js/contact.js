(function () {
    "use strict";

    const form = document.getElementById("contactForm");
    const successMessage = document.getElementById("successMessage");
    const honeypotError = document.getElementById("honeypotError");
    const formError = document.getElementById("formError");

    // Hàm ẩn tất cả các thông báo
    function hideMessages() {
        successMessage.style.display = "none";
        honeypotError.style.display = "none";
        formError.style.display = "none";
    }

    // Hàm kiểm tra Honeypot
    function isHoneypotFilled() {
        const honeypot = document.getElementById("contactTime").value;
        return honeypot.trim() !== "";
    }

    // Hàm xử lý khi form hợp lệ
    function handleValidForm() {
        // Giả lập gửi form thành công
        // Trong thực tế, bạn cần gửi dữ liệu đến server ở đây
        successMessage.style.display = "block";
        form.reset();
        form.classList.remove("was-validated");
    }

    // Hàm xử lý khi form không hợp lệ
    function handleInvalidForm() {
        form.classList.add("was-validated");
    }

    // Xử lý sự kiện submit
    form.addEventListener(
        "submit",
        function (event) {
            event.preventDefault();
            event.stopPropagation();

            hideMessages();

            if (isHoneypotFilled()) {
                honeypotError.style.display = "block";
                return;
            }

            if (form.checkValidity()) {
                handleValidForm();
            } else {
                handleInvalidForm();
            }
        },
        false
    );

    // Xử lý các sự kiện focus và blur cho các trường bắt buộc
    const requiredFields = form.querySelectorAll("[required]");
    requiredFields.forEach((field) => {
        field.addEventListener("focus", () => {
            field.classList.remove("is-invalid");
        });

        field.addEventListener("blur", () => {
            if (!field.checkValidity()) {
                field.classList.add("is-invalid");
            }
        });
    });

    // Xử lý các thay đổi trong các trường input để loại bỏ class 'is-invalid'
    form.addEventListener("input", (event) => {
        if (event.target.classList.contains("form-control")) {
            event.target.classList.remove("is-invalid");
        }
    });
})();

// Hiển thị nút "Back to Top" khi cuộn xuống
window.addEventListener("scroll", () => {
    const backToTopButton = document.getElementById("back-to-top");
    if (window.scrollY > 200) {
        // Hiển thị khi cuộn xuống hơn 200px
        backToTopButton.classList.add("show");
    } else {
        backToTopButton.classList.remove("show");
    }
});

// Thêm sự kiện click cho nút "Back to Top"
document.getElementById("back-to-top").addEventListener("click", () => {
    window.scrollTo({
        top: 0,
        behavior: "smooth", // Cuộn về đầu trang một cách mượt mà
    });
});