<?php
session_start();
require_once '../includes/header.php';
require_once '../includes/db_connect.php';

try {
    $stmt = $pdo->prepare("SELECT * FROM tintuc WHERE TrangThai = ?");
    $stmt->execute([1]);
    $posts = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    error_log("Database error: " . $e->getMessage());
    $posts = [];
}
?>

<section class="blog-section" id="blog-section">
    <h2>Kiến Thức Về Cây Cảnh</h2>
    <div class="blog-container">
        <?php if (empty($posts)): ?>
            <p>Chưa có bài viết nào trong danh mục này.</p>
        <?php else: ?>
            <?php foreach ($posts as $post): ?>
                <div class="blog-post">
                    <?php if ($post['HinhAnh']): ?>
                        <img src="../<?php echo htmlspecialchars($post['HinhAnh']); ?>" alt="<?php echo htmlspecialchars($post['TieuDe']); ?>" class="post-image">
                    <?php endif; ?>
                    <h3><?php echo htmlspecialchars($post['TieuDe']); ?></h3>
                    <p class="post-excerpt"><?php echo htmlspecialchars(substr($post['MoTaNgan'], 0, 150)) . '...'; ?></p>
                    <a href="blog_detail.php?id=<?php echo $post['MaTinTuc']; ?>" class="read-more">Đọc Thêm</a>
                </div>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>
</section>

<?php
require_once '../includes/footer.php';
?>