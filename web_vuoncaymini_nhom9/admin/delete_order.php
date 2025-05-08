<?php
session_start();
include('../includes/db_connect.php');

if (!isset($_SESSION['admin_id'])) {
    header("Location: ../login.php");
    exit;
}

if (!isset($_GET['id'])) {
    header("Location: order_management.php");
    exit;
}

$ma_don_hang = (int)$_GET['id'];

// Kiểm tra đơn hàng tồn tại
$stmt = $pdo->prepare("SELECT MaDonHang FROM donhang WHERE MaDonHang = :id");
$stmt->execute([':id' => $ma_don_hang]);
$order = $stmt->fetch(PDO::FETCH_ASSOC);

if ($order) {
    // Xóa chi tiết đơn hàng
    $stmt = $pdo->prepare("DELETE FROM chitietdonhang WHERE MaDonHang = :id");
    $stmt->execute([':id' => $ma_don_hang]);

    // Xóa đơn hàng
    $stmt = $pdo->prepare("DELETE FROM donhang WHERE MaDonHang = :id");
    $stmt->execute([':id' => $ma_don_hang]);
}

header("Location: order_management.php");
exit;
?>