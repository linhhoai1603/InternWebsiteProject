let selected = "";

function handleCheckboxChange(checkbox) {
    const selection = checkbox.getAttribute('data-selection');
    const minPrice = checkbox.getAttribute('data-min');
    const maxPrice = checkbox.getAttribute('data-max');
    const isChecked = checkbox.checked;

    selected = checkbox.id;
    fetchFilteredProductsByPrice(selection,minPrice,maxPrice);


}
function handleDropdownClick(element) {
    // Lấy các thuộc tính data-selection và data-option từ mục dropdown
    const selection = element.getAttribute('data-selection');
    const option = element.getAttribute('data-option');
    selected = checkbox.id;
    // Nếu bạn muốn gọi API hoặc thực hiện xử lý khác, bạn có thể làm ở đây
    fetchFilteredProductsByOption(selection, option);
}
function handlePaginationClick(element) {
    if(selected == "price2" || selected == "price1" ||selected == "price3" || selected == "price4" ){
        const selection = document.getElementById(selected).getAttribute('data-selection');
        const minPrice = document.getElementById(selected).getAttribute('data-min');
        const maxPrice = document.getElementById(selected).getAttribute('data-max');
        const currentPage = element.getAttribute('data-page');

        fetchFilteredProductsByPrice(selection,minPrice,maxPrice,currentPage);
    }else {
        const selection = document.getElementById(selected).getAttribute('data-selection');
        const option = document.getElementById(selected).getAttribute('data-option');
        const currentPage = element.getAttribute('data-page');

        fetchFilteredProductsByOption(selection, option, currentPage);
    }
}

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

function renderPagination(currentPage, totalPages) {
    const paginationContainer = document.getElementById("paginationContainer");
    const ul = document.createElement("ul");
    ul.className = "pagination pagination-lg";

    // Nút Trước
    if (currentPage > 1) {
        const prevLi = document.createElement("li");
        prevLi.className = "page-item";

        prevLi.innerHTML = `<a class="page-link pagination-link" data-page="${currentPage - 1}" onclick="handlePaginationClick(this)"> < </a>`;
        ul.appendChild(prevLi);
    }

    // Xác định trang bắt đầu và kết thúc
    const startPage = Math.max(1, currentPage - 2);
    const endPage = Math.min(totalPages, currentPage + 2);

    // Các nút trang số
    for (let i = startPage; i <= endPage; i++) {
        const li = document.createElement("li");
        li.className = `page-item ${i === currentPage ? 'active' : ''}`;

        li.innerHTML = `<a class="page-link pagination-link" data-page="${i}" onclick="handlePaginationClick(this)">${i}</a>`;
        ul.appendChild(li);
    }

    // Nút Sau
    if (currentPage < totalPages) {
        const nextLi = document.createElement("li");
        nextLi.className = "page-item";

        nextLi.innerHTML = `<a class="page-link pagination-link" data-page="${currentPage + 1}" onclick="handlePaginationClick(this)"> > </a>`;
        ul.appendChild(nextLi);
    }

    // Xóa cũ và thêm mới
    paginationContainer.innerHTML = "";
    paginationContainer.appendChild(ul);
}

function updateSelection(newSelection) {
    // Cập nhật cho các checkbox
    document.querySelectorAll('.price-filter').forEach(el => {
        el.setAttribute('data-selection', newSelection);
    });

    // Cập nhật cho các mục dropdown
    document.querySelectorAll('.dropdown-item').forEach(el => {
        el.setAttribute('data-selection', newSelection);
    });

    console.log(`data-selection đã được cập nhật thành: ${newSelection}`);
}
function fetchFilteredProductsByPrice(selection,minPrice,maxPrice, currentPage) {
    if (currentPage == null ) currentPage = 1
    fetch(`/ProjectWeb/api/products?selection=${selection}&minPrice=${minPrice}&maxPrice=${maxPrice}&currentPage=${currentPage}`)
        .then(response => response.json())
        .then(data => {
            renderPagination(data.currentPage,nupage)
            renderProducts(data.products);
            updateSelection(data.selection);

        })
        .catch(err => console.error("Lỗi khi gọi API:", err));
}
function fetchFilteredProductsByOption(selection,option,currentPage) {
    if (selection == null) selection = "all";
    if (currentPage == null ) currentPage = 1;
    if (!option) option = "latest";
    fetch(`/ProjectWeb/api/products?selection=${selection}&option=${option}&currentPage=${currentPage}`)
        .then(response => {
            // Kiểm tra mã trạng thái
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            console.log(data.products)
            console.log("da gui")
            renderPagination(data.currentPage,nupage)
            renderProducts(data.products);
            updateSelection(data.selection);
            console.log("Kết quả fetch trả về:", data);
        })
        .catch(err => console.error("Lỗi khi gọi API:", err));
}



