
    document.addEventListener("DOMContentLoaded", function () {
        const priceElements = document.querySelectorAll('.formatted-price');
        priceElements.forEach(element => {
            const price = parseFloat(element.textContent); // Lấy giá trị số
            if (!isNaN(price)) {
                element.textContent = price.toLocaleString('vi-VN'); // Định dạng theo chuẩn Việt Nam
            }
        });
    });
