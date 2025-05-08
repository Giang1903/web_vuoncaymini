<?php
session_start();
require_once '../includes/db_connect.php';
require_once '../includes/header.php';

$product_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($product_id > 0) {
    $stmt = $pdo->prepare("SELECT * FROM sanpham WHERE MaSanPham = ?");
    $stmt->execute([$product_id]);
    $product = $stmt->fetch(PDO::FETCH_ASSOC);
}

if (!$product) {
    echo "<p>Sản phẩm không tồn tại.</p>";
    require_once '../includes/footer.php';
    exit();
}

$details = [];
if (!empty($product['ChiTietSanPham'])) {
    $lines = explode("\r\n", $product['ChiTietSanPham']);
    $current_section = '';
    foreach ($lines as $line) {
        $line = trim($line);
        if (empty($line)) continue;
        if (preg_match('/^[A-Za-z\sÀ-ỹ]+$/u', $line)) {
            $current_section = $line;
            $details[$current_section] = [];
        } elseif ($current_section && !empty($line)) {
            if (strpos($line, ':') !== false) {
                list($key, $value) = array_map('trim', explode(':', $line, 2));
                $details[$current_section][$key] = $value;
            } else {
                $details[$current_section][] = $line;
            }
        }
    }
}
?>

<div id="content">
    <?php require_once '../includes/sidebar.php'; ?>
    <div class="product-section">
        <div class="product-detail-container">
            <div class="product-image">
                <img src="../<?php echo htmlspecialchars($product['HinhAnh']); ?>" alt="<?php echo htmlspecialchars($product['TenSanPham']); ?>" />
                <div class="thumbnail-gallery">
                    <img src="../<?php echo htmlspecialchars($product['HinhAnh']); ?>" alt="Thumbnail 1" />
                </div>
            </div>
            <div class="product-info">
                <h1><?php echo htmlspecialchars($product['TenSanPham']); ?></h1>
                <p class="product-description">
                    <?php echo nl2br(htmlspecialchars($product['MoTa'] ?? 'Không có mô tả.')); ?>
                </p>
                <p class="stock-status"><strong>Tình trạng:</strong> <span class="in-stock"><?php echo ($product['SoLuongTon'] > 0) ? 'Còn hàng' : 'Hết hàng'; ?></span></p>
                <p><strong>Giá:</strong> <?php echo number_format($product['Gia'], 0, ',', '.') . ' đ'; ?></p>
                <div class="quantity-selector">
                    <button class="quantity-btn" onclick="updateQuantity(-1)">-</button>
                    <input type="text" id="quantity" value="1" readonly />
                    <button class="quantity-btn" onclick="updateQuantity(1)">+</button>
                </div>
                <div class="product-actions">
                    <button class="buy-now" onclick="buyNow(<?php echo $product['MaSanPham']; ?>, document.getElementById('quantity').value)">MUA NGAY</button>
                    <button class="add-to-cart" onclick="addToCart(<?php echo $product['MaSanPham']; ?>, document.getElementById('quantity').value)">THÊM VÀO GIỎ HÀNG</button>
                </div>
                <div class="contact-info">
                    <p><i class="fa-solid fa-phone"></i> <a href="tel:0343294824">0343294824</a></p>
                </div>
            </div>
        </div>

        <div class="product-details">
            <h2 class="detail-title">CHI TIẾT SẢN PHẨM</h2>
            <div class="product-detail-content">
                <?php
                if (!empty($details)) {
                    foreach($details as $section => $items) {
                        if (in_array($section, ['Giới thiệu', 'Lưu ý', 'Lưu ý khi trồng'])) continue;
                        echo "<h4 class='detail-subtitle'>" . htmlspecialchars($section) . "</h4>";
                        if (isset($items[0])) {
                            echo "<ul>";
                            foreach ($items as $item) {
                                echo "<li>" . htmlspecialchars($item) . "</li>";
                            }
                            echo "</ul>";
                        } else {
                            echo "<ul>";
                            foreach ($items as $key => $value) {
                                echo "<li><strong>" . htmlspecialchars($key) . ":</strong> " . htmlspecialchars($value) . "</li>";
                            }
                            echo "</ul>";
                        }
                    }
                } else {
                    echo "<p>Không có chi tiết sản phẩm.</p>";
                }
                ?>
            </div>
        </div>

        <div class="store-info">
            <h3>VƯỜN CÂY MINI CAM KẾT:</h3>
            <p>- Cung cấp các loại cây cảnh để bàn và các loại cây hợp lý</p>
            <p>- Miễn phí giao hàng cho đơn hàng từ 500.000đ (áp dụng tại các quận nội thành TP.HCM)</p>
            <p>- Tư vấn kỹ thuật trồng và chăm sóc cây tận tình</p>
            <p>- Hỗ trợ đổi trả sản phẩm trong vòng 3 ngày sau khi mua</p>
        </div>
        <?php
// Lấy các sản phẩm tương tự (cùng danh mục, trừ sản phẩm hiện tại)
$stmt_similar = $pdo->prepare("SELECT * FROM sanpham WHERE MaDanhMuc = ? AND MaSanPham != ? LIMIT 8");
$stmt_similar->execute([$product['MaDanhMuc'], $product['MaSanPham']]);
$similar_products = $stmt_similar->fetchAll(PDO::FETCH_ASSOC);
?>

<div class="product-details">
<h2 class="detail-title">SẢN PHẨM TƯƠNG TỰ</h2>
    <div class="product-container">
        <?php if (empty($similar_products)): ?>
            <p>Không có sản phẩm tương tự.</p>
        <?php else: ?>
            <?php foreach ($similar_products as $similar_product): ?>
                <div class="product">
                    <a href="../public/product_detail.php?id=<?php echo $similar_product['MaSanPham']; ?>">
                        <img src="../<?php echo htmlspecialchars($similar_product['HinhAnh']); ?>" alt="<?php echo htmlspecialchars($similar_product['TenSanPham']); ?>" />
                    </a>
                    <div class="product-name"><?php echo htmlspecialchars($similar_product['TenSanPham']); ?></div>
                    <div class="product-price"><?php echo number_format($similar_product['Gia'], 0, ',', '.') . ' đ'; ?></div>
                    <div class="icons">
                        <button onclick="addToCart(<?php echo $similar_product['MaSanPham']; ?>)"><i class="fa-solid fa-cart-shopping"></i></button>
                        <button onclick="window.location.href='../public/product_detail.php?id=<?php echo $similar_product['MaSanPham']; ?>'"><i class="fa-solid fa-eye"></i></button>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>
</div>
    </div>
</div>

<script>
function updateQuantity(change) {
    let quantityInput = document.getElementById('quantity');
    let currentQuantity = parseInt(quantityInput.value);
    let newQuantity = currentQuantity + change;
    if (newQuantity >= 1) {
        quantityInput.value = newQuantity;
    }
}

function addToCart(productId, quantity) {
    quantity = parseInt(quantity);
    if (quantity <= 0) {
        alert('Số lượng không hợp lệ!');
        return;
    }

    <?php if (isset($_SESSION['user_id'])): ?>
        fetch('add_to_cart.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ productId: productId, quantity: quantity })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            alert('Có lỗi xảy ra khi thêm vào giỏ hàng.');
            console.error(error);
        });
    <?php else: ?>
        alert('Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!');
        window.location.href = 'login.php';
    <?php endif; ?>
}

function buyNow(productId, quantity) {
    quantity = parseInt(quantity);
    if (quantity <= 0) {
        alert('Số lượng không hợp lệ!');
        return;
    }

    <?php if (isset($_SESSION['user_id'])): ?>
        fetch('add_to_cart.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ productId: productId, quantity: quantity })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                window.location.href = 'checkout.php';
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            alert('Có lỗi xảy ra khi thêm vào giỏ hàng.');
            console.error(error);
        });
    <?php else: ?>
        alert('Vui lòng đăng nhập để mua sản phẩm!');
        window.location.href = 'login.php';
    <?php endif; ?>
}
</script>

<?php require_once '../includes/footer.php'; ?>