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

document.addEventListener('DOMContentLoaded', function () {
    // --- Filter Functions ---
    window.applyFilters = function() {
        let url = new URL(window.location.href);
        let params = new URLSearchParams(url.search);

        // Get price range
        const minPrice = document.getElementById('minPrice').value;
        const maxPrice = document.getElementById('maxPrice').value;

        if (minPrice) params.set('minPrice', minPrice);
        if (maxPrice) params.set('maxPrice', maxPrice);

        // Get selected categories
        const selectedCategories = Array.from(document.querySelectorAll('input[name="categories"]:checked'))
            .map(cb => cb.value);

        if (selectedCategories.length > 0) {
            params.delete('categories');
            selectedCategories.forEach(category => {
                params.append('categories', category);
            });
        }

        // Reset to page 1 when applying filters
        params.set('page', '1');

        // Redirect to new URL
        window.location.href = url.pathname + '?' + params.toString();
    };

    window.clearFilters = function() {
        let url = new URL(window.location.href);
        let params = new URLSearchParams(url.search);

        // Remove filter parameters
        params.delete('minPrice');
        params.delete('maxPrice');
        params.delete('categories');

        // Reset to page 1
        params.set('page', '1');

        // Redirect to new URL
        window.location.href = url.pathname + '?' + params.toString();
    };

    window.removePriceFilter = function() {
        let url = new URL(window.location.href);
        let params = new URLSearchParams(url.search);

        params.delete('minPrice');
        params.delete('maxPrice');

        window.location.href = url.pathname + '?' + params.toString();
    };

    window.removeCategoryFilter = function(categoryId) {
        let url = new URL(window.location.href);
        let params = new URLSearchParams(url.search);

        // Get current categories
        let categories = params.getAll('categories');
        // Remove the specified category
        categories = categories.filter(id => id !== categoryId.toString());

        // Update URL
        params.delete('categories');
        categories.forEach(category => {
            params.append('categories', category);
        });

        window.location.href = url.pathname + '?' + params.toString();
    };

    // --- Modal and AJAX Handling ---
    const productDetailModal = document.getElementById('productDetailModal');
    const modalProductDetails = document.getElementById('modalProductDetails');

    if (productDetailModal) {
        productDetailModal.addEventListener('show.bs.modal', function (event) {
            // Button that triggered the modal
            const button = event.relatedTarget;
            // Extract product ID from data-product-id attribute
            const productId = button.getAttribute('data-product-id');

            if (!productId) {
                modalProductDetails.innerHTML = 'Lỗi: Không tìm thấy ID sản phẩm';
                return;
            }

            // Clear previous content
            modalProductDetails.innerHTML = 'Đang tải...';

            // Fetch product details via AJAX
            fetch(`detail-product?productId=${productId}&ajax=true`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(product => {
                    if (!product) {
                        modalProductDetails.innerHTML = 'Không tìm thấy chi tiết sản phẩm.';
                        return;
                    }

                    // Populate modal with product details
                    const productName = product.name || 'N/A';
                    const productImage = product.image || '';
                    const productLastPrice = product.price && product.price.lastPrice !== undefined ? product.price.lastPrice + '₫' : 'N/A';
                    const productDescription = product.description || 'Không có mô tả';
                    const productQuantity = product.quantity !== undefined ? product.quantity : 'N/A';
                    const productDateAdded = product.dateAdded || 'N/A';

                    modalProductDetails.innerHTML = `
                        <div class="row">
                            <div class="col-md-6">
                                <img src="${productImage}" class="img-fluid" alt="${productName}">
                            </div>
                            <div class="col-md-6">
                                <h5>${productName}</h5>
                                <p><strong>Giá:</strong> ${productLastPrice}</p>
                                <p><strong>Mô tả:</strong> ${productDescription}</p>
                                <p><strong>Số lượng còn lại:</strong> ${productQuantity}</p>
                                <p><strong>Ngày thêm:</strong> ${productDateAdded}</p>
                            </div>
                        </div>
                    `;
                })
                .catch(error => {
                    console.error('Error fetching product details:', error);
                    modalProductDetails.innerHTML = `Lỗi khi tải chi tiết sản phẩm: ${error.message}`;
                });
        });
    }

    // --- Style Selection, Quantity, Add to Cart Handling ---
    const styleInputs = document.querySelectorAll('input[type="radio"][name="styleId"]');
    styleInputs.forEach(input => {
        input.addEventListener("change", function () {
            const form = this.closest(".product-options-form");
            const productId = form.querySelector('input[name="productId"]');
            const imageUrl = this.nextElementSibling.src;
            if (productId) {
                changeMainImage(productId.value, imageUrl);
            }
        });
    });

    // Add to cart button handling
    const addToCartButtons = document.querySelectorAll(".add-to-cart-button");
    addToCartButtons.forEach(button => {
        button.addEventListener("click", function () {
            const form = this.closest(".product-options-form");
            const quantityAndButtons = form.querySelector(".quantity-and-buttons");
            const styleInputs = form.querySelectorAll('input[type="radio"][name="styleId"]');

            // Check if a style is selected
            let styleSelected = false;
            styleInputs.forEach(input => {
                if (input.checked) {
                    styleSelected = true;
                }
            });

            if (!styleSelected) {
                alert("Vui lòng chọn style sản phẩm trước!");
                return;
            }

            // Show quantity input and confirm/cancel buttons
            if (quantityAndButtons) {
                quantityAndButtons.style.display = "block";
            }
            this.style.display = "none";
        });
    });

    // Cancel button handling
    const cancelButtons = document.querySelectorAll(".cancel-button");
    cancelButtons.forEach(button => {
        button.addEventListener("click", function () {
            const form = this.closest(".product-options-form");
            const quantityAndButtons = form.querySelector(".quantity-and-buttons");
            const addToCartButton = form.querySelector(".add-to-cart-button");

            if (quantityAndButtons) {
                quantityAndButtons.style.display = "none";
            }
            if (addToCartButton) {
                addToCartButton.style.display = "block";
            }
        });
    });

    // Form submission handling
    const forms = document.querySelectorAll(".product-options-form");
    forms.forEach(form => {
        form.addEventListener("submit", function(e) {
            e.preventDefault();

            const quantityInput = form.querySelector(".quantity-input");
            const styleInput = form.querySelector('input[type="radio"][name="styleId"]:checked');
            const productId = form.querySelector('input[name="productId"]');

            // Validate style selection
            if (!styleInput) {
                alert("Vui lòng chọn style sản phẩm!");
                return;
            }

            // Validate quantity
            if (!quantityInput || !quantityInput.value || parseInt(quantityInput.value) < 1) {
                alert("Vui lòng nhập số lượng hợp lệ!");
                return;
            }

            // Validate product ID
            if (!productId || !productId.value) {
                alert("Lỗi: Không tìm thấy thông tin sản phẩm!");
                return;
            }

            // If all validations pass, submit the form
            this.submit();
        });
    });

    function changeMainImage(productId, imageUrl) {
        const mainImage = document.getElementById("mainImage" + productId);
        if (mainImage) {
            mainImage.src = imageUrl;
        }
    }
});

