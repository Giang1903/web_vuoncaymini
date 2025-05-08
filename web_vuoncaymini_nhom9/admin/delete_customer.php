<?php
session_start();
include('../includes/db_connect.php');

if (!isset($_SESSION['admin_id'])) {
    header("Location: ../public/login.php");
    exit;
}

if (!isset($_GET['id'])) {
    header("Location: customer_management.php");
    exit;
}

$id_user = (int)$_GET['id'];

// Kiểm tra khách hàng tồn tại
$stmt = $pdo->prepare("SELECT idUser FROM user WHERE idUser = :id AND VaiTro = 'khachhang'");
$stmt->execute([':id' => $id_user]);
$customer = $stmt->fetch(PDO::FETCH_ASSOC);

if ($customer) {
    // Xóa chi tiết đơn hàng
    $stmt = $pdo->prepare("DELETE ctdh FROM chitietdonhang ctdh JOIN donhang dh ON ctdh.MaDonHang = dh.MaDonHang WHERE dh.idUser = :id");
    $stmt->execute([':id' => $id_user]);

    // Xóa đơn hàng
    $stmt = $pdo->prepare("DELETE FROM donhang WHERE idUser = :id");
    $stmt->execute([':id' => $id_user]);

    // Xóa giỏ hàng
    $stmt = $pdo->prepare("DELETE FROM giohang WHERE idUser = :id");
    $stmt->execute([':id' => $id_user]);

    // Xóa khách hàng
    $stmt = $pdo->prepare("DELETE FROM user WHERE idUser = :id");
    $stmt->execute([':id' => $id_user]);
}

header("Location: customer_management.php");
exit;
?>