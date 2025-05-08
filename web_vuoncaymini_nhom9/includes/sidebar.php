<div class="sidebar">
    <ul class="category">
        <?php
        require_once 'db_connect.php';

        $stmt = $pdo->query("SELECT * FROM danhmuc WHERE MaDanhMucCha IS NULL AND TrangThai = 1 ORDER BY ThuTuSapXep");
        $parent_categories = $stmt->fetchAll(PDO::FETCH_ASSOC);

        foreach ($parent_categories as $parent) {
            echo '<li>';
            echo '<span class="category-parent">' . htmlspecialchars($parent['TenDanhMuc']) . '</span>';
            echo '<ul class="subcategory">';

            $stmt = $pdo->prepare("SELECT * FROM danhmuc WHERE MaDanhMucCha = ? AND TrangThai = 1 ORDER BY ThuTuSapXep");
            $stmt->execute([$parent['MaDanhMuc']]);
            $sub_categories = $stmt->fetchAll(PDO::FETCH_ASSOC);

            foreach ($sub_categories as $sub) {
                $activeClass = (isset($_GET['category_id']) && $_GET['category_id'] == $sub['MaDanhMuc']) ? 'active' : ''; 
                echo '<li><a href="../public/category.php?category_id=' . $sub['MaDanhMuc'] . '" class="category-child ' . $activeClass . '">' . htmlspecialchars($sub['TenDanhMuc']) . '</a></li>';
            }

            echo '</ul></li>';
        }
        ?>
    </ul>

    <!-- News Section -->
    <ul class="category"> 
        <li>
            <span class="category-parent">Tin Tức Mới</span>
            <ul class="subcategory news-list">
                <?php
                $stmt = $pdo->prepare("SELECT MaTinTuc, TieuDe, NgayDang, HinhAnh, MoTaNgan FROM tintuc WHERE TrangThai = ? ORDER BY NgayDang DESC LIMIT 5");
                $stmt->execute([1]);
                $news = $stmt->fetchAll(PDO::FETCH_ASSOC);

                $first = true;
                foreach ($news as $item) {
                    $activeClass = $first ? 'active' : '';
                    $first = false;
                    ?>
                    <li class="carousel-item <?php echo $activeClass; ?>">
                        <a href="../section/blog_detail.php?id=<?php echo $item['MaTinTuc']; ?>">
                            <img src="../<?php echo htmlspecialchars($item['HinhAnh']); ?>" class="d-block w-100" alt="<?php echo htmlspecialchars($item['TieuDe']); ?>">
                            <div class="carousel-caption d-none d-md-block">
                                <h5><?php echo htmlspecialchars($item['TieuDe']); ?></h5>
                                <p><?php echo isset($item['MoTaNgan']) ? htmlspecialchars(substr($item['MoTaNgan'], 0, 100)) . '...' : ''; ?></p>
                            </div>
                        </a>
                    </li>
                    <?php
                }
                ?>
            </ul>
        </li>
    </ul>
</div>
