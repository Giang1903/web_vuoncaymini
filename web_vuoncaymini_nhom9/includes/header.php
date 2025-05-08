<?php

require_once '../includes/db_connect.php';


// Lấy danh mục cha từ bảng danhmuc
$stmt = $pdo->query("SELECT * FROM danhmuc WHERE MaDanhMucCha IS NULL AND TrangThai = 1 ORDER BY ThuTuSapXep");
$parent_categories = $stmt->fetchAll(PDO::FETCH_ASSOC);
$category_map = [];
foreach ($parent_categories as $category) {
    $category_map[$category['TenDanhMuc']] = $category['MaDanhMuc'];
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="../css/public.css" /> 
    <title>Vườn cây mini</title>
</head>
<body>
<div id="top-header">
    Hotline: <a href="tel:0343294824">0343294824</a>
    <div class="taikhoan">
        <?php if (isset($_SESSION['user_id'])): ?>
            <!-- Hiển thị họ tên người dùng -->
            <?php echo htmlspecialchars($_SESSION['hoten'] ?? ''); ?>
            <a href="../public/order_history.php"><i class="fa-solid fa-truck"></i> Lịch sử mua hàng</a>
            <a href="../public/cart.php#cart-section"><i class="fa-solid fa-cart-shopping"></i> Giỏ hàng</a>
            <a href="../public/logout.php"><i class="fa-solid fa-sign-out-alt"></i> Đăng xuất</a>
        <?php else: ?>
            <a href="../public/login.php#auth-section"><i class="fa-solid fa-lock"></i> Đăng nhập</a>
            <a href="../public/register.php#auth-section"><i class="fa-solid fa-user-plus"></i> Đăng ký</a>
            <a href="../public/cart.php#cart-section"><i class="fa-solid fa-cart-shopping"></i> Giỏ hàng</a>
        <?php endif; ?>
    </div>
</div>

<header>
    <div class="logo">
        <a href="../public/index.php"> 
            <img src="../img_tree/logo.png" alt="Vườn cây mini" />
        </a>
        <p><em>Sắc xanh thu nhỏ 🌿 - Tươi mát không gian 🌱</em></p>
    </div>
    <div class="search">
        <form id="searchForm" onsubmit="return checkSearch()">
            <input type="text" id="searchBox" placeholder="Tìm kiếm" onfocus="clearSearchBox()" onblur="resetSearchBox()" />
            <input type="submit" value="Tìm kiếm" />
        </form>
    </div>
</header>

<div id="menu">
    <ul>
        <li><a href="../section/about.php#about-section">Giới thiệu</a></li>
        <li><a href="../public/category.php?category_id=<?php echo $category_map['Cây cảnh']; ?>">Cây cảnh</a></li>
        <li><a href="../public/category.php?category_id=<?php echo $category_map['Chậu cảnh']; ?>">Chậu cảnh</a></li>
        <li><a href="../public/category.php?category_id=<?php echo $category_map['Phụ kiện cây cảnh']; ?>">Phụ kiện cây cảnh</a></li>
        <li><a href="../section/services.php#services-section">Dịch vụ</a></li>
        <li><a href="../section/blog.php#blog-section" class="<?php echo $current_page == 'blog.php' || $current_page == 'post_detail.php' ? 'active' : ''; ?>">Tin tức</a></li>
        <li><a href="../section/support.php#support-section">Hỗ trợ</a></li>
        <li><a href="../section/contact.php#contact-section">Liên hệ</a></li>
    </ul>
</div>

<div id="banner">
    <img src="../img_tree/anhlogo.png" alt="">
</div>

<script src="../js/search.js"></script>
</body>
</html>