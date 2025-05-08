<?php
session_start();
include('../includes/db_connect.php');
include('../includes/admin_header.php');

// Hàm tạo slug từ tiêu đề
function generateSlug($str) {
    $str = strtolower(trim($str));
    $str = preg_replace('/[^a-z0-9-]+/u', '-', $str); // thay thế ký tự không hợp lệ
    $str = preg_replace('/-+/', '-', $str); // thay thế nhiều dấu - liên tiếp thành một
    return trim($str, '-'); // xóa dấu - đầu/cuối
}

$post = null;
if (isset($_GET['id'])) {
    $stmt = $pdo->prepare("SELECT * FROM tintuc WHERE MaTinTuc = :id");
    $stmt->execute([':id' => $_GET['id']]);
    $post = $stmt->fetch(PDO::FETCH_ASSOC);
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $tieu_de = htmlspecialchars($_POST['tieu_de']);
    $mo_ta_ngan = htmlspecialchars($_POST['mo_ta_ngan']);
    $noi_dung = htmlspecialchars($_POST['noi_dung']);
    $trang_thai = 1;
    $hinh_anh = $post ? $post['HinhAnh'] : '';

    // Tạo slug từ tiêu đề
    $duong_dan = generateSlug($tieu_de);
    $original_slug = $duong_dan;
    $counter = 1;

    // Đảm bảo DuongDan là duy nhất
    while (true) {
        $stmt_check = $pdo->prepare("SELECT COUNT(*) FROM tintuc WHERE DuongDan = :duong_dan" . ($post ? " AND MaTinTuc != :id" : ""));
        $params = [':duong_dan' => $duong_dan];
        if ($post) $params[':id'] = $post['MaTinTuc'];
        $stmt_check->execute($params);
        $count = $stmt_check->fetchColumn();
        if ($count == 0) break;
        $duong_dan = $original_slug . '-' . $counter++;
    }

    // Xử lý upload hình ảnh
    if (isset($_FILES['hinh_anh']) && $_FILES['hinh_anh']['error'] == UPLOAD_ERR_OK) {
        $upload_dir = '../img_tree/';
        $file_name = basename($_FILES['hinh_anh']['name']);
        $file_path = $upload_dir . time() . '_' . $file_name;
        $relative_path = 'img_tree/' . time() . '_' . $file_name;

        $allowed_types = ['image/jpeg', 'image/png', 'image/gif'];
        $file_type = mime_content_type($_FILES['hinh_anh']['tmp_name']);
        if (in_array($file_type, $allowed_types) && move_uploaded_file($_FILES['hinh_anh']['tmp_name'], $file_path)) {
            $hinh_anh = $relative_path;
        } else {
            echo "<p style='color: red;'>Lỗi: Chỉ hỗ trợ tệp hình ảnh (JPEG, PNG, GIF).</p>";
            $hinh_anh = $post ? $post['HinhAnh'] : '';
        }
    }

    if ($post) {
        // Cập nhật bài viết
        $stmt = $pdo->prepare("UPDATE tintuc 
            SET TieuDe = :tieu_de, MoTaNgan = :mo_ta_ngan, NoiDung = :noi_dung, HinhAnh = :hinh_anh, TrangThai = :trang_thai, DuongDan = :duong_dan 
            WHERE MaTinTuc = :id");
        $stmt->execute([
            ':tieu_de' => $tieu_de,
            ':mo_ta_ngan' => $mo_ta_ngan,
            ':noi_dung' => $noi_dung,
            ':hinh_anh' => $hinh_anh,
            ':trang_thai' => $trang_thai,
            ':duong_dan' => $duong_dan,
            ':id' => $post['MaTinTuc']
        ]);
    } else {
        // Thêm bài viết mới
        $stmt = $pdo->prepare("INSERT INTO tintuc 
            (TieuDe, MoTaNgan, NoiDung, HinhAnh, NgayDang, TrangThai, DuongDan) 
            VALUES (:tieu_de, :mo_ta_ngan, :noi_dung, :hinh_anh, NOW(), :trang_thai, :duong_dan)");
        $stmt->execute([
            ':tieu_de' => $tieu_de,
            ':mo_ta_ngan' => $mo_ta_ngan,
            ':noi_dung' => $noi_dung,
            ':hinh_anh' => $hinh_anh,
            ':trang_thai' => $trang_thai,
            ':duong_dan' => $duong_dan
        ]);
    }

    header("Location: post_management.php");
    exit;
}
?>

<div id="baiviet" class="tab-content active">
    <h2><?php echo $post ? 'Chỉnh sửa bài viết' : 'Thêm bài viết'; ?></h2>
    <form method="POST" enctype="multipart/form-data">
        <label>Tiêu đề: 
            <input type="text" name="tieu_de" value="<?php echo $post ? htmlspecialchars($post['TieuDe']) : ''; ?>" required>
        </label>

        <label>Mô tả ngắn: 
            <textarea name="mo_ta_ngan" required><?php echo $post ? htmlspecialchars($post['MoTaNgan'] ?? '') : ''; ?></textarea>
        </label>

        <label>Nội dung: 
            <textarea name="noi_dung" required><?php echo $post ? htmlspecialchars($post['NoiDung']) : ''; ?></textarea>
        </label>

        <label>Hình ảnh: 
            <input type="file" name="hinh_anh" accept="image/jpeg,image/png,image/gif">
            <?php if ($post && $post['HinhAnh']): ?>
                <p>Hình hiện tại: 
                    <img src="../<?php echo htmlspecialchars($post['HinhAnh']); ?>" alt="Hình bài viết" style="max-width: 100px; max-height: 100px; object-fit: cover;">
                </p>
            <?php endif; ?>
        </label>

        <button type="submit">Lưu</button>
    </form>
</div>

<?php include('../includes/admin_footer.php'); ?>
