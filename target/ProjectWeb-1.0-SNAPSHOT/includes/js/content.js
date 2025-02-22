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
    window.location.href = `detail-product?productId=${productId}`;
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

