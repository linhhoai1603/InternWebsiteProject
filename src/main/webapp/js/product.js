function renderProducts(products) {
    const container = document.getElementById("productContainer");
    container.innerHTML = ""; // Xóa nội dung cũ

    products.forEach((product, index) => {

        const discountPercent = product.price.discountPercent;
        const lastPrice = product.price.lastPrice.toLocaleString('vi-VN') + " ₫";
        const originalPrice = product.price.price.toLocaleString('vi-VN') + " ₫";
        const imageUrl = product.image || "default.jpg"; // ảnh mặc định nếu null
        const description = product.description || "";

        const card = `
                <div class="col-md-4 mb-4">
                    <div class="card product-item position-relative h-100">
                        <!-- Thẻ hiển thị giảm giá -->
                        <span id="discount" class="badge bg-danger position-absolute top-0 end-0 m-2 px-3 py-2 fs-5 product-discount">
                            -${discountPercent}%
                        </span>

                        <!-- Hình ảnh chính của sản phẩm -->
                        <img id="mainImage" src="${imageUrl}" class="card-img-top main-product-image" style="object-fit: cover; cursor: pointer;">

                        <div class="card-body text-center d-flex flex-column">
                            <h5 class="card-title">${product.name}</h5>
                            <h4 class="card-text text-success">
                                Chỉ còn:
                                <span id="old-price" class="product-old-price">${lastPrice}</span>
                            </h4>
                            <p class="text-danger text-decoration-line-through">
                                Giá gốc:
                                <span id="price" class="product-price">${originalPrice}</span>
                            </p>
                            <p id="description" class="cart-text description">${description}</p>
                            <button type="button" class="btn btn-warning w-100 mb-2 add-to-cart-button" data-id="${product.id}">
                                Thêm vào giỏ hàng
                            </button>
                            <a id="product-detail" href="/product-detail?id=${product.id}" class="btn btn-primary w-100" style="color: white">
                                Xem ngay
                            </a>
                        </div>
                    </div>
                </div>
            `;

        container.innerHTML += card;
    });
}
function fetchProducts(option, selection, currentPage, minPrice, maxPrice) {
    // Hiển thị loading nếu cần
    // document.getElementById('loading').style.display = 'block';

    // Tạo query parameters
    const params = new URLSearchParams({
        option: option || 'latest',
        selection: selection || 'all',
        currentPage: currentPage || 1,
        minPrice: minPrice || '',
        maxPrice: maxPrice || ''
    });

    fetch(`/api/products?${params.toString()}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            // Gọi hàm renderProducts với dữ liệu nhận được
            renderProducts(data.products);

            // Cập nhật phân trang nếu cần
            // updatePagination(data.nupage, data.currentPage);
        })
        .catch(error => {
            console.error('Error fetching products:', error);
            // Hiển thị thông báo lỗi nếu cần
            // alert('Có lỗi xảy ra khi tải sản phẩm');
        })
        .finally(() => {
            // Ẩn loading
            // document.getElementById('loading').style.display = 'none';
        });
}


