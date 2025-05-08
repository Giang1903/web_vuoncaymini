<?php
session_start();
include('../includes/db_connect.php');
include('../includes/admin_header.php');

// Lấy danh sách sản phẩm
$stmt = $pdo->query("SELECT MaSanPham, TenSanPham, Gia, SoLuongTon, CASE WHEN SoLuongTon > 0 THEN 'Còn hàng' ELSE 'Hết hàng' END as TrangThai FROM sanpham ORDER BY MaSanPham DESC");
$all_products = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<div id="sanpham" class="tab-content active">
    <h2>Danh sách sản phẩm</h2>
    <a href="edit_product.php" class="action-btn">Thêm sản phẩm</a>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Giá</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($all_products as $product): ?>
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
</div>

<?php include('../includes/admin_footer.php'); ?>