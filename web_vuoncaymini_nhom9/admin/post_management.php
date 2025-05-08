<?php
session_start();
include('../includes/db_connect.php');
include('../includes/admin_header.php');

// Xử lý xóa bài viết
if (isset($_GET['delete_id'])) {
    $delete_id = $_GET['delete_id'];
    $stmt = $pdo->prepare("DELETE FROM tintuc WHERE MaTinTuc = :id");
    $stmt->execute([':id' => $delete_id]);
    header("Location: post_management.php");
    exit;
}

// Lấy danh sách bài viết
$stmt = $pdo->query("SELECT MaTinTuc, TieuDe, MoTaNgan, HinhAnh, NgayDang FROM tintuc WHERE TrangThai = 1 ORDER BY NgayDang DESC");
$all_posts = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<div id="baiviet" class="tab-content active">
    <h2>Bài viết</h2>
    <a href="edit_post.php" class="action-btn" style="margin-bottom: 20px;">Thêm bài viết mới</a>
    <table>
        <thead>
            <tr>
                <th>Tiêu đề</th>
                <th>Mô tả ngắn</th>
                <th>Hình ảnh</th>
                <th>Ngày đăng</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($all_posts as $post): ?>
                <tr>
                    <td><?php echo htmlspecialchars($post['TieuDe']); ?></td>
                    <td><?php echo htmlspecialchars($post['MoTaNgan'] ?? ''); ?></td>
                    <td>
                        <?php if ($post['HinhAnh']): ?>
                            <img src="../<?php echo htmlspecialchars($post['HinhAnh']); ?>" alt="<?php echo htmlspecialchars($post['TieuDe']); ?>" style="max-width: 100px; max-height: 100px; object-fit: cover;">
                        <?php else: ?>
                            Không có hình
                        <?php endif; ?>
                    </td>
                    <td><?php echo date('d/m/Y', strtotime($post['NgayDang'])); ?></td>
                    <td>
                        <a href="edit_post.php?id=<?php echo $post['MaTinTuc']; ?>" class="action-btn">Sửa</a>
                        <a href="post_management.php?delete_id=<?php echo $post['MaTinTuc']; ?>" class="action-btn" style="background-color: #d32f2f;" onclick="return confirm('Bạn có chắc muốn xóa bài viết này?');">Xóa</a>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<?php include('../includes/admin_footer.php'); ?>