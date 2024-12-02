// ================= BIỂU ĐỒ DOANH THU =================
const revenueCtx = document.getElementById("revenue-chart").getContext("2d");
const revenueData = {
  labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"],
  datasets: [{
    label: "Doanh thu mỗi tháng (Nghìn VND)",
    backgroundColor: "rgba(50, 8, 190, 0.5)",
    borderColor: "rgba(15, 7, 5, 1)",
    data: [1000, 6000, 4000, 8000, 1600, 6000, 2500, 5100, 5000, 8000, 4030, 6000]
  }]
};

new Chart(revenueCtx, {
  type: "line",
  data: revenueData,
  options: {
    scales: {
      y: {
        beginAtZero: true,
        max: 10000,
        title: { display: true, text: "Doanh thu (Nghìn VND)" }
      }
    }
  }
});

// ================= BIỂU ĐỒ SẢN PHẨM BÁN CHẠY =================
const bestSalerCtx = document.getElementById("best-saler-chart").getContext("2d");
const bestSalerData = {
  labels: ["Vải lụa", "Vải kaki", "Vải nhung", "Vải len", "Vải cotton"],
  datasets: [{
    label: "Số lượng bán ra",
    data: [500, 300, 400, 600, 200],
    backgroundColor: [
      "rgba(255, 99, 132, 0.5)",
      "rgba(54, 162, 235, 0.5)",
      "rgba(255, 206, 86, 0.5)",
      "rgba(75, 192, 192, 0.5)",
      "rgba(153, 102, 255, 0.5)"
    ],
    borderColor: [
      "rgba(255, 99, 132, 1)",
      "rgba(54, 162, 235, 1)",
      "rgba(255, 206, 86, 1)",
      "rgba(75, 192, 192, 1)",
      "rgba(153, 102, 255, 1)"
    ],
    borderWidth: 1
  }]
};

new Chart(bestSalerCtx, {
  type: "pie",
  data: bestSalerData,
  options: {
    responsive: true,
    plugins: {
      legend: { position: "top" },
      tooltip: { enabled: true }
    }
  }
});

// Thêm chú thích cho biểu đồ
const chartLegend = document.getElementById("chart-legend");
bestSalerData.labels.forEach((label, index) => {
  const color = bestSalerData.datasets[0].backgroundColor[index];
  const legendItem = document.createElement("li");
  legendItem.innerHTML = `
    <span style="display:inline-block;width:15px;height:15px;background-color:${color};margin-right:10px;"></span>
    ${label}
  `;
  chartLegend.appendChild(legendItem);
});

// ================= BIỂU ĐỒ CỘT NGANG =================
const popularityCtx = document.getElementById("popularity-chart").getContext("2d");

// Dữ liệu biểu đồ
const popularityData = {
  labels: ["Vải Cotton", "Vải Lụa", "Vải Kaki", "Vải Nhung", "Vải Len"],
  datasets: [{
    label: "Mức độ phổ biến (%)",
    data: [85, 70, 60, 45, 30],
    backgroundColor: [
      "rgba(54, 162, 235, 0.6)", 
      "rgba(255, 99, 132, 0.6)", 
      "rgba(255, 206, 86, 0.6)", 
      "rgba(75, 192, 192, 0.6)", 
      "rgba(153, 102, 255, 0.6)" 
    ],
    borderColor: [
      "rgba(54, 162, 235, 1)",
      "rgba(255, 99, 132, 1)",
      "rgba(255, 206, 86, 1)",
      "rgba(75, 192, 192, 1)",
      "rgba(153, 102, 255, 1)"
    ],
    borderWidth: 1
  }]
};


const popularityConfig = {
  type: "bar",
  data: popularityData,
  options: {
    indexAxis: 'y', 
    responsive: true,
    plugins: {
      legend: {
        display: true,
        position: "top"
      },
      title: {
        display: true,
        text: "So sánh mức độ phổ biến của các loại vải"
      }
    },
    scales: {
      x: {
        title: {
          display: true,
          text: "Mức độ phổ biến (%)"
        },
        beginAtZero: true
      },
      y: {
        title: {
          display: true,
          text: "Loại vải"
        }
      }
    }
  }
};

new Chart(popularityCtx, popularityConfig);

// ================= SỬ LÝ NÚT =================

function updateDropdownButton(dropdownButtonId, itemList) {
  const dropdownButton = document.getElementById(dropdownButtonId);
  const dropdownItems = itemList.querySelectorAll(".dropdown-item");

  dropdownItems.forEach(item => {
      item.addEventListener("click", function () {
          
          dropdownButton.textContent = this.textContent;
      });
  });
}

// Gọi hàm cho từng dropdown
updateDropdownButton("dropdownTimeButton", document.querySelector("#dropdownTimeButton + .dropdown-menu"));
updateDropdownButton("dropdownYearButton", document.querySelector("#dropdownYearButton + .dropdown-menu"));
updateDropdownButton("dropdownMonthButton", document.querySelector("#dropdownMonthButton + .dropdown-menu"));

// Hàm thay đổi nội dung và hiển thị biểu đồ dựa trên lựa chọn dropdown
function updateChartContent(selectedOption) {
  // Ẩn tất cả các biểu đồ
  document.getElementById("revenue-container").style.display = "none";
  document.getElementById("best-saler-container").style.display = "none";
  document.getElementById("popularity-container").style.display = "none";

  // Hiển thị biểu đồ tương ứng với lựa chọn
  if (selectedOption === "Doanh thu theo thời gian") {
      document.getElementById("revenue-container").style.display = "block";
  } else if (selectedOption === "Sản phẩm bán chạy nhất") {
      document.getElementById("best-saler-container").style.display = "block";
  } else if (selectedOption === "Xu hướng mua hàng") {
      document.getElementById("popularity-container").style.display = "block";
  }
}

// Lắng nghe sự kiện click của các mục trong dropdown
function initDropdown() {
  const dropdownItems = document.querySelectorAll("#dropdownTimeButton + .dropdown-menu .dropdown-item");

  dropdownItems.forEach(item => {
      item.addEventListener("click", function () {
          const selectedOption = this.textContent;
          updateChartContent(selectedOption);
      });
  });
}

// Khởi động khi trang được tải
window.onload = function () {
  initDropdown();
  updateChartContent("Xu hướng mua hàng"); // Mặc định hiển thị biểu đồ đầu tiên
};
