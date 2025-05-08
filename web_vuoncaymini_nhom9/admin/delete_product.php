<?php
session_start();
include('../includes/db_connect.php');

if (!isset($_GET['id'])) {
    header("Location: product_management.php?error=missing_id");
    exit;
}

$ma_san_pham = (int)$_GET['id'];

// Kiểm tra sản phẩm tồn tại
$stmt = $pdo->prepare("SELECT MaSanPham FROM sanpham WHERE MaSanPham = :id");
$stmt->execute([':id' => $ma_san_pham]);
$product = $stmt->fetch(PDO::FETCH_ASSOC);

if ($product) {
    try {
        // Xóa các mục liên quan trong giỏ hàng
        $stmt = $pdo->prepare("DELETE FROM giohang WHERE MaSanPham = :id");
        $stmt->execute([':id' => $ma_san_pham]);

        // Xóa sản phẩm
        $stmt = $pdo->prepare("DELETE FROM sanpham WHERE MaSanPham = :id");
        $stmt->execute([':id' => $ma_san_pham]);

        header("Location: product_management.php?success=deleted");
        exit;
    } catch (PDOException $e) {
        header("Location: product_management.php?error=delete_failed&message=" . urlencode($e->getMessage()));
        exit;
    }
} else {
    header("Location: product_management.php?error=product_not_found");
    exit;
}
?>