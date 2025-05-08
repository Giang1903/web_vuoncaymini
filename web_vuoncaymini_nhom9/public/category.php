<?php
session_start();
require_once '../includes/db_connect.php';
require_once '../includes/header.php';

function getSubcategoryIds($pdo, $category_id) {
    $category_ids = [$category_id]; 
    $stmt = $pdo->prepare("SELECT MaDanhMuc FROM danhmuc WHERE MaDanhMucCha = ? AND TrangThai = 1");
    $stmt->execute([$category_id]);
    $subcategories = $stmt->fetchAll(PDO::FETCH_COLUMN);
    foreach ($subcategories as $subcategory_id) {
        $category_ids = array_merge($category_ids, getSubcategoryIds($pdo, $subcategory_id));
    }
    return $category_ids;
}

$category_id = isset($_GET['category_id']) ? (int)$_GET['category_id'] : 0;
$stmt_category = $pdo->prepare("SELECT * FROM danhmuc WHERE MaDanhMuc = ? AND TrangThai = 1");
$stmt_category->execute([$category_id]);
$category = $stmt_category->fetch(PDO::FETCH_ASSOC);

if (!$category) {
    echo "<p>Danh mục không tồn tại.</p>";
    require_once '../includes/footer.php';
    exit();
}

$category_ids = getSubcategoryIds($pdo, $category_id);
$placeholders = implode(',', array_fill(0, count($category_ids), '?')); 
$stmt_products = $pdo->prepare("SELECT * FROM sanpham WHERE MaDanhMuc IN ($placeholders) AND SoLuongTon > 0 ORDER BY NgayTao DESC");
$stmt_products->execute($category_ids);
$products = $stmt_products->fetchAll(PDO::FETCH_ASSOC);
?>

<div id="content">
    <?php require_once '../includes/sidebar.php'; ?>
    <div class="product-section">
        <div id="product-title"><?php echo htmlspecialchars($category['TenDanhMuc']); ?></div>
        <div class="product-description"><?php echo nl2br(htmlspecialchars($category['mota'])); ?></div>
        <?php if (!empty($products)): ?>
            <div class="product-container">
                <?php foreach ($products as $product): ?>
                    <div class="product">
                        <a href="product_detail.php?id=<?php echo $product['MaSanPham']; ?>">
                            <img src="../<?php echo htmlspecialchars($product['HinhAnh']); ?>" alt="<?php echo htmlspecialchars($product['TenSanPham']); ?>" />
                        </a>
                        <div class="product-name"><?php echo htmlspecialchars($product['TenSanPham']); ?></div>
                        <div class="product-price"><?php echo number_format($product['Gia'], 0, ',', '.') . ' đ'; ?></div>
                        <div class="icons">
                            <button onclick="addToCart(<?php echo $product['MaSanPham']; ?>)"><i class="fa-solid fa-cart-shopping"></i></button>
                            <button onclick="window.location.href='product_detail.php?id=<?php echo $product['MaSanPham']; ?>'"><i class="fa-solid fa-eye"></i></button>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php else: ?>
            <p>Không có sản phẩm nào trong danh mục này.</p>
        <?php endif; ?>
    </div>
</div>
<script>
function addToCart(productId) {
    console.log('addToCart called with productId:', productId);
    let quantity = 1;
    fetch('add_to_cart.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ productId: productId, quantity: quantity })
    })
    .then(response => {
        console.log('Fetch response:', response);
        return response.json();
    })
    .then(data => {
        console.log('Response data:', data);
        if (data.success) {
            alert(data.message);
        } else {
            alert(data.message);
        }
    })
    .catch(error => {
        console.error('Fetch error:', error);
        alert('Có lỗi xảy ra khi thêm vào giỏ hàng.');
    });
}
</script>
<?php require_once '../includes/footer.php'; ?>