<?php
session_start();
include('../includes/db_connect.php');
include('../includes/admin_header.php');

if (!isset($_GET['id'])) {
    header("Location: order_management.php");
    exit;
}

$ma_don_hang = (int)$_GET['id'];

// Lấy thông tin đơn hàng
$stmt = $pdo->prepare("SELECT dh.*, tt.TenTrangThai FROM donhang dh JOIN trangthaidonhang tt ON dh.MaTrangThai = tt.MaTrangThai WHERE dh.MaDonHang = :id");
$stmt->execute([':id' => $ma_don_hang]);
$order = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$order) {
    header("Location: order_management.php");
    exit;
}

// Lấy chi tiết đơn hàng
$stmt = $pdo->prepare("SELECT ctdh.SoLuong, ctdh.DonGia, sp.TenSanPham FROM chitietdonhang ctdh JOIN sanpham sp ON ctdh.MaSanPham = sp.MaSanPham WHERE ctdh.MaDonHang = :id");
$stmt->execute([':id' => $ma_don_hang]);
$order_details = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Lấy danh sách trạng thái đơn hàng
$stmt = $pdo->query("SELECT MaTrangThai, TenTrangThai FROM trangthaidonhang");
$statuses = $stmt->fetchAll(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $ten_khach_hang = htmlspecialchars($_POST['ten_khach_hang']);
    $email = htmlspecialchars($_POST['email']);
    $so_dien_thoai = htmlspecialchars($_POST['so_dien_thoai']);
    $dia_chi = htmlspecialchars($_POST['dia_chi']);
    $ghi_chu = htmlspecialchars($_POST['ghi_chu']);
    $ma_trang_thai = (int)$_POST['ma_trang_thai'];

    // Cập nhật đơn hàng
    $stmt = $pdo->prepare("UPDATE donhang SET TenKhachHang = :ten, Email = :email, SoDienThoai = :sdt, DiaChiGiaoHang = :dia_chi, GhiChu = :ghi_chu, MaTrangThai = :trang_thai WHERE MaDonHang = :id");
    $stmt->execute([
        ':ten' => $ten_khach_hang,
        ':email' => $email,
        ':sdt' => $so_dien_thoai,
        ':dia_chi' => $dia_chi,
        ':ghi_chu' => $ghi_chu,
        ':trang_thai' => $ma_trang_thai,
        ':id' => $ma_don_hang
    ]);

    header("Location: order_management.php");
    exit;
}
?>

<div id="donhang" class="tab-content active">
    <h2>Chỉnh sửa đơn hàng #<?php echo $ma_don_hang; ?></h2>
    <form method="POST">
        <label>Họ tên khách hàng: <input type="text" name="ten_khach_hang" value="<?php echo htmlspecialchars($order['TenKhachHang']); ?>" required></label>
        <label>Email: <input type="email" name="email" value="<?php echo htmlspecialchars($order['Email']); ?>" required></label>
        <label>Số điện thoại: <input type="text" name="so_dien_thoai" value="<?php echo htmlspecialchars($order['SoDienThoai']); ?>" required></label>
        <label>Địa chỉ giao hàng: <textarea name="dia_chi" required><?php echo htmlspecialchars($order['DiaChiGiaoHang']); ?></textarea></label>
        <label>Ghi chú: <textarea name="ghi_chu"><?php echo htmlspecialchars($order['GhiChu']); ?></textarea></label>
        <label>Trạng thái:
            <select name="ma_trang_thai" required>
                <?php foreach ($statuses as $status): ?>
                    <option value="<?php echo $status['MaTrangThai']; ?>" <?php echo $status['MaTrangThai'] == $order['MaTrangThai'] ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($status['TenTrangThai']); ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </label>
        <button type="submit">Lưu</button>
    </form>
    <h3>Chi tiết đơn hàng</h3>
    <table>
        <thead>
            <tr>
                <th>Sản phẩm</th>
                <th>Số lượng</th>
                <th>Đơn giá</th>
                <th>Tổng</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($order_details as $detail): ?>
                <tr>
                    <td><?php echo htmlspecialchars($detail['TenSanPham']); ?></td>
                    <td><?php echo $detail['SoLuong']; ?></td>
                    <td><?php echo number_format($detail['DonGia'], 0, ',', '.'); ?> VNĐ</td>
                    <td><?php echo number_format($detail['SoLuong'] * $detail['DonGia'], 0, ',', '.'); ?> VNĐ</td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<?php include('../includes/admin_footer.php'); ?>