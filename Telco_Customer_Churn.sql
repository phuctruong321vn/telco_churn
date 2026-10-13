use telco_churn
go

--Mục tiêu: tối ưu doanh thu và giảm thất thoát dòng tiền hàng tháng

--Tỷ lệ khách hàng rời bỏ và tỷ lệ thất thoát doanh thu tháng
select count(customerID) as Tong_khach,
       sum(case when Churn = 'Yes' then 1 else 0 end) as Khach_huy,
       (sum(case when Churn = 'Yes' then 1.0 else 0.0 end)/count(customerID))*100 as Ty_le_khach_huy,

       sum(MonthlyCharges) as Tong_doanh_thu_thang,
       sum(case when Churn = 'Yes' then MonthlyCharges else 0 end) as Doanh_thu_that_thoat,
       (sum(case when Churn = 'Yes' then MonthlyCharges else 0 end)/sum(MonthlyCharges))*100 as Ty_le_that_thoat_tien
from [Telco-Customer-Churn];

/* Kết luận: => Có khoảng 1/4 khách hàng rời đi (26.5%) nhưng lại mất đến gần 1/3 tổng dòng tiền mỗi tháng (30.5%) 
             => Trung bình những người rời đi đang sử dụng các gói cước đắt đỏ hơn những người chọn ở lại, công ty đang mất đi những khách hàng VIP (chi trả cao)*/

--Câu hỏi 1: Nhóm khách hàng nào (chia theo mức độ chi trả) đang gây ra thiệt hại doanh thu lớn nhất?
with Khach_hang_vip as (
select customerID, MonthlyCharges, Churn,
       NTILE(4) over(order by MonthlyCharges desc) as Nhom_phan_khuc    
from [Telco-Customer-Churn]
)
select Nhom_phan_khuc,
       count(customerID) as Tong_khach,
       sum(MonthlyCharges) as Tong_doanh_thu_thang,
       sum(case when Churn = 'Yes' then MonthlyCharges else 0 end) as Doanh_thu_that_thoat,
       (sum(case when Churn = 'Yes' then MonthlyCharges else 0 end)/sum(MonthlyCharges))*100 as Ty_le_that_thoat_tien
from Khach_hang_vip
group by Nhom_phan_khuc
order by Nhom_phan_khuc asc;
-- Kết luận: Nhóm khách hàng vip (nhóm 1 và 2) có tỷ lệ thất thoát doanh thu cao nhất (32% và 37%)

--Câu hỏi 2: Nhóm khách hàng vip (nhóm 1 và 2) gây thất thoát doanh thu nhiều nhất đang sử dụng hợp đồng (Contract) nào?
with Khach_hang_vip as (
select customerID, MonthlyCharges, Churn,Contract,
       NTILE(4) over(order by MonthlyCharges desc) as Nhom_phan_khuc    
from [Telco-Customer-Churn]
)
select Contract,
       count(customerID) as Tong_khach,
       sum(MonthlyCharges) as Tong_doanh_thu_thang,
       sum(case when Churn = 'Yes' then MonthlyCharges else 0 end) as Doanh_thu_that_thoat,
       (sum(case when Churn = 'Yes' then MonthlyCharges else 0 end)/sum(MonthlyCharges))*100 as Ty_le_that_thoat_tien
from Khach_hang_vip
where Nhom_phan_khuc in (1,2)
group by Contract
order by Ty_le_that_thoat_tien desc;
-- Kết luận: Nhóm khách hàng vip (nhóm 1 và 2) sử dụng hợp đồng month-to-month có tỷ lệ thất thoát tiền cao nhất (52.67%)

--Câu hỏi 3: Nhóm khách hàng vip (nhóm 1 và 2) sử dụng hợp đồng month-to-month rời bỏ nhiều nhất đang dùng loại dịch vụ internet (InternetService) nào?
with Khach_hang_vip as (
select customerID, MonthlyCharges, Churn,Contract,InternetService,
       NTILE(4) over(order by MonthlyCharges desc) as Nhom_phan_khuc    
from [Telco-Customer-Churn]
)
select InternetService,
       count(customerID) as Tong_khach,
       sum(MonthlyCharges) as Tong_doanh_thu_thang,
       sum(case when Churn = 'Yes' then MonthlyCharges else 0 end) as Doanh_thu_that_thoat,
       (sum(case when Churn = 'Yes' then MonthlyCharges else 0 end)/sum(MonthlyCharges))*100 as Ty_le_that_thoat_tien
from Khach_hang_vip
where Nhom_phan_khuc in (1,2) and Contract = 'Month-to-month'
group by InternetService
order by Ty_le_that_thoat_tien desc;
-- Kết luận: Nhóm vip (1 và 2) dùng hợp đồng month-to-month dùng dịch vụ Fiber optic cho tỷ lệ thất thoát tiền cao nhất (53.88%)

-- Câu hỏi 4: Nhóm vip (1và 2) dùng hợp đồng month-to-month + Fiber optic rời bỏ nhiều nhất là do không có hỗ trợ kỹ thuật (TechSupport) đúng không?
with Khach_hang_vip as (
select customerID, MonthlyCharges, Churn,Contract,InternetService,TechSupport,
       NTILE(4) over(order by MonthlyCharges desc) as Nhom_phan_khuc    
from [Telco-Customer-Churn]
)
select TechSupport,
       count(customerID) as Tong_khach,
       sum(MonthlyCharges) as Tong_doanh_thu_thang,
       sum(case when Churn = 'Yes' then MonthlyCharges else 0 end) as Doanh_thu_that_thoat,
       (sum(case when Churn = 'Yes' then MonthlyCharges else 0 end)/sum(MonthlyCharges))*100 as Ty_le_that_thoat_tien
from Khach_hang_vip
where Nhom_phan_khuc in (1,2) and Contract = 'Month-to-month' and InternetService = 'Fiber optic'
group by TechSupport
order by Ty_le_that_thoat_tien desc;
/* Kết luận: Nhóm vip (1và 2) dùng hợp đồng month-to-month + Fiber optic rời bỏ nhiều nhất là do không có hỗ trợ kỹ thuật (TechSupport) với tỷ lệ
thất thoát tiền là 57.2%

=> Nhóm khách hàng vip 1 và 2 chi nhiều tiền cho mạng Fiber optic nhưng khi gặp sự cố lại không được hỗ trợ kỹ thuật, vì là hợp đồng theo tháng 
không có nhiều ràng buộc nên họ rời bỏ ngay lập tức

=>Giải pháp: Tự động tích hợp dịch vụ hỗ trợ kỹ thuật miễn phí cho khách hàng vip đăng ký mạng Fiber optic