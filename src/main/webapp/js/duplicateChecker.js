// js/duplicateChecker.js

/**
 * Gửi yêu cầu POST đến server để kiểm tra xem một giá trị trường (field) đã tồn tại chưa.
 * @param {string} field Tên trường cần kiểm tra ('email' hoặc 'username').
 * @param {string} value Giá trị cần kiểm tra.
 * @returns {Promise<boolean>} Một Promise giải quyết thành true nếu tồn tại, false nếu không tồn tại.
 * @throws {Error} Ném lỗi nếu có sự cố mạng hoặc lỗi server.
 */
async function checkServerForDuplicate(field, value) {
    // URL của Servlet xử lý kiểm tra trùng lặp
    const checkUrl = '/CheckDuplicate';

    // Dữ liệu gửi đi trong body của request
    const requestData = {
        field: field,
        value: value
    };

    console.log(`Checking duplicate for ${field}: ${value}`); // Log để debug

    try {
        const response = await fetch(checkUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                // Có thể thêm các header khác nếu cần (ví dụ: CSRF token)
            },
            body: JSON.stringify(requestData) // Chuyển object thành chuỗi JSON
        });

        // Kiểm tra xem response có thành công không (status code 2xx)
        if (!response.ok) {
            let errorMsg = `Lỗi HTTP: ${response.status}`;
            try {
                // Cố gắng đọc thông báo lỗi từ server nếu có (dạng JSON)
                const errorData = await response.json();
                if (errorData && errorData.message) {
                    errorMsg = errorData.message;
                }
            } catch (e) {
                // Bỏ qua nếu body không phải JSON hoặc rỗng
                console.warn("Could not parse error response body as JSON.");
            }
            // Ném lỗi để báo hiệu request thất bại
            throw new Error(errorMsg);
        }

        // Phân tích cú pháp phản hồi JSON từ server
        const data = await response.json(); // Mong đợi server trả về { "exists": true/false }

        console.log(`Server response for ${field} check:`, data); // Log để debug

        // Trả về kết quả kiểm tra (true nếu tồn tại, false nếu không)
        return data.exists;

    } catch (error) {
        console.error(`Lỗi khi kiểm tra trùng lặp cho ${field}:`, error);
        // Ném lại lỗi để hàm gọi có thể xử lý (ví dụ: hiển thị thông báo lỗi)
        // Có thể tùy chỉnh thông báo lỗi ở đây nếu muốn
        throw new Error(`Không thể xác thực ${field}. Vui lòng thử lại. (${error.message})`);
    }
}

/**
 * Hàm tiện ích để kiểm tra email đã tồn tại chưa.
 * @param {string} email Giá trị email cần kiểm tra.
 * @returns {Promise<boolean>}
 */
export async function checkEmailExists(email) {
    if (!email) return false; // Không cần gọi API nếu email rỗng
    return checkServerForDuplicate('email', email);
}

/**
 * Hàm tiện ích để kiểm tra username đã tồn tại chưa.
 * @param {string} username Giá trị username cần kiểm tra.
 * @returns {Promise<boolean>}
 */
export async function checkUsernameExists(username) {
    if (!username) return false; // Không cần gọi API nếu username rỗng
    return checkServerForDuplicate('username', username);
}

// Không cần export hàm checkServerForDuplicate nếu chỉ dùng nội bộ
// export { checkEmailExists, checkUsernameExists }; // Export các hàm cần thiết