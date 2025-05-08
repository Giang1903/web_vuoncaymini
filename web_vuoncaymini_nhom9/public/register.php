<?php
session_start();
require_once '../includes/db_connect.php';
require_once '../includes/header.php';

$error = '';
$success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $fullname = trim($_POST['fullname']);
    $username = trim($_POST['username']);
    $password = trim($_POST['password']);
    $email = trim($_POST['email']);
    $phone = trim($_POST['phone']);
    $address = trim($_POST['address']);

    if ( empty($fullname) ||empty($username) || empty($password) || empty($email) || empty($phone) || empty($address)) {
        $error = 'Vui lòng nhập đầy đủ thông tin.';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = 'Email không hợp lệ.';
    } elseif (strlen($password) < 6) {
        $error = 'Mật khẩu phải có ít nhất 6 ký tự.';
    } else {
        // Kiểm tra xem tên đăng nhập hoặc email đã tồn tại chưa
        $stmt = $pdo->prepare("SELECT * FROM user WHERE TenDangNhap = ? OR Email = ?");
        $stmt->execute([$username, $email]);
        if ($stmt->fetch()) {
            $error = 'Tên đăng nhập hoặc email đã được sử dụng.';
        } else {
            // Lưu người dùng mới vào cơ sở dữ liệu
            $stmt = $pdo->prepare("INSERT INTO user (HoTen,TenDangNhap, MatKhau, Email,  SoDienThoai, DiaChi, VaiTro, TrangThai) VALUES (?, ?, ?, ?, ?, ?, 'khachhang', 1)");
            $result = $stmt->execute([$fullname,$username, $password, $email,  $phone, $address]); 

            if ($result) {
                $success = 'Đăng ký thành công! Vui lòng <a href="login.php">đăng nhập</a>.';
            } else {
                $error = 'Có lỗi xảy ra khi đăng ký. Vui lòng thử lại.';
            }
        }
    }
}
?>

<div id="content">
    <div class="auth-section"id="auth-section">
        <h2>Đăng ký</h2>
        <?php if ($error): ?>
            <p class="error"><?php echo htmlspecialchars($error); ?></p>
        <?php endif; ?>
        <?php if ($success): ?>
            <p class="success"><?php echo $success; ?></p>
        <?php else: ?>
            <form method="POST" action="register.php">
            <div class="form-group">
                    <label for="fullname">Họ và tên:</label>
                    <input type="text" id="fullname" name="fullname" required value="<?php echo isset($_POST['fullname']) ? htmlspecialchars($_POST['fullname']) : ''; ?>" />
                </div>
                <div class="form-group">
                    <label for="username">Tên đăng nhập:</label>
                    <input type="text" id="username" name="username" required value="<?php echo isset($_POST['username']) ? htmlspecialchars($_POST['username']) : ''; ?>" />
                </div>
                <div class="form-group">
                    <label for="password">Mật khẩu:</label>
                    <input type="password" id="password" name="password" required />
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required value="<?php echo isset($_POST['email']) ? htmlspecialchars($_POST['email']) : ''; ?>" />
                </div>
                <div class="form-group">
                    <label for="phone">Số điện thoại:</label>
                    <input type="text" id="phone" name="phone" required value="<?php echo isset($_POST['phone']) ? htmlspecialchars($_POST['phone']) : ''; ?>" />
                </div>
                <div class="form-group">
                    <label for="address">Địa chỉ:</label>
                    <input type="text" id="address" name="address" required value="<?php echo isset($_POST['address']) ? htmlspecialchars($_POST['address']) : ''; ?>" />
                </div>
                <button type="submit" class="auth-btn">Đăng ký</button>
            </form>
            <p>Đã có tài khoản? <a href="login.php">Đăng nhập</a></p>
        <?php endif; ?>
    </div>
</div>

<?php require_once '../includes/footer.php'; ?>