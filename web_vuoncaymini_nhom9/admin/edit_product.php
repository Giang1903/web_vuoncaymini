<?php
session_start();
include('../includes/db_connect.php');
include('../includes/admin_header.php');

function generateSlug($string) {
    $slug = strtolower($string);
    $slug = preg_replace('/[^a-z0-9]+/', '-', $slug);
    $slug = trim($slug, '-');
    return $slug;
}
function ensureUniqueSlug($pdo, $slug, $excludeId = null) {
    $baseSlug = $slug;
    $counter = 1;
    while (true) {
        $stmt = $pdo->prepare("SELECT COUNT(*) FROM sanpham WHERE DuongDan = :slug" . ($excludeId ? " AND MaSanPham != :id" : ""));
        $params = [':slug' => $slug];
        if ($excludeId) {
            $params[':id'] = $excludeId;
        }
        $stmt->execute($params);
        if ($stmt->fetchColumn() == 0) {
            return $slug;
        }
        $slug = $baseSlug . '-' . $counter++;
    }
}

$product = null;
if (isset($_GET['id'])) {
    $stmt = $pdo->prepare("SELECT * FROM sanpham WHERE MaSanPham = :id");
    $stmt->execute([':id' => $_GET['id']]);
    $product = $stmt->fetch(PDO::FETCH_ASSOC);
}

// Lấy danh mục
$stmt = $pdo->query("SELECT MaDanhMuc, TenDanhMuc FROM danhmuc WHERE TrangThai = 1");
$categories = $stmt->fetchAll(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $ten_san_pham = htmlspecialchars($_POST['ten_san_pham']);
    $duong_dan = !empty($_POST['duong_dan']) ? generateSlug($_POST['duong_dan']) : generateSlug($ten_san_pham);
    $gia = (float)$_POST['gia'];
    $so_luong_ton = (int)$_POST['so_luong_ton'];
    $mo_ta = htmlspecialchars($_POST['mo_ta']);
    $chi_tiet = htmlspecialchars($_POST['chi_tiet']);
    $noi_bat = isset($_POST['noi_bat']) ? 1 : 0;
    $ma_danh_muc = (int)$_POST['ma_danh_muc'];
    $hinh_anh = $product ? $product['HinhAnh'] : '';

    $duong_dan = ensureUniqueSlug($pdo, $duong_dan, $product ? $product['MaSanPham'] : null);

    // Xử lý tải lên hình ảnh
    if (isset($_FILES['hinh_anh']) && $_FILES['hinh_anh']['error'] == UPLOAD_ERR_OK) {
        $upload_dir = '../img_tree/';
        $file_name = basename($_FILES['hinh_anh']['name']);
        $file_path = $upload_dir . time() . '_' . $file_name;
        $relative_path = 'img_tree/' . time() . '_' . $file_name;

        // Kiểm tra loại tệp (chỉ cho phép hình ảnh)
        $allowed_types = ['image/jpeg', 'image/png', 'image/gif'];
        $file_type = mime_content_type($_FILES['hinh_anh']['tmp_name']);
        if (in_array($file_type, $allowed_types) && move_uploaded_file($_FILES['hinh_anh']['tmp_name'], $file_path)) {
            $hinh_anh = $relative_path;
        } else {
            echo "<p style='color: red;'>Lỗi: Chỉ hỗ trợ tệp hình ảnh (JPEG, PNG, GIF).</p>";
            $hinh_anh = $product ? $product['HinhAnh'] : '';
        }
    }

    if ($product) {
        // Cập nhật sản phẩm
        $stmt = $pdo->prepare("UPDATE sanpham SET TenSanPham = :ten, DuongDan = :duong_dan, Gia = :gia, SoLuongTon = :so_luong, HinhAnh = :hinh_anh, MoTa = :mo_ta, ChiTietSanPham = :chi_tiet, NoiBat = :noi_bat, MaDanhMuc = :ma_danh_muc WHERE MaSanPham = :id");
        $stmt->execute([
            ':ten' => $ten_san_pham,
            ':duong_dan' => $duong_dan,
            ':gia' => $gia,
            ':so_luong' => $so_luong_ton,
            ':hinh_anh' => $hinh_anh,
            ':mo_ta' => $mo_ta,
            ':chi_tiet' => $chi_tiet,
            ':noi_bat' => $noi_bat,
            ':ma_danh_muc' => $ma_danh_muc,
            ':id' => $product['MaSanPham']
        ]);
    } else {
        // Thêm sản phẩm mới
        $stmt = $pdo->prepare("INSERT INTO sanpham (TenSanPham, DuongDan, Gia, SoLuongTon, HinhAnh, MoTa, ChiTietSanPham, NoiBat, MaDanhMuc) VALUES (:ten, :duong_dan, :gia, :so_luong, :hinh_anh, :mo_ta, :chi_tiet, :noi_bat, :ma_danh_muc)");
        $stmt->execute([
            ':ten' => $ten_san_pham,
            ':duong_dan' => $duong_dan,
            ':gia' => $gia,
            ':so_luong' => $so_luong_ton,
            ':hinh_anh' => $hinh_anh,
            ':mo_ta' => $mo_ta,
            ':chi_tiet' => $chi_tiet,
            ':noi_bat' => $noi_bat,
            ':ma_danh_muc' => $ma_danh_muc
        ]);
    }

    header("Location: product_management.php");
    exit;
}
?>

<div id="sanpham" class="tab-content active">
    <h2><?php echo $product ? 'Chỉnh sửa sản phẩm' : 'Thêm sản phẩm'; ?></h2>
    <form method="POST" enctype="multipart/form-data">
        <label>Tên sản phẩm: <input type="text" name="ten_san_pham" value="<?php echo $product ? htmlspecialchars($product['TenSanPham']) : ''; ?>" required></label>
        <label>Đường dẫn: <input type="text" name="duong_dan" value="<?php echo $product ? htmlspecialchars($product['DuongDan']) : ''; ?>" placeholder="Ví dụ: cay-truong-sinh"></label>
        <label>Giá: <input type="number" name="gia" value="<?php echo $product ? $product['Gia'] : '0'; ?>" required></label>
        <label>Số lượng tồn: <input type="number" name="so_luong_ton" value="<?php echo $product ? $product['SoLuongTon'] : '0'; ?>" required></label>
        <label>Hình ảnh: 
            <input type="file" name="hinh_anh" accept="image/jpeg,image/png,image/gif">
            <?php if ($product && $product['HinhAnh']): ?>
                <p>Hình hiện tại: <img src="../<?php echo htmlspecialchars($product['HinhAnh']); ?>" alt="Hình sản phẩm" style="max-width: 100px; max-height: 100px; object-fit: cover;"></p>
            <?php endif; ?>
        </label>
        <label>Mô tả: <textarea name="mo_ta"><?php echo $product ? htmlspecialchars($product['MoTa']) : ''; ?></textarea></label>
        <label>Chi tiết: <textarea name="chi_tiet"><?php echo $product ? htmlspecialchars($product['ChiTietSanPham']) : ''; ?></textarea></label>
        <label>Nổi bật: <input type="checkbox" name="noi_bat" <?php echo $product && $product['NoiBat'] ? 'checked' : ''; ?>></label>
        <label>Danh mục:
            <select name="ma_danh_muc" required>
                <?php foreach ($categories as $category): ?>
                    <option value="<?php echo $category['MaDanhMuc']; ?>" <?php echo $product && $product['MaDanhMuc'] == $category['MaDanhMuc'] ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($category['TenDanhMuc']); ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </label>
        <button type="submit">Lưu</button>
    </form>
</div>

<?php include('../includes/admin_footer.php'); ?>