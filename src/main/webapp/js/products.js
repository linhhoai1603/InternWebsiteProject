document.addEventListener("DOMContentLoaded", function () {
    const content1 = document.getElementById("content-1");
    const content2 = document.getElementById("content-2");
    const page1Btn = document.getElementById("page-1");
    const page2Btn = document.getElementById("page-2");
    const prevBtn = document.getElementById("prev-btn");
    const nextBtn = document.getElementById("next-btn");
    const location = document.getElementById("location")

    function showPage(page) {
        if (page === 1) {
            content1.style.display = "block";
            content2.style.display = "none";
            page1Btn.classList.add("active");
            page2Btn.classList.remove("active");
            page1Btn.style.backgroundColor = "#339C87";
            page2Btn.style.backgroundColor = "white";
            location.innerHTML = "Trang 1"
        } else if (page === 2) {
            content1.style.display = "none";
            content2.style.display = "block";
            page2Btn.classList.add("active");
            page1Btn.classList.remove("active");
            page2Btn.style.backgroundColor = "#339C87";
            page1Btn.style.backgroundColor = "white";
            location.innerHTML = "Trang 2"
        }
    }

    page1Btn.addEventListener("click", function () {
        showPage(1);
    });

    page2Btn.addEventListener("click", function () {
        showPage(2);
    });

    prevBtn.addEventListener("click", function () {
        if (content2.style.display === "block") {
            showPage(1);
        }
    });

    nextBtn.addEventListener("click", function () {
        if (content1.style.display === "block") {
            showPage(2);
        }
    });
    showPage(1);
});

function updateDropdown(dropdownButtonId, dropdownMenu) {
    const dropdownButton = document.getElementById(dropdownButtonId);
    const dropdownItems = dropdownMenu.querySelectorAll(".dropdown-item");

    dropdownItems.forEach(item => {
        item.addEventListener("click", function () {

            dropdownButton.textContent = this.textContent;

            console.log(`Đã chọn: ${this.textContent}`);
        });
    });
}


updateDropdown(
    "dropdownMenuButton",
    document.querySelector("#dropdownMenuButton + .dropdown-menu")
);
document.addEventListener('DOMContentLoaded', function() {
    const tabLinks = document.querySelectorAll('.nav-link');
    const tabUnderline = document.createElement('div');
    tabUnderline.className = 'tab-underline';
    document.querySelector('.sale-banner').appendChild(tabUnderline);

    // Hàm cập nhật vị trí của underline
    function updateUnderline(tab) {
        tabUnderline.style.left = tab.offsetLeft + 'px'; // Di chuyển theo tab
        tabUnderline.style.width = tab.offsetWidth + 'px'; // Thay đổi chiều rộng
    }

    // Cập nhật underline ban đầu
    updateUnderline(document.querySelector('.nav-link.active'));

    // Thêm sự kiện cho từng tab
    tabLinks.forEach(tab => {
        tab.addEventListener('mouseover', () => {
            updateUnderline(tab);
        });
        tab.addEventListener('mouseout', () => {
            updateUnderline(document.querySelector('.nav-link.active')); // Trở lại tab active
        });
        tab.addEventListener('click', () => {
            // Cập nhật active class khi click
            tabLinks.forEach(link => link.classList.remove('active'));
            tab.classList.add('active');
            updateUnderline(tab);
        });
    });
});

function navigateToProduct(productId) {
    // Thêm logic xử lý trước khi chuyển trang, nếu cần
    console.log("Navigating to product with ID:", productId);
    window.location.href = `productDetail?id=${productId}`;
}
// Hàm thay đổi hình ảnh lớn
function changeMainImage(productId, styleImage) {
    const mainImage = document.getElementById(`mainImage${productId}`);
    if (mainImage) {
        mainImage.src = styleImage; // Cập nhật ảnh lớn bằng ảnh style
    }
}



// Hàm khôi phục hình ảnh gốc
function restoreMainImage(productId, originalImage) {
    const mainImage = document.getElementById(`mainImage${productId}`);
    if (mainImage) {
        mainImage.src = originalImage; // Khôi phục lại ảnh ban đầu
    }
}


document.addEventListener("DOMContentLoaded", function () {
    // Hàm định dạng số tiền thành tiền Việt
    function formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
    }

    // Hàm định dạng phần trăm giảm giá
    function formatDiscount(discount) {
        return Math.round(discount) + '%';
    }

    // Định dạng giá gốc
    document.querySelectorAll(".product-old-price").forEach(el => {
        const originalPrice = el.textContent.trim().replace("VND", "").replace(/,/g, "");
        if (originalPrice) {
            el.textContent = formatCurrency(parseFloat(originalPrice));
        }
    });

    // Định dạng giá sau khi giảm
    document.querySelectorAll(".product-price").forEach(el => {
        const lastPrice = el.textContent.trim().replace("VND", "").replace(/,/g, "");
        if (lastPrice) {
            el.textContent = formatCurrency(parseFloat(lastPrice));
        }
    });

    // Định dạng phần trăm giảm giá
    document.querySelectorAll(".product-discount").forEach(el => {
        const discountPercent = el.textContent.trim().replace("%", "");
        if (discountPercent) {
            el.textContent = formatDiscount(parseFloat(discountPercent));
        }
    });
});

