<?php
session_start();
require_once '../includes/header.php';
require_once '../includes/db_connect.php';

try {
    $post_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
    $stmt = $pdo->prepare("SELECT * FROM tintuc WHERE MaTinTuc = ? AND TrangThai = ?");
    $stmt->execute([$post_id, 1]);
    $post = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$post) {
        echo "<p>Bài viết không tồn tại hoặc đã bị xóa.</p>";
    } else {
        ?>
        <section class="blog-section">
            <h2><?php echo htmlspecialchars($post['TieuDe']); ?></h2>
            <?php if ($post['HinhAnh']): ?>
                <img src="../<?php echo htmlspecialchars($post['HinhAnh']); ?>" alt="<?php echo htmlspecialchars($post['TieuDe']); ?>" class="post-image">
            <?php endif; ?>
            <div class="post-content">
                <?php echo nl2br(htmlspecialchars($post['NoiDung'])); ?>
            </div>
        </section>
        <?php
    }
} catch (PDOException $e) {
    error_log("Database error: " . $e->getMessage());
    echo "<p>Đã có lỗi xảy ra. Vui lòng thử lại sau.</p>";
}

require_once '../includes/footer.php';
?>