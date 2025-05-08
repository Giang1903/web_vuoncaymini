<?php
session_start();
include('../includes/db_connect.php');
include('../includes/admin_header.php');

$customer = null;
if (isset($_GET['id'])) {
    $stmt = $pdo->prepare("SELECT * FROM user WHERE idUser = :id AND VaiTro = 'khachhang'");
    $stmt->execute([':id' => $_GET['id']]);
    $customer = $stmt->fetch(PDO::FETCH_ASSOC);
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $ho_ten = htmlspecialchars($_POST['ho_ten']);
    $email = htmlspecialchars($_POST['email']);
    $so_dien_thoai = htmlspecialchars($_POST['so_dien_thoai']);
    $ten_dang_nhap = htmlspecialchars($_POST['ten_dang_nhap']);
    $mat_khau = !empty($_POST['mat_khau']) ? $_POST['mat_khau'] : null;

    if ($customer) {
        // Cập nhật khách hàng
        $query = "UPDATE user SET HoTen = :ho_ten, Email = :email, SoDienThoai = :so_dien_thoai, TenDangNhap = :ten_dang_nhap";
        if ($mat_khau) {
            $query .= ", MatKhau = :mat_khau";
        }
        $query .= " WHERE idUser = :id";
        $stmt = $pdo->prepare($query);
        $params = [
            ':ho_ten' => $ho_ten,
            ':email' => $email,
            ':so_dien_thoai' => $so_dien_thoai,
            ':ten_dang_nhap' => $ten_dang_nhap,
            ':id' => $customer['idUser']
        ];
        if ($mat_khau) {
            $params[':mat_khau'] = $mat_khau;
        }
        $stmt->execute($params);
    } else {
        // Thêm khách hàng mới
        if (!$mat_khau) {
            echo "<p style='color: red;'>Lỗi: Mật khẩu là bắt buộc khi thêm khách hàng mới.</p>";
        } else {
            $stmt = $pdo->prepare("INSERT INTO user (TenDangNhap, MatKhau, Email, HoTen, SoDienThoai, VaiTro, NgayTao, TrangThai) VALUES (:ten_dang_nhap, :mat_khau, :email, :ho_ten, :so_dien_thoai, 'khachhang', NOW(), 1)");
            $stmt->execute([
                ':ten_dang_nhap' => $ten_dang_nhap,
                ':mat_khau' => $mat_khau,
                ':email' => $email,
                ':ho_ten' => $ho_ten,
                ':so_dien_thoai' => $so_dien_thoai
            ]);
            header("Location: customer_management.php");
            exit;
        }
    }
}
?>

<div id="khachhang" class="tab-content active">
    <h2><?php echo $customer ? 'Chỉnh sửa khách hàng' : 'Thêm khách hàng'; ?></h2>
    <form method="POST">
        <label>Tên đăng nhập: <input type="text" name="ten_dang_nhap" value="<?php echo $customer ? htmlspecialchars($customer['TenDangNhap']) : ''; ?>" required></label>
        <?php if (!$customer): ?>
            <label>Mật khẩu: <input type="password" name="mat_khau" required></label>
        <?php else: ?>
            <label>Mật khẩu mới (để trống nếu không đổi): <input type="password" name="mat_khau"></label>
        <?php endif; ?>
        <label>Họ tên: <input type="text" name="ho_ten" value="<?php echo $customer ? htmlspecialchars($customer['HoTen']) : ''; ?>" required></label>
        <label>Email: <input type="email" name="email" value="<?php echo $customer ? htmlspecialchars($customer['Email']) : ''; ?>" required></label>
        <label>Số điện thoại: <input type="text" name="so_dien_thoai" value="<?php echo $customer ? htmlspecialchars($customer['SoDienThoai']) : ''; ?>" required></label>
        <button type="submit">Lưu</button>
    </form>
</div>

<?php include('../includes/admin_footer.php'); ?>