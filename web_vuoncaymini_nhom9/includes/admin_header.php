<?php
// session_start();
if (!isset($_SESSION['admin_id'])) {
    header("Location: ../public/login.php");
    exit;
}

// Xác định trang hiện tại để đánh dấu mục menu đang hoạt động
$current_page = basename($_SERVER['PHP_SELF']);
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản trị cửa hàng</title>
    <link rel="stylesheet" href="../css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
</head>
<body>
    <aside class="sidebar">
        <div class="logo">
            <img src="../img_tree/logo.png" alt="Logo cửa hàng cây cảnh" />
        </div>
        <ul>
            <li class="<?php echo $current_page == 'index.php' ? 'active' : ''; ?>">
                <a href="index.php"><i class="fa-solid fa-house"></i> Tổng quan</a>
            </li>
            <li class="<?php echo $current_page == 'product_management.php' ? 'active' : ''; ?>">
                <a href="product_management.php"><i class="fas fa-leaf"></i> Sản phẩm</a>
            </li>
            <li class="<?php echo $current_page == 'order_management.php' ? 'active' : ''; ?>">
                <a href="order_management.php"><i class="fas fa-shopping-cart"></i> Đơn hàng</a>
            </li>
            <li class="<?php echo $current_page == 'customer_management.php' ? 'active' : ''; ?>">
                <a href="customer_management.php"><i class="fas fa-users"></i> Khách hàng</a>
            </li>
            <li class="<?php echo $current_page == 'post_management.php' ? 'active' : ''; ?>">
                <a href="post_management.php"><i class="fas fa-newspaper"></i> Bài viết</a>
            </li>
            <li class="<?php echo $current_page == 'settings.php' ? 'active' : ''; ?>">
                <a href="settings.php"><i class="fas fa-cog"></i> Cài đặt</a>
            </li>
            <li class="<?php echo $current_page == 'statistics.php' ? 'active' : ''; ?>">
                <a href="statistics.php"><i class="fas fa-chart-pie"></i> Thống kê</a>
            </li>
            <li><a href="../public/logout.php"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
        </ul>
    </aside>
    <div class="content">