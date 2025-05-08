<?php
session_start();
require_once '../includes/db_connect.php';

header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'message' => 'Vui lòng đăng nhập!']);
    exit();
}

$user_id = $_SESSION['user_id'];
$data = json_decode(file_get_contents('php://input'), true);
$product_id = isset($data['productId']) ? (int)$data['productId'] : 0;
$quantity = isset($data['quantity']) ? (int)$data['quantity'] : 0;

if ($product_id <= 0 || $quantity <= 0) {
    echo json_encode(['success' => false, 'message' => 'Dữ liệu không hợp lệ.']);
    exit();
}

// Kiểm tra tồn kho
$stmt = $pdo->prepare("SELECT SoLuongTon FROM sanpham WHERE MaSanPham = ?");
$stmt->execute([$product_id]);
$product = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$product || $quantity > $product['SoLuongTon']) {
    echo json_encode(['success' => false, 'message' => "Số lượng vượt quá tồn kho ({$product['SoLuongTon']} sản phẩm)."]);
    exit();
}

// Cập nhật số lượng trong giỏ hàng
$stmt = $pdo->prepare("UPDATE giohang SET SoLuong = ? WHERE idUser = ? AND MaSanPham = ?");
$result = $stmt->execute([$quantity, $user_id, $product_id]);

if ($result) {
    echo json_encode(['success' => true, 'message' => 'Cập nhật số lượng thành công!']);
} else {
    echo json_encode(['success' => false, 'message' => 'Có lỗi xảy ra khi cập nhật số lượng.']);
}
?>