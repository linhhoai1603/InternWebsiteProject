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

document.addEventListener('DOMContentLoaded', function() {
    const productCards = document.querySelectorAll('.product-card'); // Chọn tất cả các thẻ sản phẩm

    productCards.forEach(card => {
        const productImage = card.querySelector('img'); // Chọn hình ảnh sản phẩm trong thẻ hiện tại
        const squares = card.querySelectorAll('.square'); // Chọn tất cả các khối vuông trong thẻ hiện tại

        squares.forEach(square => {
            square.addEventListener('mouseenter', function() { // Sử dụng mouseenter để thay đổi hình ảnh
                const newImage = this.getAttribute('data-img'); // Lấy đường dẫn hình ảnh từ thuộc tính data-img
                productImage.src = newImage; // Thay đổi hình ảnh sản phẩm trong thẻ hiện tại
            });

            // Thêm sự kiện mouseleave để trở lại hình ảnh gốc nếu cần
            square.addEventListener('mouseleave', function() {
                productImage.src = card.querySelector('img').src; // Đưa hình ảnh về ban đầu
            });
        });
    });
});
