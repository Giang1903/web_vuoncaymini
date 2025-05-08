<?php
require_once 'db_connect.php'; 

$stmt = $pdo->query("SELECT * FROM sanpham WHERE NoiBat = 1 LIMIT 14");
$products = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<div class="product-section" id="featured-products">
    <div id="product-title">SẢN PHẨM MỚI NHẤT </div>
    <div class="product-container">
        <?php foreach ($products as $product): ?>
            <div class="product">
                <a href="../public/product_detail.php?id=<?php echo $product['MaSanPham']; ?>">
                    <img src="<?php echo '../'.htmlspecialchars($product['HinhAnh']); ?>" alt="<?php echo htmlspecialchars($product['TenSanPham']); ?>" />
                </a>
                <div class="product-name"><?php echo htmlspecialchars($product['TenSanPham']); ?></div>
                <div class="product-price"><?php echo number_format($product['Gia'], 0, ',', '.') . ' đ'; ?></div>
                <div class="icons">
                    <button onclick="addToCart(<?php echo $product['MaSanPham']; ?>)"><i class="fa-solid fa-cart-shopping"></i></button>
                    <button onclick="window.location.href='../public/product_detail.php?id=<?php echo $product['MaSanPham']; ?>'"><i class="fa-solid fa-eye"></i></button>
                </div>
            </div>
        <?php endforeach; ?>
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