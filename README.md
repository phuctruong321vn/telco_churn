# Telecom Customer Churn

## 1. Business Problem
Công ty Viễn thông đang đối mặt với rủi ro thất thoát dòng tiền hàng tháng lên tới **30.5%** tổng doanh thu do khách hàng rời bỏ (Churn). 
Dự án này được thực hiện nhằm mục đích: Đào sâu tìm ra nguyên nhân gốc rễ gây chảy máu doanh thu và đề xuất giải pháp giữ chân nhóm khách hàng mang lại giá trị cao nhất (VIP).

## 2. Tech Stack
*   **Data Extraction & Analysis:** SQL Server (SSMS) - Sử dụng CTEs, Window Functions (NTILE), Case When, Aggregation.
*   **Data Visualization:** Power BI - Xây dựng Executive Dashboard với các chỉ số KPI động và tính năng Cross-filtering.

## 3. Key Insights (Phân tích nguyên nhân gốc rễ)
Qua 4 lớp bóc tách dữ liệu bằng SQL đã tìm ra điểm đứt gãy lớn nhất:
1.  **Chảy máu ở nhóm VIP:** Nhóm khách hàng chi trả cao nhất (Nhóm 1 & 2 - Top 50%) lại chính là nhóm có tỷ lệ thất thoát tiền cao nhất (32% và 37%).
2.  **Rủi ro ràng buộc :** Nhóm VIP này rời bỏ chủ yếu do họ đang sử dụng Hợp đồng ngắn hạn từng tháng (Month-to-month).
3.  **Trải nghiệm dịch vụ :** Đa số khách VIP dùng hợp đồng tháng đang sử dụng dịch vụ mạng Cáp quang (Fiber optic).
4.  **CHỐT HẠ - Nguyên nhân trực tiếp:** Cứ 100 đồng thu được từ nhóm VIP xài Cáp quang không được tích hợp Hỗ trợ kỹ thuật (TechSupport = No), công ty mất đi **57.2** đồng.

## 4. Actionable Recommendation
**Đề xuất :** Tự động tích hợp và miễn phí dịch vụ Hỗ trợ kỹ thuật (TechSupport) cho mọi khách hàng VIP đăng ký mạng Cáp quang. Dù tốn thêm chi phí vận hành đội kỹ thuật, giải pháp này sẽ trực tiếp cứu vãn cục doanh thu đang bốc hơi mỗi tháng.

## 5. Dashboard Visualization
*(Xem chi tiết trong file .pbix đính kèm)*

**1. Tổng quan Dashboard **
<img width="824" height="461" alt="image" src="https://github.com/user-attachments/assets/355a2b8a-83a5-4cc4-b986-26afcb6f20fd" />

**2. Dashboard tương tác (Lọc chéo riêng nhóm VIP 1 & 2)**
<img width="820" height="456" alt="image" src="https://github.com/user-attachments/assets/9035385c-cc64-4095-bf46-20da0801d44e" />
