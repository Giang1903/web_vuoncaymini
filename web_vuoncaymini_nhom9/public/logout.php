<?php
session_start();
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng xuất</title>
    <script>
        window.onload = function() {
            if (confirm("Bạn có chắc chắn muốn đăng xuất?")) {
                window.location.href = "logout.php?action=confirm";
            } else {
                window.location.href = "index.php";
            }
        };
    </script>
</head>
<body>

</body>
</html>

<?php
// Xử lý đăng xuất nếu có tham số action=confirm
if (isset($_GET['action']) && $_GET['action'] === 'confirm') {
    // Xóa tất cả các biến session
    $_SESSION = array();
    // Hủy session
    session_destroy();
    header('Location: index.php');
    exit();
}
?>