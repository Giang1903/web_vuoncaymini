<?php
session_start();
require_once '../includes/db_connect.php';
require_once '../includes/header.php';

if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}

$order_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
$user_id = $_SESSION['user_id'];

// Lấy thông tin đơn hàng
$stmt_order = $pdo->prepare("SELECT d.*, t.TenTrangThai
                             FROM donhang d
                             JOIN trangthaidonhang t ON d.MaTrangThai = t.MaTrangThai
                             WHERE d.MaDonHang = ? AND d.idUser = ?");
$stmt_order->execute([$order_id, $user_id]);
$order = $stmt_order->fetch(PDO::FETCH_ASSOC);

if (!$order) {
    echo "<p>Đơn hàng không tồn tại hoặc bạn không có quyền xem.</p>";
    require_once '../includes/footer.php';
    exit();
}

// Lấy chi tiết đơn hàng
$stmt_details = $pdo->prepare("SELECT c.*, s.TenSanPham, s.HinhAnh
                               FROM chitietdonhang c
                               JOIN sanpham s ON c.MaSanPham = s.MaSanPham
                               WHERE c.MaDonHang = ?");
$stmt_details->execute([$order_id]);
$order_details = $stmt_details->fetchAll(PDO::FETCH_ASSOC);
?>

<div id="content">
    <div class="order-detail-section">
        <h2>Chi tiết đơn hàng</h2>
        <div class="order-info">
            <p><strong>Ngày đặt hàng:</strong> <?php echo date('d/m/Y H:i', strtotime($order['NgayDatHang'])); ?></p>
            <p><strong>Địa chỉ giao hàng:</strong> <?php echo htmlspecialchars($order['DiaChiGiaoHang']); ?></p>
            <p><strong>Trạng thái:</strong> <span class="order-status <?php echo strtolower(str_replace(' ', '-', $order['TenTrangThai'])); ?>"><?php echo htmlspecialchars($order['TenTrangThai']); ?></span></p>
            <p><strong>Ghi chú:</strong> <?php echo htmlspecialchars($order['GhiChu'] ?? 'Không có ghi chú'); ?></p>
        </div>
        <table class="order-detail-table">
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
                <?php foreach ($order_details as $detail): ?>
                    <?php $item_total = $detail['DonGia'] * $detail['SoLuong']; ?>
                    <tr>
                        <td><img src="../<?php echo htmlspecialchars($detail['HinhAnh']); ?>" alt="<?php echo htmlspecialchars($detail['TenSanPham']); ?>" class="order-item-image" /></td>
                        <td><?php echo htmlspecialchars($detail['TenSanPham']); ?></td>
                        <td><?php echo number_format($detail['DonGia'], 0, ',', '.') . ' đ'; ?></td>
                        <td><?php echo $detail['SoLuong']; ?></td>
                        <td><?php echo number_format($item_total, 0, ',', '.') . ' đ'; ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        <div class="order-total">
            <h3>Tổng tiền: <span><?php echo number_format($order['TongTien'], 0, ',', '.') . ' đ'; ?></span></h3>
        </div>
    </div>
</div>
<?php require_once '../includes/footer.php'; ?>