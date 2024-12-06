// Update color selection
const colorOptions = document.querySelectorAll('.color-option');
const sizeOptions = document.querySelectorAll('.size-option');
const colorInput = document.getElementById('selected_color');
const sizeInput = document.getElementById('selected_size');

colorOptions.forEach(option => {
    option.addEventListener('click', () => {
        colorInput.value = option.getAttribute('data-color');
        colorOptions.forEach(opt => opt.classList.remove('selected'));
        option.classList.add('selected');
    });
});

sizeOptions.forEach(option => {
    option.addEventListener('click', () => {
        sizeInput.value = option.getAttribute('data-size');
        sizeOptions.forEach(opt => opt.classList.remove('btn-primary'));
        option.classList.add('btn-primary');
    });
});