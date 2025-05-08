<?php
session_start();
include('../includes/db_connect.php');
include('../includes/admin_header.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $ten_cua_hang = htmlspecialchars($_POST['ten_cua_hang']);
    $email_quan_tri = htmlspecialchars($_POST['email_quan_tri']);
    $mat_khau_moi = $_POST['mat_khau_moi'];

    // Cập nhật email
    $stmt = $pdo->prepare("UPDATE user SET Email = :email WHERE idUser = :id AND VaiTro = 'admin'");
    $stmt->execute([':email' => $email_quan_tri, ':id' => $_SESSION['admin_id']]);

    // Cập nhật mật khẩu nếu có
    if (!empty($mat_khau_moi)) {
        $stmt = $pdo->prepare("UPDATE user SET MatKhau = :password WHERE idUser = :id AND VaiTro = 'admin'");
        $stmt->execute([':password' => $mat_khau_moi, ':id' => $_SESSION['admin_id']]);
    }

    echo "<p>Cập nhật cài đặt thành công!</p>";
}
?>

<div id="caidat" class="tab-content active">
    <h2>Cài đặt</h2>
    <form method="POST">
        <label>Tên cửa hàng: <input type="text" name="ten_cua_hang" value="Cửa hàng cây cảnh" /></label>
        <label>Email quản trị: <input type="email" name="email_quan_tri" value="admin@cuahang.com" /></label>
        <label>Mật khẩu mới: <input type="password" name="mat_khau_moi" /></label>
        <button type="submit">Lưu</button>
    </form>
</div>

<?php include('../includes/admin_footer.php'); ?>