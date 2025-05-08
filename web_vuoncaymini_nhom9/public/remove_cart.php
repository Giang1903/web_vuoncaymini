<?php
session_start();
require_once '../includes/db_connect.php';

// Kiểm tra đăng nhập
if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'message' => 'Vui lòng đăng nhập để xóa sản phẩm khỏi giỏ hàng!']);
    exit();
}

$user_id = $_SESSION['user_id'];

// Kiểm tra dữ liệu gửi từ khach hang
$input = json_decode(file_get_contents('php://input'), true);
if (!isset($input['productId']) || !is_numeric($input['productId'])) {
    echo json_encode(['success' => false, 'message' => 'Mã sản phẩm không hợp lệ!']);
    exit();
}

$product_id = (int)$input['productId'];

// Kiểm tra sản phẩm trong giỏ hàng
$stmt_check = $pdo->prepare("SELECT * FROM giohang WHERE idUser = ? AND MaSanPham = ?");
$stmt_check->execute([$user_id, $product_id]);
$cart_item = $stmt_check->fetch(PDO::FETCH_ASSOC);

if (!$cart_item) {
    echo json_encode(['success' => false, 'message' => 'Sản phẩm không tồn tại trong giỏ hàng của bạn!']);
    exit();
}

// Xóa sản phẩm khỏi giỏ hàng
try {
    $stmt = $pdo->prepare("DELETE FROM giohang WHERE idUser = ? AND MaSanPham = ?");
    $result = $stmt->execute([$user_id, $product_id]);

    if ($result) {
        echo json_encode(['success' => true, 'message' => 'Đã xóa sản phẩm khỏi giỏ hàng thành công!']);
    } else {
        error_log("Không thể xóa sản phẩm: user_id=$user_id, product_id=$product_id");
        echo json_encode(['success' => false, 'message' => 'Không thể xóa sản phẩm. Vui lòng thử lại!']);
    }
} catch (PDOException $e) {
    error_log("Lỗi khi xóa sản phẩm: " . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Có lỗi xảy ra khi xóa sản phẩm: ' . $e->getMessage()]);
}

exit();