<?php
session_start();
require_once '../includes/header.php';
?>
<section class="contact" id="contact-section">
    <h2>Liên hệ với chúng tôi</h2>
    <p>Nếu bạn có bất kỳ thắc mắc nào về sản phẩm hoặc dịch vụ của chúng tôi, xin vui lòng điền vào form bên dưới. Chúng tôi sẽ phản hồi sớm nhất có thể!</p>

    <form class="contact-form" action="#" method="post">
        <div>
            <label for="name">Họ và tên:</label>
            <input type="text" id="name" name="name" required>
        </div>

        <div>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>

        <div>
            <label for="phone">Số điện thoại:</label>
            <input type="tel" id="phone" name="phone">
        </div>

        <div>
            <label for="message">Nội dung:</label>
            <textarea id="message" name="message" rows="5" required></textarea>
        </div>

        <button type="submit">Gửi liên hệ</button>
    </form>
</section>
<?php
require_once '../includes/footer.php';
?>
