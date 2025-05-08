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

// Lấy danh sách đơn hàng của người dùng
$stmt_orders = $pdo->prepare("SELECT d.MaDonHang, d.TongTien, d.NgayDatHang, d.DiaChiGiaoHang, t.TenTrangThai
                              FROM donhang d
                              JOIN trangthaidonhang t ON d.MaTrangThai = t.MaTrangThai
                              WHERE d.idUser = ?
                              ORDER BY d.NgayDatHang DESC");
$stmt_orders->execute([$user_id]);
$orders = $stmt_orders->fetchAll(PDO::FETCH_ASSOC);
?>

<div id="content">
    <div class="order-history-section">
        <h2>Lịch sử đơn hàng</h2>
        <?php if (empty($orders)): ?>
            <p>Bạn chưa có đơn hàng nào. <a href="index.php">Mua sắm ngay</a></p>
        <?php else: ?>
            <table class="order-history-table">
                <thead>
                    <tr>
                        <th>Ngày đặt hàng</th>
                        <th>Địa chỉ giao hàng</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Chi tiết</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($orders as $order): ?>
                        <tr>
                            <td><?php echo date('d/m/Y H:i', strtotime($order['NgayDatHang'])); ?></td>
                            <td><?php echo htmlspecialchars($order['DiaChiGiaoHang']); ?></td>
                            <td><?php echo number_format($order['TongTien'], 0, ',', '.') . ' đ'; ?></td>
                            <td>
                                <span class="order-status <?php echo strtolower(str_replace(' ', '-', $order['TenTrangThai'])); ?>">
                                    <?php echo htmlspecialchars($order['TenTrangThai']); ?>
                                </span>
                            </td>
                            <td>
                                <button class="view-details-btn" onclick="window.location.href='order_detail.php?id=<?php echo $order['MaDonHang']; ?>'">
                                    Xem chi tiết
                                </button>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        <?php endif; ?>
    </div>
</div>
<?php require_once '../includes/footer.php'; ?>