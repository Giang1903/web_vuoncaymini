<?php
session_start();
include('../includes/db_connect.php');

if (!isset($_SESSION['admin_id'])) {
    header("Location: ../login.php");
    exit;
}

if (!isset($_GET['id'])) {
    header("Location: post_management.php");
    exit;
}

$ma_tin_tuc = (int)$_GET['id'];

// Kiểm tra bài viết tồn tại
$stmt = $pdo->prepare("SELECT MaTinTuc FROM tintuc WHERE MaTinTuc = :id");
$stmt->execute([':id' => $ma_tin_tuc]);
$post = $stmt->fetch(PDO::FETCH_ASSOC);

if ($post) {
    // Xóa bài viết
    $stmt = $pdo->prepare("DELETE FROM tintuc WHERE MaTinTuc = :id");
    $stmt->execute([':id' => $ma_tin_tuc]);
}

header("Location: post_management.php");
exit;
?>