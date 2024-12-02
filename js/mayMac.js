
//Sử lý sản phẩm 
document.querySelectorAll('.btn-cart').forEach(button => {
  button.addEventListener('click', () => {
      alert('Sản phẩm đã được thêm vào giỏ hàng!');
  });
});

// Xử lý sự kiện click vào nút Mua
document.querySelectorAll('.btn-buy').forEach(button => {
  button.addEventListener('click', () => {
      alert('Mua ngay sản phẩm này!');
  });
});

