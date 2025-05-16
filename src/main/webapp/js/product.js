let filterState = {
    selectedPrices: [],  // mảng lưu các khoảng giá đang chọn, mỗi phần tử {minPrice, maxPrice}
    selectedSort: null,  // giá trị option dropdown đang chọn
};

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
    fetch(`/ProjectWeb/api/products?selection=${selection}&minPrice=${minPrice}&maxPrice=${maxPrice}`)
        .then(response => response.json())
        .then(data => {
            renderProducts(data.products);
            updateSelection(data.selection);
        })
        .catch(err => console.error("Lỗi khi gọi API:", err));
}

function fetchFilteredProductsByOption(selection, option) {
    if (!selection) selection = "all";
    if (!option) option = "latest";
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
        .catch(err => console.error("Lỗi khi gọi API:", err));
}


