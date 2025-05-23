document.addEventListener('DOMContentLoaded', function() {
    const tabLinks = document.querySelectorAll('.nav-link');
    const saleBanner = document.querySelector('.sale-banner'); // Lấy phần tử sale-banner

    // Chỉ thực hiện nếu có .sale-banner và các .nav-link
    if (saleBanner && tabLinks.length > 0) {
        const tabUnderline = document.createElement('div');
        tabUnderline.className = 'tab-underline';
        saleBanner.appendChild(tabUnderline); // Thêm underline vào .sale-banner

        // Hàm cập nhật vị trí của underline
        function updateUnderline(tab) {
            if (tab) { // <<< THÊM KIỂM TRA NULL Ở ĐÂY
                tabUnderline.style.left = tab.offsetLeft + 'px';
                tabUnderline.style.width = tab.offsetWidth + 'px';
            } else {
                // Nếu không có tab nào (ví dụ: không có tab active), ẩn underline hoặc đặt nó ở vị trí mặc định
                tabUnderline.style.width = '0px'; // Ẩn underline
                console.warn("updateUnderline: Tab provided is null. Hiding underline.");
            }
        }

        // Tìm tab active ban đầu
        const initialActiveTab = document.querySelector('.nav-link.active');

        // Cập nhật underline ban đầu (CHỈ NẾU TÌM THẤY TAB ACTIVE)
        if (initialActiveTab) {
            updateUnderline(initialActiveTab);
        } else if (tabLinks.length > 0) {
            // Nếu không có tab nào active, có thể mặc định chọn tab đầu tiên hoặc không hiển thị underline
            // updateUnderline(tabLinks[0]); // Ví dụ: cập nhật cho tab đầu tiên
            console.warn("No .nav-link.active found on initial load for underline.");
            updateUnderline(null); // Ẩn underline
        }


        // Thêm sự kiện cho từng tab
        tabLinks.forEach(tab => {
            tab.addEventListener('mouseover', () => {
                updateUnderline(tab); // 'tab' ở đây luôn tồn tại vì nó là đối tượng của vòng lặp
            });
            tab.addEventListener('mouseout', () => {
                const activeTab = document.querySelector('.nav-link.active');
                updateUnderline(activeTab); // Trở lại tab active (nếu có)
            });
            tab.addEventListener('click', (event) => {
                event.preventDefault(); // Ngăn hành vi mặc định của link nếu cần
                // Cập nhật active class khi click
                tabLinks.forEach(link => link.classList.remove('active'));
                tab.classList.add('active');
                updateUnderline(tab);
            });
        });
    } else {
        if (!saleBanner) console.warn("Element with class .sale-banner not found.");
        if (tabLinks.length === 0) console.warn("No elements with class .nav-link found.");
    }
});

// ... (các hàm khác của bạn giữ nguyên) ...

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
        // Kiểm tra xem amount có phải là số hợp lệ không
        if (isNaN(parseFloat(amount))) {
            // console.warn("formatCurrency: Invalid amount provided -", amount);
            return ""; // hoặc trả về giá trị mặc định, hoặc giá trị gốc
        }
        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(parseFloat(amount));
    }

    // Hàm định dạng phần trăm giảm giá
    function formatDiscount(discount) {
        if (isNaN(parseFloat(discount))) {
            // console.warn("formatDiscount: Invalid discount provided -", discount);
            return "";
        }
        return Math.round(parseFloat(discount)) + '%';
    }

    // Định dạng giá gốc
    document.querySelectorAll(".product-old-price").forEach(el => {
        const originalPriceText = el.textContent.trim();
        if (originalPriceText) {
            // Xóa bỏ các ký tự không phải số, ngoại trừ dấu thập phân nếu có
            const originalPrice = originalPriceText.replace(/[^\d.]/g, "");
            if (originalPrice) {
                const formattedPrice = formatCurrency(originalPrice);
                if (formattedPrice) el.textContent = formattedPrice;
            }
        }
    });

    // Định dạng giá sau khi giảm
    document.querySelectorAll(".product-price").forEach(el => {
        const lastPriceText = el.textContent.trim();
        if (lastPriceText) {
            const lastPrice = lastPriceText.replace(/[^\d.]/g, "");
            if (lastPrice) {
                const formattedPrice = formatCurrency(lastPrice);
                if (formattedPrice) el.textContent = formattedPrice;
            }
        }
    });

    // Định dạng phần trăm giảm giá
    document.querySelectorAll(".product-discount").forEach(el => {
        const discountPercentText = el.textContent.trim();
        if (discountPercentText) {
            const discountPercent = discountPercentText.replace(/[^\d.]/g, "");
            if (discountPercent) {
                const formattedDiscount = formatDiscount(discountPercent);
                if (formattedDiscount) el.textContent = formattedDiscount;
            }
        }
    });
});