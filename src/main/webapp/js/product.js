let filterState = {
    selectedPrices: [],  // mảng lưu các khoảng giá đang chọn, mỗi phần tử {minPrice, maxPrice}
    selectedSort: null,  // giá trị option dropdown đang chọn
};

// Wrap initialization in DOM ready handler
document.addEventListener('DOMContentLoaded', function() {
    // Gán sự kiện cho checkbox
    document.querySelectorAll('.price-filter').forEach(cb => {
        cb.addEventListener('change', () => handleCheckboxChange(cb));
    });

    // Gán sự kiện cho dropdown sắp xếp
    document.querySelectorAll('.sort-options .dropdown-item').forEach(item => {
        item.addEventListener('click', (e) => {
            e.preventDefault();
            clearSortDropdownSelection();
            item.classList.add('active');
            handleSortSelection(item);
        });
    });

    // Initialize any existing selections
    const activeSort = document.querySelector('.sort-options .dropdown-item.active');
    if (activeSort) {
        handleSortSelection(activeSort);
    }
});

function handleCheckboxChange(checkbox) {
    const selection = checkbox.getAttribute('data-selection') || 'all';
    const minPrice = checkbox.getAttribute('data-min') || '';
    const maxPrice = checkbox.getAttribute('data-max') || '';

    if (checkbox.checked) {
        // Thêm khoảng giá vào mảng nếu chưa có
        if (!filterState.selectedPrices.some(p => p.minPrice === minPrice && p.maxPrice === maxPrice)) {
            filterState.selectedPrices.push({ minPrice, maxPrice });
        }

        // Bỏ chọn dropdown
        filterState.selectedSort = null;
        clearSortDropdownSelection();

    } else {
        // Bỏ khoảng giá khỏi mảng
        filterState.selectedPrices = filterState.selectedPrices.filter(
            p => !(p.minPrice === minPrice && p.maxPrice === maxPrice)
        );
    }

    console.log('Checkbox filter:', filterState.selectedPrices);
    console.log('Sort selected:', filterState.selectedSort);

    // Gọi fetch với khoảng giá đầu tiên trong mảng nếu có, hoặc fetch tất cả nếu không có
    if (filterState.selectedPrices.length > 0) {
        // Ở đây lấy 1 khoảng giá để gọi API (bạn có thể mở rộng nếu API hỗ trợ nhiều khoảng giá)
        const { minPrice, maxPrice } = filterState.selectedPrices[0];
        fetchFilteredProductsByPrice(selection, minPrice, maxPrice);
    } else {
        // Nếu không còn khoảng giá nào được chọn, có thể gọi fetch mặc định (không lọc giá, không sắp xếp)
        fetchFilteredProductsByPrice(selection, '', '');
    }
}

function handleSortSelection(item) {
    const selection = item.getAttribute('data-selection') || 'all';
    const option = item.getAttribute('data-option') || 'latest';

    filterState.selectedSort = option;

    // Bỏ chọn checkbox giá
    filterState.selectedPrices = [];
    clearAllPriceCheckboxes();

    console.log('Checkbox filter:', filterState.selectedPrices);
    console.log('Sort selected:', filterState.selectedSort);

    // Gọi fetch lọc theo option
    fetchFilteredProductsByOption(selection, option);
}

function clearSortDropdownSelection() {
    document.querySelectorAll('.sort-options .dropdown-item').forEach(item => {
        item.classList.remove('active');
    });
}

function clearAllPriceCheckboxes() {
    document.querySelectorAll('.price-filter').forEach(cb => {
        cb.checked = false;
    });
}

function renderProducts(products) {
    const container = document.getElementById("productContainer");
    container.innerHTML = "";

    products.forEach(product => {
        const discountPercent = product.price.discountPercent;
        const lastPrice = product.price.lastPrice.toLocaleString('vi-VN') + " ₫";
        const originalPrice = product.price.price.toLocaleString('vi-VN') + " ₫";
        const imageUrl = product.image || "default.jpg";
        const description = product.description || "";

        const card = `
            <div class="col-md-4 mb-4">
                <div class="card product-item position-relative h-100">
                    ${discountPercent > 0 ? `<span class="badge bg-danger position-absolute top-0 end-0 m-2 px-3 py-2 fs-5 product-discount">-${discountPercent}%</span>` : ''}
                    <img src="${imageUrl}" class="card-img-top main-product-image" style="object-fit: cover; cursor: pointer;">
                    <div class="card-body text-center d-flex flex-column">
                        <h5 class="card-title">${product.name}</h5>
                        <h4 class="card-text text-success">
                            Chỉ còn: <span class="product-old-price">${lastPrice}</span>
                        </h4>
                        <p class="text-danger text-decoration-line-through">
                            Giá gốc: <span class="product-price">${originalPrice}</span>
                        </p>
                        <p class="cart-text description">${description}</p>
                        <button type="button" class="btn btn-warning w-100 mb-2 add-to-cart-button" data-id="${product.id}">
                            Thêm vào giỏ hàng
                        </button>
                        <a href="/product-detail?id=${product.id}" class="btn btn-primary w-100" style="color: white">Xem ngay</a>
                    </div>
                </div>
            </div>
        `;
        container.innerHTML += card;
    });
}

function updateSelection(newSelection) {
    document.querySelectorAll('.price-filter').forEach(el => {
        el.setAttribute('data-selection', newSelection);
    });
    document.querySelectorAll('.dropdown-item').forEach(el => {
        el.setAttribute('data-selection', newSelection);
    });
    console.log(`data-selection đã được cập nhật thành: ${newSelection}`);
}

function fetchFilteredProductsByPrice(selection, minPrice, maxPrice) {
    showLoading();
    fetch(`/ProjectWeb/api/products?selection=${selection}&minPrice=${minPrice}&maxPrice=${maxPrice}`)
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            renderProducts(data.products);
            updateSelection(data.selection);
        })
        .catch(err => {
            console.error("Lỗi khi gọi API:", err);
            showError("Có lỗi xảy ra khi tải sản phẩm. Vui lòng thử lại sau.");
        })
        .finally(() => {
            hideLoading();
        });
}

function fetchFilteredProductsByOption(selection, option) {
    if (!selection) selection = "all";
    if (!option) option = "latest";
    showLoading();
    fetch(`/ProjectWeb/api/products?selection=${selection}&option=${option}`)
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            renderProducts(data.products);
            updateSelection(data.selection);
        })
        .catch(err => {
            console.error("Lỗi khi gọi API:", err);
            showError("Có lỗi xảy ra khi tải sản phẩm. Vui lòng thử lại sau.");
        })
        .finally(() => {
            hideLoading();
        });
}

// Add loading and error handling functions
function showLoading() {
    const overlay = document.getElementById('loadingOverlay');
    if (overlay) {
        overlay.style.display = 'flex';
    }
}

function hideLoading() {
    const overlay = document.getElementById('loadingOverlay');
    if (overlay) {
        overlay.style.display = 'none';
    }
}

function showError(message) {
    // You can implement your preferred error display method here
    alert(message);
}

// Handle add to cart button click
$(document).on('click', '.add-to-cart-button', function() {
    const productId = $(this).data('id');
    loadProductDetails(productId);
});

function loadProductDetails(productId) {
    console.log('Loading product details for ID:', productId); // Debug log
    
    // Show loading overlay
    $('#loadingOverlay').show();

    // Call API to get product details
    $.ajax({
        url: '/ProjectWeb/api/detail-product',
        method: 'GET',
        data: { id: productId },
        success: function(response) {
            console.log('Product details received:', response); // Debug log
            // Nếu response là object có key 'products'
            if (response.products) {
                updateModalContent(response.products);
            } else {
                updateModalContent(response);
            }
            // Show modal
            const productModal = new bootstrap.Modal(document.getElementById('productDetailsModal'));
            productModal.show();
        },
        error: function(xhr, status, error) {
            console.error('Error loading product details:', error);
            console.error('Status:', status);
            console.error('Response:', xhr.responseText);
            alert('Có lỗi xảy ra khi tải thông tin sản phẩm');
        },
        complete: function() {
            // Hide loading overlay
            $('#loadingOverlay').hide();
        }
    });
}

function updateModalContent(product) {
    console.log('Updating modal content with:', product); // Debug log
    
    try {
        if (!product) {
            console.error('Product data is null or undefined');
            return;
        }

        // Update basic product information
        const modalImage = $('.product-modal-image');
        const modalName = $('.product-modal-name');
        const modalOriginalPrice = $('.product-modal-original-price');
        const modalDiscountedPrice = $('.product-modal-discounted-price');
        const modalStyles = $('.product-modal-styles');
        const productIdInput = $('input[name="productID"]');
        const currentUrlInput = $('input[name="currentURL"]');

        // Clear previous content
        modalImage.attr('src', '');
        modalName.text('');
        modalOriginalPrice.text('');
        modalDiscountedPrice.text('');
        modalStyles.empty();
        productIdInput.val('');
        currentUrlInput.val('');

        // Update with new content
        modalImage.attr('src', product.image || '');
        modalName.text(product.name || '');
        
        // Handle price information
        if (product.price) {
            modalOriginalPrice.text(formatPrice(product.price.price || 0) + '₫');
            modalDiscountedPrice.text(formatPrice(product.price.lastPrice || 0) + '₫');
        } else {
            console.warn('Price information is missing');
            modalOriginalPrice.text('0₫');
            modalDiscountedPrice.text('0₫');
        }
        
        // Update form values
        productIdInput.val(product.id || '');
        currentUrlInput.val(window.location.href);
        
        // Update styles
        if (product.styles && product.styles.length > 0) {
            product.styles.forEach(style => {
                const styleHtml = `
                    <label for="style${style.id}" class="product-style-label" style="margin: 5px;">
                        <input type="radio" name="selectedStyle" id="style${style.id}" value="${style.id}" required style="display: none;">
                        <img src="${style.image}" alt="${style.name}" class="product-style-image rounded" style="width: 60px; height: 60px; border: 2px solid #ccc; padding: 2px;">
                    </label>
                `;
                modalStyles.append(styleHtml);
            });
        } else {
            console.warn('No styles found for product');
        }

        // Force modal to update its layout
        $('#productDetailsModal').modal('handleUpdate');
    } catch (error) {
        console.error('Error updating modal content:', error);
        alert('Có lỗi xảy ra khi hiển thị thông tin sản phẩm');
    }
}

function formatPrice(price) {
    return new Intl.NumberFormat('vi-VN').format(price);
}


