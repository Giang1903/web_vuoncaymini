<?php
session_start();
include('../includes/db_connect.php');
include('../includes/admin_header.php');

$stmt = $pdo->query("SELECT dh.MaDonHang, dh.TenKhachHang, dh.NgayDatHang, dh.TongTien, tt.TenTrangThai FROM donhang dh JOIN trangthaidonhang tt ON dh.MaTrangThai = tt.MaTrangThai ORDER BY dh.NgayDatHang DESC");
$all_orders = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<div id="donhang" class="tab-content active">
    <h2>Đơn hàng gần đây</h2>
    <table>
        <thead>
            <tr>
                <th>Mã</th>
                <th>Khách hàng</th>
                <th>Ngày đặt</th>
                <th>Tổng tiền</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($all_orders as $order): ?>
                <tr>
                    <td><?php echo $order['MaDonHang']; ?></td>
                    <td><?php echo htmlspecialchars($order['TenKhachHang']); ?></td>
                    <td><?php echo date('d/m/Y', strtotime($order['NgayDatHang'])); ?></td>
                    <td><?php echo number_format($order['TongTien'], 0, ',', '.'); ?> VNĐ</td>
                    <td><?php echo htmlspecialchars($order['TenTrangThai']); ?></td>
                    <td>
                        <a href="edit_order.php?id=<?php echo $order['MaDonHang']; ?>" class="action-btn">Sửa</a>
                        <a href="delete_order.php?id=<?php echo $order['MaDonHang']; ?>" class="action-btn" onclick="return confirm('Bạn có chắc muốn xóa?');">Xóa</a>
                    </td>
                </tr>
                <?php
                $stmt = $pdo->prepare("SELECT ctdh.SoLuong, ctdh.DonGia, sp.TenSanPham FROM chitietdonhang ctdh JOIN sanpham sp ON ctdh.MaSanPham = sp.MaSanPham WHERE ctdh.MaDonHang = :id");
                $stmt->execute([':id' => $order['MaDonHang']]);
                $details = $stmt->fetchAll(PDO::FETCH_ASSOC);
                if (!empty($details)): ?>
                    <tr>
                        <td colspan="6" class="order-details">
                            <strong>Chi tiết đơn hàng:</strong>
                            <ul>
                                <?php foreach ($details as $detail): ?>
                                    <li><?php echo htmlspecialchars($detail['TenSanPham']); ?> - Số lượng: <?php echo $detail['SoLuong']; ?> - Đơn giá: <?php echo number_format($detail['DonGia'], 0, ',', '.'); ?> VNĐ</li>
                                <?php endforeach; ?>
                            </ul>
                        </td>
                    </tr>
                <?php endif; ?>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<?php include('../includes/admin_footer.php'); ?>