<?php
session_start();
require_once '../includes/db_connect.php'; 
require_once '../includes/header.php';

$query = isset($_GET['query']) ? trim($_GET['query']) : '';

if ($query) {
    $stmt = $pdo->prepare("SELECT * FROM sanpham WHERE TenSanPham LIKE ? AND SoLuongTon > 0");
    $stmt->execute(['%' . $query . '%']);
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
} else {
    $products = [];
}
?>

<div id="content">
    <?php require_once '../includes/sidebar.php'; ?>
    <div class="product-section">
        <div id="product-title">Kết quả tìm kiếm cho: "<?php echo htmlspecialchars($query); ?>"</div>
        <div class="product-container">
            <?php if (empty($products)): ?>
                <p>Không tìm thấy sản phẩm nào.</p>
            <?php else: ?>
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
            <?php endif; ?>
        </div>
    </div>
</div>

<script>
function addToCart(productId) {
    console.log('addToCart called with productId:', productId);
    let quantity = 1;

    <?php if (isset($_SESSION['user_id'])): ?>
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
    <?php else: ?>
        alert('Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!');
        window.location.href = 'login.php';
    <?php endif; ?>
}
</script>
<script src="../js/search.js"></script>
<?php require_once '../includes/footer.php'; ?>