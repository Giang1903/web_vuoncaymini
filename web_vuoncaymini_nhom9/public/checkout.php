<?php
session_start();
require_once '../includes/db_connect.php';
require_once '../includes/header.php';

// Kiểm tra nếu người dùng chưa đăng nhập
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}

$user_id = $_SESSION['user_id'];

// Lấy thông tin người dùng để điền sẵn vào form
$stmt_user = $pdo->prepare("SELECT HoTen, SoDienThoai, DiaChi FROM user WHERE idUser = ?");
$stmt_user->execute([$user_id]);
$user = $stmt_user->fetch(PDO::FETCH_ASSOC);

// Lấy danh sách sản phẩm trong giỏ hàng
$stmt_cart = $pdo->prepare("SELECT g.MaSanPham, g.SoLuong, s.TenSanPham, s.Gia, s.HinhAnh, s.SoLuongTon
                            FROM giohang g
                            JOIN sanpham s ON g.MaSanPham = s.MaSanPham
                            WHERE g.idUser = ?");
$stmt_cart->execute([$user_id]);
$cart_items = $stmt_cart->fetchAll(PDO::FETCH_ASSOC);

$total_price = 0;
foreach ($cart_items as $item) {
    $total_price += $item['Gia'] * $item['SoLuong'];
}

$error = '';
$success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $receiver_name = trim($_POST['receiver_name']);
    $phone = trim($_POST['phone']);
    $address = trim($_POST['address']);
    $note = trim($_POST['note']);
    $email = $user['Email'] ?? '';

    if (empty($receiver_name) || empty($phone) || empty($address)) {
        $error = 'Vui lòng nhập đầy đủ thông tin giao hàng.';
    } elseif (!preg_match('/^[0-9]{10,11}$/', $phone)) {
        $error = 'Số điện thoại không hợp lệ.';
    } else {
        // Kiểm tra tồn kho trước khi đặt hàng
        $stock_error = false;
        foreach ($cart_items as $item) {
            if ($item['SoLuong'] > $item['SoLuongTon']) {
                $stock_error = true;
                $error = "Sản phẩm {$item['TenSanPham']} chỉ còn {$item['SoLuongTon']} trong kho.";
                break;
            }
        }

        if (!$stock_error) {
            try {
                $pdo->beginTransaction();

                // Thêm đơn hàng vào bảng donhang
                $stmt_order = $pdo->prepare("INSERT INTO donhang (idUser, TenKhachHang, Email, SoDienThoai, DiaChiGiaoHang, GhiChu, TongTien, MaTrangThai, NgayDatHang) 
                                             VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())");
                $stmt_order->execute([$user_id, $receiver_name, $email, $phone, $address, $note, $total_price, 1]); // MaTrangThai = 1 (Chờ xác nhận)
                $order_id = $pdo->lastInsertId();

                // Thêm chi tiết đơn hàng vào bảng chitietdonhang
                $stmt_order_detail = $pdo->prepare("INSERT INTO chitietdonhang (MaDonHang, MaSanPham, SoLuong, DonGia) VALUES (?, ?, ?, ?)");
                foreach ($cart_items as $item) {
                    $stmt_order_detail->execute([$order_id, $item['MaSanPham'], $item['SoLuong'], $item['Gia']]);
                    // Cập nhật số lượng tồn kho
                    $stmt_update_stock = $pdo->prepare("UPDATE sanpham SET SoLuongTon = SoLuongTon - ? WHERE MaSanPham = ?");
                    $stmt_update_stock->execute([$item['SoLuong'], $item['MaSanPham']]);
                }

                // Xóa giỏ hàng
                $stmt_clear_cart = $pdo->prepare("DELETE FROM giohang WHERE idUser = ?");
                $stmt_clear_cart->execute([$user_id]);
                $pdo->commit();
                $success = 'Đặt hàng thành công! Đơn hàng của bạn sẽ được xử lý sớm. <a href="order_history.php">Xem lịch sử đơn hàng</a>';
            } catch (Exception $e) {
                $pdo->rollBack();
                $error = 'Có lỗi xảy ra khi đặt hàng: ' . $e->getMessage();
                // Ghi log lỗi vào file để kiểm tra
                error_log("Checkout error: " . $e->getMessage(), 3, '../logs/error.log');
            }
        }
    }
}
?>

<div id="content">
    <div class="checkout-section">
        <h2>Thanh toán</h2>
        <?php if (empty($cart_items)): ?>
            <p>Giỏ hàng của bạn đang trống. <a href="index.php">Mua sắm ngay</a></p>
        <?php else: ?>
            <?php if ($error): ?>
                <p class="error"><?php echo htmlspecialchars($error); ?></p>
            <?php endif; ?>
            <?php if ($success): ?>
                <p class="success"><?php echo $success; ?></p>
            <?php else: ?>
                <div class="checkout-container">
                    <div class="order-summary">
                        <h3>Tóm tắt đơn hàng</h3>
                        <table class="order-table">
                            <thead>
                                <tr>
                                    <th>Hình ảnh</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Đơn giá</th>
                                    <th>Số lượng</th>
                                    <th>Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($cart_items as $item): ?>
                                    <?php $item_total = $item['Gia'] * $item['SoLuong']; ?>
                                    <tr>
                                        <td><img src="../<?php echo htmlspecialchars($item['HinhAnh']); ?>" alt="<?php echo htmlspecialchars($item['TenSanPham']); ?>" class="order-item-image" /></td>
                                        <td><?php echo htmlspecialchars($item['TenSanPham']); ?></td>
                                        <td><?php echo number_format($item['Gia'], 0, ',', '.') . ' đ'; ?></td>
                                        <td><?php echo $item['SoLuong']; ?></td>
                                        <td><?php echo number_format($item_total, 0, ',', '.') . ' đ'; ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                        <div class="order-total">
                            <h3>Tổng tiền: <span><?php echo number_format($total_price, 0, ',', '.') . ' đ'; ?></span></h3>
                        </div>
                    </div>
                    <div class="shipping-info">
                        <h3>Thông tin giao hàng</h3>
                        <form method="POST" action="checkout.php">
                            <div class="form-group">
                                <label for="receiver_name">Họ và tên người nhận:</label>
                                <input type="text" id="receiver_name" name="receiver_name" required value="<?php echo htmlspecialchars($user['HoTen'] ?? ''); ?>" />
                            </div>
                            <div class="form-group">
                                <label for="phone">Số điện thoại:</label>
                                <input type="text" id="phone" name="phone" required value="<?php echo htmlspecialchars($user['SoDienThoai'] ?? ''); ?>" />
                            </div>
                            <div class="form-group">
                                <label for="address">Địa chỉ nhận hàng:</label>
                                <textarea id="address" name="address" required><?php echo htmlspecialchars($user['DiaChi'] ?? ''); ?></textarea>
                            </div>
                            <div class="form-group">
                                <label for="note">Ghi chú (nếu có):</label>
                                <textarea id="note" name="note"></textarea>
                            </div>
                            <button type="submit" class="place-order-btn">Đặt hàng</button>
                        </form>
                    </div>
                </div>
            <?php endif; ?>
        <?php endif; ?>
    </div>
</div>

<?php require_once '../includes/footer.php'; ?>