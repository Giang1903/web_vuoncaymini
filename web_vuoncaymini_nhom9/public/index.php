<?php
session_start();
require_once '../includes/header.php';
?>

<div id="content">
    <div id="search">
        <?php require_once '../includes/sidebar.php'; ?>
    </div>
    <?php require_once '../includes/product_section.php'; ?>
</div>

<?php
require_once '../includes/footer.php';
?>