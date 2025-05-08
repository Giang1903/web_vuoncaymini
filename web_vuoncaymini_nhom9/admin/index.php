<?php
session_start();
include('../includes/db_connect.php');
include('../includes/admin_header.php');

// Tổng đơn hàng
$stmt = $pdo->query("SELECT COUNT(*) as total FROM donhang");
$total_orders = $stmt->fetch(PDO::FETCH_ASSOC)['total'];

// Tổng doanh thu (đơn hàng hoàn thành)
$stmt = $pdo->query("SELECT SUM(TongTien) as revenue FROM donhang WHERE MaTrangThai = 4");
$total_revenue = $stmt->fetch(PDO::FETCH_ASSOC)['revenue'] ?: 0;

// Sản phẩm
$stmt = $pdo->query("SELECT MaSanPham, TenSanPham, Gia, SoLuongTon, CASE WHEN SoLuongTon > 0 THEN 'Còn hàng' ELSE 'Hết hàng' END as TrangThai FROM sanpham ORDER BY MaSanPham DESC LIMIT 5");
$products = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Đơn hàng gần đây
$stmt = $pdo->query("SELECT dh.MaDonHang, dh.TenKhachHang, dh.NgayDatHang, dh.TongTien, tt.TenTrangThai FROM donhang dh JOIN trangthaidonhang tt ON dh.MaTrangThai = tt.MaTrangThai ORDER BY dh.NgayDatHang DESC LIMIT 5");
$recent_orders = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<div id="tongquan" class="tab-content">
    <header style="display: flex; justify-content: space-between; align-items: center;">
        <h1>Tổng quan</h1>
        <div class="taikhoan">
            <a href="#">Nhóm 9</a> | 
            <a href="../public/logout.php">Đăng xuất</a>
        </div>
    </header>
    <section class="dashboard" style="display: flex; gap: 20px; margin-top: 20px;">
        <div class="card">
            <h2>Tổng số đơn hàng</h2>
            <p><?php echo $total_orders; ?></p>
        </div>
        <div class="card">
            <h2>Tổng doanh thu</h2>
            <p><?php echo number_format($total_revenue, 0, ',', '.'); ?> VNĐ</p>
        </div>
    </section>
    <main class="main-content">
        <h2>Danh Sách Sản Phẩm</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên Sản Phẩm</th>
                    <th>Giá</th>
                    <th>Trạng Thái</th>
                    <th>Thao Tác</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($products as $product): ?>
                    <tr>
                        <td><?php echo $product['MaSanPham']; ?></td>
                        <td><?php echo htmlspecialchars($product['TenSanPham']); ?></td>
                        <td><?php echo number_format($product['Gia'], 0, ',', '.'); ?> VNĐ</td>
                        <td><?php echo $product['TrangThai']; ?></td>
                        <td>
                            <a href="edit_product.php?id=<?php echo $product['MaSanPham']; ?>" class="action-btn">Sửa</a>
                            <a href="delete_product.php?id=<?php echo $product['MaSanPham']; ?>" class="action-btn" onclick="return confirm('Bạn có chắc muốn xóa?');">Xóa</a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        <section class="recent-orders">
            <h2>Đơn hàng gần đây</h2>
            <table>
                <thead>
                    <tr>
                        <th>Mã đơn hàng</th>
                        <th>Khách hàng</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($recent_orders as $order): ?>
                        <tr>
                            <td><?php echo $order['MaDonHang']; ?></td>
                            <td><?php echo htmlspecialchars($order['TenKhachHang']); ?></td>
                            <td><?php echo date('d/m/Y', strtotime($order['NgayDatHang'])); ?></td>
                            <td><?php echo number_format($order['TongTien'], 0, ',', '.'); ?> VNĐ</td>
                            <td><?php echo htmlspecialchars($order['TenTrangThai']); ?></td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </section>
    </main>
</div>

<?php include('../includes/admin_footer.php'); ?>