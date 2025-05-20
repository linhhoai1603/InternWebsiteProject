// Biến lưu từ khóa tìm kiếm
let searchQuery = '';

// Hàm khởi tạo
$(document).ready(function() {
    // Lấy từ khóa tìm kiếm từ URL
    const urlParams = new URLSearchParams(window.location.search);
    searchQuery = urlParams.get('q') || '';
    
    // Hiển thị từ khóa tìm kiếm
    $('#searchQuery').text(searchQuery);
    
    // Tìm kiếm sản phẩm
    if (searchQuery) {
        searchProducts(searchQuery);
    }
});

// Hàm tìm kiếm sản phẩm
function searchProducts(query) {
    showLoading();
    
    $.ajax({
        url: '/ProjectWeb/api/search',
        method: 'GET',
        data: { q: query },
        success: function(response) {
            console.log('Search results:', response);
            if (response.products) {
                renderProducts(response.products);
                $('#resultCount').text(response.products.length);
            } else {
                $('#productContainer').html('<div class="col-12 text-center"><p>Không tìm thấy sản phẩm nào</p></div>');
                $('#resultCount').text('0');
            }
        },
        error: function(xhr, status, error) {
            console.error('Error searching products:', error);
            showError('Có lỗi xảy ra khi tìm kiếm sản phẩm');
        },
        complete: function() {
            hideLoading();
        }
    });
}

// Hàm render sản phẩm
function renderProducts(products) {
    const container = $('#productContainer');
    container.empty();

    products.forEach(product => {
        const discountPercent = product.price.discountPercent;
        const lastPrice = formatPrice(product.price.lastPrice) + ' ₫';
        const originalPrice = formatPrice(product.price.price) + ' ₫';
        const imageUrl = product.image || 'default.jpg';
        const description = product.description || '';

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
                        <a href="detail-product?productId=${product.id}" class="btn btn-primary w-100" style="color: white">Xem ngay</a>
                    </div>
                </div>
            </div>
        `;
        container.append(card);
    });
}

// Hàm load chi tiết sản phẩm
function loadProductDetails(productId) {
    console.log('Loading product details for ID:', productId);
    
    showLoading();

    $.ajax({
        url: '/ProjectWeb/api/detail-product',
        method: 'GET',
        data: { id: productId },
        success: function(response) {
            console.log('Product details received:', response);
            if (response.products) {
                updateModalContent(response.products);
            } else {
                updateModalContent(response);
            }
            const productModal = new bootstrap.Modal(document.getElementById('productDetailsModal'));
            productModal.show();
        },
        error: function(xhr, status, error) {
            console.error('Error loading product details:', error);
            alert('Có lỗi xảy ra khi tải thông tin sản phẩm');
        },
        complete: function() {
            hideLoading();
        }
    });
}

// Hàm cập nhật nội dung modal
function updateModalContent(product) {
    console.log('Updating modal content with:', product);
    
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

// Hàm format giá
function formatPrice(price) {
    return new Intl.NumberFormat('vi-VN').format(price);
}

// Hàm hiển thị loading
function showLoading() {
    $('#loadingOverlay').show();
}

// Hàm ẩn loading
function hideLoading() {
    $('#loadingOverlay').hide();
}

// Hàm hiển thị lỗi
function showError(message) {
    alert(message);
} 