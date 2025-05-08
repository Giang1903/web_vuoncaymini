<?php
session_start();
require_once '../includes/db_connect.php';
require_once '../includes/header.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username']);
    $password = trim($_POST['password']);

    if (empty($username) || empty($password)) {
        $error = 'Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.';
    } else {
        $stmt = $pdo->prepare("SELECT idUser, MatKhau, VaiTro,HoTen FROM user WHERE TenDangNhap = :username AND TrangThai = 1");
        $stmt->execute([':username' => $username]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user && $password === $user['MatKhau']) {
            $_SESSION['user_id'] = $user['idUser'];
            $_SESSION['hoten'] = $user['HoTen'];
            if ($user['VaiTro'] == 'admin') {
                $_SESSION['admin_id'] = $user['idUser'];
                header("Location: ../admin/index.php");
            } else {
                header("Location: index.php");
            }
            exit;
        } else {
            $error = "Tên đăng nhập hoặc mật khẩu không đúng!";
        }
    }
}
?>
<div id="content">
    <div class="auth-section" id="auth-section">
        <h2>Đăng nhập</h2>
        <?php if (isset($error)): ?>
            <p class="error"><?php echo htmlspecialchars($error); ?></p>
        <?php endif; ?>
        <form method="POST" action="login.php">
            <div class="form-group">
                <label for="username">Tên đăng nhập:</label>
                <input type="text" id="username" name="username" required />
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu:</label>
                <input type="password" id="password" name="password" required />
            </div>
            <button type="submit" class="auth-btn">Đăng nhập</button>
        </form>
        <p>Chưa có tài khoản? <a href="register.php">Đăng ký ngay</a></p>
    </div>
</div>

<?php require_once '../includes/footer.php'; ?>