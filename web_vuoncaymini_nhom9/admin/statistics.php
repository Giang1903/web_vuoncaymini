<?php
session_start();
include('../includes/db_connect.php');
include('../includes/admin_header.php');

// Thống kê
// Doanh thu tháng này (từ đơn hàng thành công)
$stmt = $pdo->query("SELECT SUM(TongTien) as revenue FROM donhang WHERE MaTrangThai = 4 AND MONTH(NgayDatHang) = MONTH(CURDATE()) AND YEAR(NgayDatHang) = YEAR(CURDATE())");
$monthly_revenue = $stmt->fetch(PDO::FETCH_ASSOC)['revenue'] ?: 0;

// Đơn hàng thành công
$stmt = $pdo->query("SELECT COUNT(*) as total FROM donhang WHERE MaTrangThai = 4 AND MONTH(NgayDatHang) = MONTH(CURDATE()) AND YEAR(NgayDatHang) = YEAR(CURDATE())");
$successful_orders = $stmt->fetch(PDO::FETCH_ASSOC)['total'];

// Đơn hàng mới
$stmt = $pdo->query("SELECT COUNT(*) as total FROM donhang WHERE MaTrangThai = 1 AND MONTH(NgayDatHang) = MONTH(CURDATE()) AND YEAR(NgayDatHang) = YEAR(CURDATE())");
$new_orders = $stmt->fetch(PDO::FETCH_ASSOC)['total'];

// Khách hàng mới
$stmt = $pdo->query("SELECT COUNT(*) as total FROM user WHERE VaiTro = 'khachhang' AND MONTH(NgayTao) = MONTH(CURDATE()) AND YEAR(NgayTao) = YEAR(CURDATE())");
$new_customers = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
?>

<div id="thongke" class="tab-content active">
    <h2>Thống kê</h2>
    <div class="card">Doanh thu tháng này: <?php echo number_format($monthly_revenue, 0, ',', '.'); ?> VNĐ</div>
    <div class="card">Đơn hàng thành công: <?php echo $successful_orders; ?></div>
    <div class="card">Đơn hàng mới: <?php echo $new_orders; ?></div>
    <div class="card">Khách hàng mới: <?php echo $new_customers; ?></div>
</div>

<?php include('../includes/admin_footer.php'); ?>