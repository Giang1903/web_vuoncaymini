<?php
session_start();
require_once '../includes/db_connect.php';
require_once '../includes/header.php';

if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}

$user_id = $_SESSION['user_id'];

$stmt = $pdo->prepare("SELECT g.MaSanPham, g.SoLuong, s.TenSanPham, s.Gia, s.HinhAnh, s.SoLuongTon
                       FROM giohang g
                       JOIN sanpham s ON g.MaSanPham = s.MaSanPham
                       WHERE g.idUser = ?");
$stmt->execute([$user_id]);
$cart_items = $stmt->fetchAll(PDO::FETCH_ASSOC);


$total_price = 0;
?>

<div id="content">
    <div class="cart-section" id="cart-section">
        <h2>Giỏ hàng của bạn</h2>
        <?php if (empty($cart_items)): ?>
            <p>Giỏ hàng của bạn đang trống. <a href="index.php">Mua sắm ngay</a></p>
        <?php else: ?>
            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($cart_items as $item): ?>
                        <?php
                        $item_total = $item['Gia'] * $item['SoLuong'];
                        $total_price += $item_total;
                        ?>
                        <tr>
                            <td><img src="../<?php echo htmlspecialchars($item['HinhAnh']); ?>" alt="<?php echo htmlspecialchars($item['TenSanPham']); ?>" class="cart-item-image" /></td>
                            <td><?php echo htmlspecialchars($item['TenSanPham']); ?></td>
                            <td><?php echo number_format($item['Gia'], 0, ',', '.') . ' đ'; ?></td>
                            <td>
                                <div class="quantity-selector">
                                    <button class="quantity-btn" onclick="updateCartQuantity(<?php echo $item['MaSanPham']; ?>, -1, <?php echo $item['SoLuongTon']; ?>)">-</button>
                                    <input type="text" value="<?php echo $item['SoLuong']; ?>" readonly class="quantity-input" id="quantity-<?php echo $item['MaSanPham']; ?>" />
                                    <button class="quantity-btn" onclick="updateCartQuantity(<?php echo $item['MaSanPham']; ?>, 1, <?php echo $item['SoLuongTon']; ?>)">+</button>
                                </div>
                            </td>
                            <td><?php echo number_format($item_total, 0, ',', '.') . ' đ'; ?></td>
                            <td>
                                <button class="remove-btn" onclick="removeFromCart(<?php echo $item['MaSanPham']; ?>)">Xóa</button>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
            <div class="cart-summary">
                <h3>Tổng tiền: <span id="total-price"><?php echo number_format($total_price, 0, ',', '.') . ' đ'; ?></span></h3>
                <a href="checkout.php" class="checkout-btn">Tiến hành thanh toán</a>
            </div>
        <?php endif; ?>
    </div>
</div>

<script>
function updateCartQuantity(productId, change, stock) {
    console.log('updateCartQuantity called with productId:', productId, 'change:', change, 'stock:', stock);
    let quantityInput = document.getElementById('quantity-' + productId);
    let currentQuantity = parseInt(quantityInput.value);
    let newQuantity = currentQuantity + change;

    if (newQuantity < 1) {
        alert('Số lượng tối thiểu là 1!');
        return;
    }
    if (newQuantity > stock) {
        alert('Số lượng vượt quá tồn kho (' + stock + ' sản phẩm)!');
        return;
    }

    <?php if (isset($_SESSION['user_id'])): ?>
        console.log('User is logged in, sending fetch request');
        fetch('update_cart.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ productId: productId, quantity: newQuantity })
        })
        .then(response => {
            console.log('Fetch response:', response);
            return response.json();
        })
        .then(data => {
            console.log('Response data:', data);
            if (data.success) {
                quantityInput.value = newQuantity;
                window.location.reload();
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Fetch error:', error);
            alert('Có lỗi xảy ra khi cập nhật số lượng.');
        });
    <?php else: ?>
        console.log('User not logged in, redirecting to login');
        alert('Vui lòng đăng nhập để cập nhật giỏ hàng!');
        window.location.href = 'login.php';
    <?php endif; ?>
}
function removeFromCart(productId) {
    console.log('removeFromCart called with productId:', productId);
    <?php if (isset($_SESSION['user_id'])): ?>
        console.log('User is logged in, sending fetch request');
        fetch('remove_cart.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ productId: productId })
        })
        .then(response => {
            console.log('Fetch response:', response);
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            console.log('Response data:', data);
            if (data.success) {
                alert(data.message);
                window.location.reload();
            } else {
                alert('Lỗi: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Fetch error:', error);
            alert('Có lỗi xảy ra khi xóa sản phẩm: ' + error.message);
        });
    <?php else: ?>
        console.log('User not logged in, redirecting to login');
        alert('Vui lòng đăng nhập để xóa sản phẩm!');
        window.location.href = 'login.php';
    <?php endif; ?>
}
</script>

<?php require_once '../includes/footer.php'; ?>