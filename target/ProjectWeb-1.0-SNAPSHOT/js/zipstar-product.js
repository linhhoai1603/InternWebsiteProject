const addToCartButtons = document.querySelectorAll(".btn-add-to-cart");
const favoriteButtons = document.querySelectorAll(".btn-favorite");
// Thêm sự kiện cho các nút Thêm vào Giỏ và Yêu Thích
addToCartButtons.forEach((button) => {
    button.addEventListener("click", (e) => {
        e.preventDefault();
        // Thực hiện chức năng thêm vào giỏ hàng
        alert("Đã thêm sản phẩm vào giỏ hàng!");
    });
});

favoriteButtons.forEach((button) => {
    button.addEventListener("click", (e) => {
        e.preventDefault();
        // Thực hiện chức năng thêm vào yêu thích
        button.classList.toggle("active");
        if (button.classList.contains("active")) {
            alert("Đã thêm sản phẩm vào danh sách yêu thích!");
        } else {
            alert("Đã loại bỏ sản phẩm khỏi danh sách yêu thích!");
        }
    });
});
// Hiển thị nút "Back to Top" khi cuộn xuống
window.addEventListener("scroll", () => {
    const backToTopButton = document.getElementById("back-to-top");
    if (window.scrollY > 200) {
        // Hiển thị khi cuộn xuống hơn 200px
        backToTopButton.classList.add("show");
    } else {
        backToTopButton.classList.remove("show");
    }
});

// Thêm sự kiện click cho nút "Back to Top"
document.getElementById("back-to-top").addEventListener("click", () => {
    window.scrollTo({
        top: 0,
        behavior: "smooth", // Cuộn về đầu trang một cách mượt mà
    });
});