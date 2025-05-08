<?php
session_start();
require_once '../includes/db_connect.php';
header('Content-Type: application/json');
if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'message' => 'Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!']);
    exit();
}

$user_id = $_SESSION['user_id'];
$data = json_decode(file_get_contents('php://input'), true);
$product_id = isset($data['productId']) ? (int)$data['productId'] : 0;
$quantity = isset($data['quantity']) ? (int)$data['quantity'] : 1;

if ($product_id <= 0 || $quantity <= 0) {
    echo json_encode(['success' => false, 'message' => 'Dữ liệu không hợp lệ.']);
    exit();
}

// Kiểm tra sản phẩm có tồn tại và còn hàng không
$stmt = $pdo->prepare("SELECT SoLuongTon FROM sanpham WHERE MaSanPham = ? AND SoLuongTon > 0");
$stmt->execute([$product_id]);
$product = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$product) {
    echo json_encode(['success' => false, 'message' => 'Sản phẩm không tồn tại hoặc đã hết hàng.']);
    exit();
}

// Kiểm tra số lượng tồn kho
if ($quantity > $product['SoLuongTon']) {
    echo json_encode(['success' => false, 'message' => "Số lượng yêu cầu vượt quá tồn kho ({$product['SoLuongTon']} sản phẩm)."]);
    exit();
}

// Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
$stmt = $pdo->prepare("SELECT * FROM giohang WHERE idUser = ? AND MaSanPham = ?");
$stmt->execute([$user_id, $product_id]);
$cart_item = $stmt->fetch(PDO::FETCH_ASSOC);

if ($cart_item) {
    // Cập nhật số lượng nếu sản phẩm đã có trong giỏ
    $new_quantity = $cart_item['SoLuong'] + $quantity;
    if ($new_quantity > $product['SoLuongTon']) {
        echo json_encode(['success' => false, 'message' => "Tổng số lượng vượt quá tồn kho ({$product['SoLuongTon']} sản phẩm)."]);
        exit();
    }
    $stmt = $pdo->prepare("UPDATE giohang SET SoLuong = ? WHERE idUser = ? AND MaSanPham = ?");
    $result = $stmt->execute([$new_quantity, $user_id, $product_id]);
} else {
    // Thêm sản phẩm mới vào giỏ
    $stmt = $pdo->prepare("INSERT INTO giohang (idUser, MaSanPham, SoLuong) VALUES (?, ?, ?)");
    $result = $stmt->execute([$user_id, $product_id, $quantity]);
}

if ($result) {
    echo json_encode(['success' => true, 'message' => "Đã thêm $quantity sản phẩm vào giỏ hàng!"]);
} else {
    echo json_encode(['success' => false, 'message' => 'Có lỗi xảy ra khi thêm vào giỏ hàng.']);
}
?>