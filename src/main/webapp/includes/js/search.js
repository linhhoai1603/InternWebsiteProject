document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('searchInput');
    const searchResults = document.getElementById('searchResults');
    const searchForm = document.getElementById('searchForm');
    let searchTimeout;

    // Chỉ thực hiện tìm kiếm realtime khi người dùng đang nhập
    searchInput.addEventListener('input', function() {
        clearTimeout(searchTimeout);
        const query = this.value.trim();

        if (query.length < 2) {
            searchResults.style.display = 'none';
            return;
        }

        searchTimeout = setTimeout(() => {
            fetch(`${window.location.pathname}/api/search-product?input=${encodeURIComponent(query)}`)
                .then(response => response.json())
                .then(data => {
                    if (data.length > 0) {
                        searchResults.innerHTML = data.map(product => `
                            <a href="${window.location.pathname}/product-detail?id=${product.id}" class="search-result-item">
                                ${product.name}
                            </a>
                        `).join('');
                        searchResults.style.display = 'block';
                    } else {
                        searchResults.innerHTML = '<div class="no-results">Không tìm thấy sản phẩm</div>';
                        searchResults.style.display = 'block';
                    }
                })
                .catch(error => {
                    console.error('Search error:', error);
                    searchResults.style.display = 'none';
                });
        }, 300);
    });

    // Cho phép form submit bình thường
    searchForm.addEventListener('submit', function(e) {
        // Chỉ ngăn submit nếu đang hiển thị kết quả tìm kiếm và người dùng click vào kết quả
        if (searchResults.style.display === 'block' && e.target.closest('.search-result-item')) {
            e.preventDefault();
        }
    });

    // Close search results when clicking outside
    document.addEventListener('click', function(e) {
        if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) {
            searchResults.style.display = 'none';
        }
    });
}); 