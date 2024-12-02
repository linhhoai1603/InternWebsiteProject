document.addEventListener("DOMContentLoaded", function () {
  const content1 = document.getElementById("content-1");
  const content2 = document.getElementById("content-2");
  const page1Btn = document.getElementById("page-1");
  const page2Btn = document.getElementById("page-2");
  const prevBtn = document.getElementById("prev-btn");
  const nextBtn = document.getElementById("next-btn");
  const location = document.getElementById("location")

  function showPage(page) {
      if (page === 1) {
          content1.style.display = "block";
          content2.style.display = "none";
          page1Btn.classList.add("active");
          page2Btn.classList.remove("active");
          page1Btn.style.backgroundColor = "#339C87";
          page2Btn.style.backgroundColor = "white";
          location.innerHTML = "Trang 1"
      } else if (page === 2) {
          content1.style.display = "none";
          content2.style.display = "block";
          page2Btn.classList.add("active");
          page1Btn.classList.remove("active");
          page2Btn.style.backgroundColor = "#339C87";
          page1Btn.style.backgroundColor = "white";
          location.innerHTML = "Trang 2"
      }
  }

  page1Btn.addEventListener("click", function () {
      showPage(1);
  });

  page2Btn.addEventListener("click", function () {
      showPage(2);
  });

  prevBtn.addEventListener("click", function () {
      if (content2.style.display === "block") {
          showPage(1);
      }
  });

  nextBtn.addEventListener("click", function () {
      if (content1.style.display === "block") {
          showPage(2);
      }
  });
  showPage(1);
});

function updateDropdown(dropdownButtonId, dropdownMenu) {
    const dropdownButton = document.getElementById(dropdownButtonId);
    const dropdownItems = dropdownMenu.querySelectorAll(".dropdown-item");

    dropdownItems.forEach(item => {
        item.addEventListener("click", function () {

            dropdownButton.textContent = this.textContent;

            console.log(`Đã chọn: ${this.textContent}`);
        });
    });
}


updateDropdown(
    "dropdownMenuButton",
    document.querySelector("#dropdownMenuButton + .dropdown-menu")
);
