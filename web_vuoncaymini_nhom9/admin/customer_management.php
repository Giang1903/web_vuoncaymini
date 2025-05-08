<?php
session_start();
include('../includes/db_connect.php');
include('../includes/admin_header.php');

// Xử lý xóa khách hàng
if (isset($_GET['delete_id'])) {
    $delete_id = $_GET['delete_id'];
    
    // Xóa các đơn hàng liên quan
    $stmt = $pdo->prepare("DELETE FROM donhang WHERE idUser = :id");
    $stmt->execute([':id' => $delete_id]);
    
    // Xóa khách hàng
    $stmt = $pdo->prepare("DELETE FROM user WHERE idUser = :id AND VaiTro = 'khachhang'");
    $stmt->execute([':id' => $delete_id]);
    
    header("Location: customer_management.php");
    exit;
}

// Lấy danh sách khách hàng
$stmt = $pdo->query("SELECT idUser, HoTen, TenDangNhap, Email, SoDienThoai FROM user WHERE VaiTro = 'khachhang' ORDER BY NgayTao DESC");
$all_customers = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<div id="khachhang" class="tab-content active">
    <h2>Danh sách khách hàng</h2>
    <a href="edit_customer.php" class="action-btn" style="margin-bottom: 20px;">Thêm khách hàng mới</a>
    <table>
        <thead>
            <tr>
                <th>Họ tên</th>
                <th>Tên đăng nhập</th>
                <th>Email</th>
                <th>Số điện thoại</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($all_customers as $customer): ?>
                <tr>
                    <td><?php echo htmlspecialchars($customer['HoTen']); ?></td>
                    <td><?php echo htmlspecialchars($customer['TenDangNhap']); ?></td>
                    <td><?php echo htmlspecialchars($customer['Email']); ?></td>
                    <td><?php echo htmlspecialchars($customer['SoDienThoai']); ?></td>
                    <td>
                        <a href="edit_customer.php?id=<?php echo $customer['idUser']; ?>" class="action-btn">Sửa</a>
                        <a href="customer_management.php?delete_id=<?php echo $customer['idUser']; ?>" class="action-btn" style="background-color: #d32f2f;" onclick="return confirm('Bạn có chắc muốn xóa khách hàng này? Các đơn hàng của khách hàng cũng sẽ bị xóa.');">Xóa</a>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<?php include('../includes/admin_footer.php'); ?>