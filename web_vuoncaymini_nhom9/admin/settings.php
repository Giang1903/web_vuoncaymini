<?php
session_start();
include('../includes/db_connect.php');
include('../includes/admin_header.php');
?>

<div id="caidat" class="tab-content active">
    <h2>Cài đặt</h2>
    <form method="POST" action="update_settings.php">
        <label>Tên cửa hàng: <input type="text" name="ten_cua_hang" value="Cửa hàng cây cảnh" /></label>
        <label>Email quản trị: <input type="email" name="email_quan_tri" value="admin@cuahang.com" /></label>
        <label>Mật khẩu mới: <input type="password" name="mat_khau_moi" /></label>
        <button type="submit">Lưu</button>
    </form>
</div>

<?php include('../includes/admin_footer.php'); ?>