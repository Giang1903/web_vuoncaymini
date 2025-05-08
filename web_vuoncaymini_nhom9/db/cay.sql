-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th5 05, 2025 lúc 12:19 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `cay`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chitietdonhang`
--

CREATE TABLE `chitietdonhang` (
  `MaChiTiet` int(11) NOT NULL,
  `MaDonHang` int(11) DEFAULT NULL,
  `MaSanPham` int(11) DEFAULT NULL,
  `SoLuong` int(11) NOT NULL,
  `DonGia` decimal(10,2) NOT NULL,
  `ThanhTien` decimal(10,2) GENERATED ALWAYS AS (`SoLuong` * `DonGia`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `chitietdonhang`
--

INSERT INTO `chitietdonhang` (`MaChiTiet`, `MaDonHang`, `MaSanPham`, `SoLuong`, `DonGia`) VALUES
(1, 1, 14, 1, 24000.00),
(9, 7, 1, 1, 190000.00),
(10, 7, 2, 1, 155000.00),
(11, 8, 6, 1, 200000.00),
(12, 8, 5, 1, 150000.00),
(15, 15, 1, 1, 190000.00),
(16, 15, 2, 1, 155000.00),
(17, 16, 11, 1, 150000.00),
(18, 16, 10, 1, 190000.00),
(19, 17, 3, 1, 240000.00),
(20, 18, 1, 1, 190000.00),
(21, 18, 6, 1, 200000.00),
(22, 18, 24, 1, 15000.00),
(23, 18, 26, 1, 15000.00),
(26, 20, 2, 1, 155000.00),
(27, 20, 3, 1, 240000.00),
(28, 20, 6, 1, 200000.00),
(29, 20, 4, 1, 145000.00),
(30, 21, 2, 1, 155000.00),
(31, 21, 24, 1, 15000.00),
(32, 21, 22, 1, 15000.00),
(33, 21, 15, 1, 190000.00),
(34, 22, 1, 1, 190000.00),
(35, 22, 2, 1, 155000.00),
(36, 22, 3, 1, 240000.00),
(37, 23, 6, 1, 200000.00),
(38, 23, 27, 1, 9000.00),
(39, 23, 1, 1, 190000.00),
(40, 23, 8, 1, 190000.00),
(41, 23, 23, 1, 15000.00),
(42, 23, 26, 1, 15000.00),
(43, 24, 1, 1, 190000.00),
(44, 24, 2, 1, 155000.00),
(45, 25, 14, 1, 240000.00),
(46, 25, 12, 1, 155000.00),
(47, 25, 25, 1, 45000.00),
(48, 25, 30, 1, 10000.00),
(49, 26, 41, 1, 200000.00),
(50, 26, 25, 1, 45000.00),
(51, 26, 30, 1, 10000.00),
(52, 27, 2, 2, 155000.00),
(53, 27, 25, 1, 45000.00),
(54, 27, 30, 1, 10000.00),
(56, 29, 1, 2, 190000.00),
(57, 29, 2, 6, 155000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhmuc`
--

CREATE TABLE `danhmuc` (
  `MaDanhMuc` int(11) NOT NULL,
  `MaDanhMucCha` int(11) DEFAULT NULL,
  `TenDanhMuc` varchar(255) NOT NULL,
  `TieuDe` varchar(255) NOT NULL,
  `mota` text NOT NULL COMMENT 'Mô tả danh mục',
  `ThuTuSapXep` tinyint(4) DEFAULT 0,
  `TrangThai` tinyint(1) DEFAULT 1,
  `NgayTao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `danhmuc`
--

INSERT INTO `danhmuc` (`MaDanhMuc`, `MaDanhMucCha`, `TenDanhMuc`, `TieuDe`, `mota`, `ThuTuSapXep`, `TrangThai`, `NgayTao`) VALUES
(1, NULL, 'Cây cảnh', 'Danh mục cây cảnh', 'Các loại cây cảnh để bàn, cây cảnh thuỷ sinh, terrarium, bonsai, cây ăn trái… Mỗi chậu cây được phối hợp tạo nên vẻ đẹp hài hoà, có ý nghĩa phong thuỷ phù hợp với tuổi, mệnh để bạn dễ dàng lựa chọn.\r\n', 1, 1, '2025-04-22 19:42:56'),
(2, 1, 'Cây để bàn', 'Cây cảnh để bàn', 'Các loại cây cảnh để bàn với nhiều kiểu dáng và kích thước khác nhau, giúp thanh lọc không khí, tạo không gian sống và làm việc tràn đầy năng lượng.', 2, 1, '2025-04-22 19:43:22'),
(3, 1, 'Cây thủy sinh', 'Cây cảnh thủy sinh', 'Cây cảnh thủy sinh mang lại sự khác biệt cho người chơi nếu được đặt tại những vị trí phù hợp trên bàn làm việc, văn phòng hay nhà ở, tạo sự chú ý, tò mò cho khách viếng thăm.', 3, 1, '2025-04-22 19:43:49'),
(4, 1, 'Sen đá, xương rồng', 'Sen đá và xương rồng', 'Các chậu cây sen đá, xương rồng nhỏ nhắn chính là ý tưởng độc đáo giúp việc trang trí cho văn phòng, nhà ở, bàn làm việc thêm sinh động.', 4, 1, '2025-04-22 19:44:11'),
(5, 1, 'Cây chậu treo', 'Cây chậu treo', 'Đừng bỏ quên ban công hay cửa sổ, sự lãng mạn nên thơ có thể toát lên ở những nơi đây chỉ bằng các chậu treo đơn giản, tinh tế.', 5, 1, '2025-04-22 19:44:47'),
(6, NULL, 'Chậu cảnh', 'Danh mục chậu cảnh', 'Tổng hợp các loại chậu cảnh với nhiều kiểu dáng, màu sắc, chất liệu và kích thước khác nhau, khoác lên bộ áo đa dạng cho cây trồng', 6, 1, '2025-04-22 19:45:10'),
(7, 6, 'Chậu đất nung', 'Chậu đất nung', 'Chậu cây làm từ đất nung chất liệu tốt, mẫu mã đẹp, phù hợp trồng cây xanh phong thủy, cây cảnh để bàn, sen đá, xương rồng,... Chậu đất nung đủ các loại kích cỡ và màu sắc với giá siêu rẻ.', 7, 1, '2025-04-22 19:45:31'),
(8, 6, 'Chậu đá mài - xi măng', 'Chậu đá mài - xi măng', 'Chậu đá mài tại Vườn Cây Việt làm từ đá Granite, đá cẩm thạch và được kết dính hoàn hảo tạo nên sản phẩm có tính thẩm mỹ cao. Chậu có độ bền cao, lâu đổi màu.', 8, 1, '2025-04-22 19:45:52'),
(9, 6, 'Chậu composite', 'Chậu composite', 'Thiết kế chậu composite kiểu dáng đa dạng, sang trọng, độc đáo. Chậu composite có chất lượng bền bỉ, khó vỡ, khó lỗi thời hoặc đổi màu mà giá cả rất hợp lý.', 9, 1, '2025-04-22 19:46:35'),
(10, 6, 'Chậu men sứ', 'Chậu men sứ', 'Chậu men sứ, men cát với chất liệu gốm tốt, nước men đẹp; đường nét, hoa văn sắc sảo, kiểu dáng thanh lịch, phù hợp với nhiều loại cây cảnh, nội thất hay ngoại thất đều được.', 10, 1, '2025-04-22 19:47:06'),
(11, NULL, 'Phụ kiện cây cảnh', 'Phụ kiện cây cảnh', 'Các phụ kiện chăm sóc cây cảnh chất lượng bao gồm: đất trồng, phân bón, dung dịch thủy sinh, dụng cụ làm vườn, vật trang trí tiểu cảnh...', 11, 1, '2025-04-22 19:47:22'),
(12, 11, 'Đất trồng, phân bón', 'Đất trồng, phân bón', 'Đất trồng tại cơ sở Vườn Cây Việt đảm bảo là đất sạch, đất thịt hoặc đất cát trộn mùn hữu cơ, tơi, xốp, dễ thoát nước, thích hợp với nhiều loại cây trồng khác nhau.', 12, 1, '2025-04-22 19:47:42'),
(13, 11, 'Dụng cụ làm vườn', 'Dụng cụ làm vườn', 'Bộ dụng cụ làm vườn tại Vườn Cây Việt bao gồm: bình xịt tưới nước, kềm bấm cành, kéo tỉa lá, xẻng mini, cào đất mini, đế lót chậu cây, găng tay làm vườn chống trượt,…', 13, 1, '2025-04-22 19:48:06'),
(14, 11, 'Vật trang trí tiểu cảnh', 'Vật trang trí tiểu cảnh', 'Những vật trang trí tiểu cảnh độc đáo, ngộ nghĩnh và đáng yêu như ngôi nhà, con vật, ghế bàn, cột đèn, chiếc dù, hình người hay mặt cười, … chắc chắn sẽ làm chậu cây cực kỳ sinh động và bắt mắt.', 14, 1, '2025-04-22 19:48:26');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `donhang`
--

CREATE TABLE `donhang` (
  `MaDonHang` int(11) NOT NULL,
  `idUser` int(11) DEFAULT NULL,
  `TenKhachHang` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `SoDienThoai` varchar(15) DEFAULT NULL,
  `DiaChiGiaoHang` text NOT NULL,
  `TongTien` decimal(10,2) NOT NULL,
  `MaTrangThai` int(11) DEFAULT NULL,
  `GhiChu` text DEFAULT NULL,
  `NgayDatHang` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `donhang`
--

INSERT INTO `donhang` (`MaDonHang`, `idUser`, `TenKhachHang`, `Email`, `SoDienThoai`, `DiaChiGiaoHang`, `TongTien`, `MaTrangThai`, `GhiChu`, `NgayDatHang`) VALUES
(1, 2, 'Nguyễn Thanh An', 'thanhan12@gmail.com', '0909123456', '70 Tô Ký, Quận 12', 240000.00, 4, '', '2025-04-22 20:22:38'),
(7, 10, 'Nguyễn Văn T', 'thanhviet123@gmail.com', '0344215678', 'Tp,HCM', 345000.00, 4, '', '2025-04-27 06:20:36'),
(8, 10, 'Nguyễn Văn T', '', '0321456789', 'Tp,HCM', 350000.00, 1, '', '2025-04-27 06:21:50'),
(15, 9, 'Nguyễn Văn Tèo', '', '0321456789', 'Tp,HCM', 345000.00, 1, '', '2025-04-27 10:26:02'),
(16, 9, 'Nguyễn Văn Tèo', 'son1234@gmail.com', '0321456789', 'Tp,HCM', 340000.00, 4, 'giao ngay trong hôm nay', '2025-04-27 10:27:30'),
(17, 9, 'Nguyễn Văn Tèo', 'thanhviet123@gmail.com', '0321456789', 'Tp,HCM', 240000.00, 4, '', '2025-04-27 10:38:22'),
(18, NULL, 'Nguyễn Thanh Vân', 'thanhvan@gmail.com', '0341235665', '70 Tô ký,Quận 12', 420000.00, 4, 'Giao buổi sáng cho toi nhé shop', '2025-04-27 14:26:05'),
(20, NULL, 'Nguyễn Thanh Vân', 'thanhvan@gmail.com', '0341235665', '70 Tô ký,Quận 12', 740000.00, 4, '', '2025-05-02 17:10:11'),
(21, NULL, 'Nguyễn Thanh Vân', 'thanhvan@gmail.com', '0341235665', '70 Tô ký,Quận 12', 375000.00, 4, '', '2025-05-02 17:12:43'),
(22, 1, 'Nhóm 9', 'thanhviet123@gmail.com', '0343294824', '70 tô ký', 585000.00, 4, '', '2025-05-02 18:07:29'),
(23, 9, 'Nguyễn Văn Tèo', 'teonv@gmail.com', '0321456789', 'Tp,HCM', 619000.00, 4, '', '2025-05-03 17:10:04'),
(24, 9, 'Nguyễn Văn Tèo', 'teo123@gmail.com', '0321456789', 'Tp,HCM', 345000.00, 4, '', '2025-05-04 16:28:38'),
(25, 14, 'Lê Văn Tám', '', '0942315678', '134/2 Tân Chánh Hiệp, Quận 12', 450000.00, 1, '', '2025-05-05 07:54:47'),
(26, 16, 'Lê Văn Dậu', 'letam123@gmail.com', '03425612378', '123/45 Phan Văn Trị, Q Gò Vấp', 255000.00, 2, 'giao nhanh buổi sáng cho tôi nhé', '2025-05-05 08:43:23'),
(27, 17, 'Bùi Đức Long', 'buiduclong@gmail.com', '0341235678', '123/45 Phan Văn Trị, Q Gò Vấp', 365000.00, 2, 'giao hàng trong sáng nay giúp tôi nhé', '2025-05-05 09:04:51'),
(29, 9, 'Nguyễn Văn Tèo', '', '0321456789', 'Tp,HCM', 1310000.00, 1, '', '2025-05-05 10:19:04');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `giohang`
--

CREATE TABLE `giohang` (
  `MaGioHang` int(11) NOT NULL,
  `idUser` int(11) DEFAULT NULL,
  `MaSanPham` int(11) DEFAULT NULL,
  `SoLuong` int(11) NOT NULL,
  `NgayThem` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `giohang`
--

INSERT INTO `giohang` (`MaGioHang`, `idUser`, `MaSanPham`, `SoLuong`, `NgayThem`) VALUES
(1, 3, 15, 1, '2025-04-22 20:38:30'),
(27, 10, 9, 1, '2025-04-27 06:22:24'),
(80, 15, 1, 1, '2025-05-05 08:34:34'),
(81, 15, 6, 2, '2025-05-05 08:34:45');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sanpham`
--

CREATE TABLE `sanpham` (
  `MaSanPham` int(11) NOT NULL,
  `MaDanhMuc` int(11) DEFAULT NULL,
  `TenSanPham` varchar(255) NOT NULL,
  `DuongDan` varchar(255) NOT NULL,
  `Gia` decimal(10,2) NOT NULL,
  `SoLuongTon` int(11) NOT NULL DEFAULT 0,
  `MoTa` text DEFAULT NULL,
  `ChiTietSanPham` text DEFAULT NULL,
  `HinhAnh` varchar(255) DEFAULT NULL,
  `NoiBat` tinyint(1) DEFAULT 0,
  `NgayTao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `sanpham`
--

INSERT INTO `sanpham` (`MaSanPham`, `MaDanhMuc`, `TenSanPham`, `DuongDan`, `Gia`, `SoLuongTon`, `MoTa`, `ChiTietSanPham`, `HinhAnh`, `NoiBat`, `NgayTao`) VALUES
(1, 2, 'Cây Trường Sinh', 'cay-truong-sinh', 190000.00, 0, 'Cây Trường Sinh là loại cây phong thủy mang đến may mắn và tài lộc cho gia chủ. Cây cũng đồng thời có ý nghĩa cầu chúc sức khỏe dồi dào, bình an.\r\nLưu ý: Giá sản phẩm đã bao gồm chậu.', 'Giới thiệu\r\nTên gọi khác: Diệp Sinh Căn, Thiên Cảnh Tạp Giao\r\nTên khoa học: Peperomia obtusifolia\r\nTên tiếng Anh: Baby Rubber Plant\r\nHọ: Crassulaceae (thuốc Bỏng)\r\nXuất xứ: Florida, Mexico và vùng Caribbean\r\nĐặc điểm\r\nThân thảo, nhẵn bóng, tròn, mọng nước, trồng chậu cao khoảng 10-60cm\r\nLá có màu xanh lục đậm, bóng, với hình tròn xinh viên mãn.\r\nLá mọc từ gốc hoặc thân, dạng đối, mọc khỏe khoắn, xum xuê\r\nHoa màu trắng, dạng chuỗi, nở kéo dài từ tháng 12 đến tháng 4 năm sau\r\nÝ nghĩa phong thủy\r\nĐúng như tên gọi, chỉ sự trường tồn, mãi mãi, ngụ ý về một mối quan hệ bền lâu\r\nTượng trưng cho tài lộc, may mắn được vững bền\r\nGiúp gia chủ thêm vượng khí, sức khỏe dồi dào\r\nCây phù hợp với người mệnh Mộc, mang đến niềm tin, hy vọng và sự hợp tác lâu dài, bền vững.\r\nCông dụng\r\nTrồng chậu trang trí trong nhà, cơ quan, đặt bàn làm việc, tạo không gian tươi mát, dễ chịu\r\nCó thể hút bớt khí độc và giảm ảnh hưởng xấu từ tia tử ngoại, tia bức xạ của đồ điện tử\r\nThích hợp làm quà tặng trong lễ mừng thọ, mừng sinh nhật…\r\nCách trồng và chăm sóc\r\nĐất trồng: giàu dinh dưỡng và thoát nước tốt. Tạo hỗn hợp bao gồm: đất + tro trấu + xơ dừa + vôi bột + đá perlite.\r\nNước: cây đặt trong nhà tưới 1 lần/tuần. Cây trồng ngoài trời tưới 2 lần/tuần. Lượng nước tưới ít, đủ ẩm\r\nÁnh sáng: tránh ánh nắng gay gắt, có thể sống dưới ánh đèn huỳnh quang, phơi nắng nhẹ buổi sáng 3 lần/tuần\r\nNhiệt độ: thích hợp nhất là 18-30 độ C. Nhiệt độ quá thấp hoặc quá cao sẽ rụng lá, dễ chết\r\nĐộ ẩm: khoảng 80%\r\nTỉa cây: bấm ngọn bằng cách ngắt bỏ 2 – 3cm trên ngọn của thân chính sẽ giúp cây phát triển tốt hơn. Thường xuyên sử dụng khăn lau sạch lá, cắt bỏ lá già để loại bỏ mầm bệnh sâu cuốn lá\r\nBón phân: bón điều độ hàng tháng bằng cách 1 - 2 chén phân chuồng hoại mục hoặc NPK bằng cách vùi xuống gốc cách giữa gốc và chậu', 'img_tree/caycanh/caydeban/cay-truong-sinh.jpg', 1, '2025-04-22 19:56:23'),
(2, 2, 'Cây Trầu Bà', 'cay-trau-ba', 155000.00, 0, 'Cây trầu bà sữa chậu treo thường  dùng để trang trí quán cafe, tiểu cảnh giếng trời, giàn treo sân thượng, trang trí văn phòng làm việc,… Màu lá cây trầu bà sữa trông lạ mắt, dáng cây rũ rất phù hợp chậu treo.', 'Giới thiệu\r\nTên thường gọi Cây Trầu bà sữa chậu treo, cây Trầu bà cẩm thạch chậu treo…\r\nTên tiếng Anh Australian native monstera\r\nTên khoa học Epipremnum aureum ‘Marble Queen’\r\nHọ thực vật Araceae (họ Ráy)\r\nChiều cao 20-30 cm (cả chậu)\r\n\r\nCông dụng\r\nCây trầu bà sữa chậu treo thường  dùng để trang trí quán cafe, tiểu cảnh giếng trời, giàn treo sân thượng, trang trí văn phòng làm việc,… Màu lá cây trầu bà sữa trông lạ mắt, dáng cây rũ rất phù hợp chậu treo.', 'img_tree/caycanh/caydeban/cay-trau-ba.jpg', 1, '2025-04-22 19:58:34'),
(3, 2, 'Cây Trạng Nguyên', 'cay-trang-nguyen', 240000.00, 6, 'Cây Trạng Nguyên mang ý nghĩa về sự may mắn, đỗ đạt và thành công, thường dùng làm quà tặng nhân dịp khai trương, hoặc làm cây trang trí vào dịp Giáng sinh.\r\nLưu ý: Giá cây đã bao gồm chậu.', 'Giới thiệu cây Trạng Nguyên\r\n\r\nTên khác: Nhất Phẩm Hồng\r\nTên tiếng Anh: Poinsettia, Mexican flame leaf, Christmas star, Winter rose, Noche Buena\r\nTên khoa học: Euphorbia pulcherrima\r\nXuất xứ: miền nam Mexico, Trung Mỹ và châu Phi\r\nĐặc điểm\r\n\r\nLá Trạng Nguyên có 2 phần, phần phía trên có màu đỏ (là lá non, nhiều người nhầm đây là hoa của cây), phần gần gốc lá màu xanh (lá già).\r\nCũng có loại Trạng Nguyên lá màu trắng và hồng nhạt nhưng ít phổ biến bằng loại lá đỏ.\r\nThường ra hoa vào dịp giáng sinh, gần tết, hoa nhỏ màu vàng có hình chiếc môi nhìn rất ngộ nghĩnh.\r\nÝ nghĩa phong thủy\r\n\r\nCây mang ý nghĩa về sự may mắn, đỗ đạt và thành công.\r\nCông dụng\r\n\r\nThường dùng làm quà tặng nhân dịp khai trương, hoặc làm cây trang trí vào dịp Giáng sinh, ở các nước Phương Tây, tiết trời càng lạnh thì lá cây Trạng Nguyên càng có màu đỏ rực rỡ.\r\nThích hợp làm cây cảnh văn phòng, đặt tại quầy lễ tân, bàn thu ngân, hoặc đặt trước nhà đón may mắn và thành công.\r\nCách chăm sóc\r\n\r\nNhiệt độ: cây phát triển tốt từ 16 độ C đến 22 độ C\r\nÁnh sáng: ảnh hưởng đến việc ra hoa của cây, cây ra hoa tốt và màu lá đẹp thì nên để nhiều trong tối.\r\nNước: giữ ẩm cho đất, không để ướt sũng, 2 ngày tưới 1 lần nếu trồng ngoài trời, còn để trong nhà thì 1 tuần tưới 2 lần.\r\nĐất: đất có nhiều dinh dưỡng, tơi xốp và thoát nước tốt, có thể trộn đất với tro, trấu và xơ dừa.\r\nPhân bón: bón định kì theo liều lượng vừa đủ, bón nhiều cây dễ bị cháy rễ. Cường độ 1 tháng 1 lần là được.\r\nNhân giống bằng cách chiết cành hoặc gieo hạt', 'img_tree/caycanh/caydeban/cay-trang-nguyen.jpg', 1, '2025-04-22 20:00:19'),
(4, 2, 'Cây May Mắn Tài Lộc', 'cay-tai-loc', 145000.00, 9, 'Cây May Mắn Tài Lộc là cây phong thủy cực tốt để chưng trong nhà dịp Tết. Chậu cây nhỏ xinh còn có thể được đặt trên bàn làm việc hoặc bàn thu ngân để cầu tài cho người trồng\r\nLưu ý: Giá sản phẩm đã bao gồm chậu.', 'Giới thiệu cây May Mắn Tài Lộc\r\n\r\nChậu cây gồm có hai phần: cây Tài Lộc ở chính giữa chậu vươn cao và cỏ May Mắn bao phủ mặt đất của chậu\r\nTên khoa học của cỏ May Mắn là Hylocereus\r\nChiều cao trung bình từ 15 cm – 20 cm\r\nĐặc điểm\r\n\r\nChậu cây May Mắn Tài Lộc thường có từ 3-5 thân được trồng chụm lại ở giữa (dùng dây kẽm quấn vào nhau)\r\nLá cây tỏa đều ra phía trên, xanh bóng, thuôn dài\r\nQuanh gốc có những quả xanh, to bằng đầu ngón tay được phân bố đều, thường sẽ có 5 quả\r\nTrên bề mặt đất được phủ dày lớp Cỏ May Mắn xanh\r\nCông dụng\r\n\r\nLọc không khí rất tốt, mang lại cảm giác mới mẻ, tươi vui cho người trồng\r\nThích hợp đặt trang trí bàn làm việc, quầy thu ngân, kệ sách, kệ tivi,...\r\nLà món quà tặng độc đáo dành cho người thân và bạn bè\r\nÝ nghĩa phong thủy\r\n\r\nĐa số mỗi chậu sẽ có 5 quả tượng trưng cho “Phát - Lộc - Thọ - An - Khang”\r\nLà cây phong thủy tốt để chưng trong nhà dịp Tết, cầu tài lộc và bình an\r\nThích hợp với người mệnh Mộc và Hỏa\r\nCách chăm sóc cây May Mắn Tài Lộc\r\n\r\nÁnh sáng: có thể sống trong môi trường thiếu sáng hoặc ánh sáng yếu. Nên đem ra phơi nắng nhẹ 2-3 lần/tuần để màu lá đẹp hơn\r\nNhiệt độ: thích hợp nhất là 15-30 độ C. Nhiệt độ quá cao dễ dẫn đến khô héo lá và chết\r\nĐất trồng: cần đất có độ mùn cao, giữ ẩm tốt, thoát nước nhanh. Nên trộn hỗn hợp xơ dừa, mùn cưa và đất tribat\r\nNước: cần lượng nước khá ít, khoảng 1 lần/tuần tưới cho cây, tránh gây ngập úng dễ chết phần cỏ May Mắn dưới gốc\r\nBón phân: hòa phân vi sinh thật loãng với nước và tưới dưới gốc cho cây', 'img_tree/caycanh/caydeban/cay-tai-loc.jpg', 1, '2025-04-22 20:00:19'),
(5, 2, 'Cây Lưỡi Hổ', 'cay-luoi-ho', 150000.00, 13, 'Cây Lưỡi Hổ có tác dụng trừ tà, xua đuổi ma quỷ, những điều xui xẻo, xua đi bùa chú. Lá cây thường mọc thẳng thể hiện sự quyết đoán, ý chí tiến lên cũng như sự kiên cường của người trồng. Cây còn mang ý nghĩa may mắn, giúp gia chủ phát tài, phát lộc, dồi dào tiền bạc\r\nLưu ý: Giá sản phẩm đã bao gồm chậu.', 'Giới thiệu cây Lưỡi Hổ\r\n\r\nTên khác: Hổ Vĩ, Lưỡi Cọp, Hổ Thiệt, Lưỡi Mẹ Vợ\r\nTên tiếng Anh: Snake Plant\r\nTên khoa học: Sansevieria trifasciata\r\nHọ: Măng tây\r\nXuất xứ: vùng nhiệt đới Châu Mỹ, Châu Phi và Châu Á.\r\nĐặc điểm\r\n\r\nLưỡi Hổ là loài cây mọng nước, thực vật không có thân trên mặt đất, mọc thẳng đứng, có thể cao đến 80cm, cây có thân rễ.\r\nLá Lưỡi Hổ dày, cứng, hình như lưỡi dao, mọc thành bụi từ 5-6 lá. Lá kết hợp hài hòa giữa các màu xanh bóng, xanh đậm và hai dải màu vàng kéo dài từ gốc đến ngọn.\r\nLưỡi Hổ có hoa, hoa màu trắng nhạt mềm mại, có 6 cánh thuôn dài 3,5cm.\r\nTrên thế giới có cỡ 70 loài Lưỡi Hổ khác nhau, ở VN ngoài cây Lưỡi Hổ như chúng ta thường thấy, thì Lưỡi Hổ Thái, Lưỡi Hổ Mèo, Lưỡi Hổ Vàng Hahnii cũng tương đối phổ biến.\r\nÝ nghĩa phong thuỷ\r\n\r\nCây Lưỡi Hổ thường được tặng / biếu vào các dịp lễ, Tết, dịp quan trọng như mừng tân gia, thăng chức, có ý nghĩa như lời chúc đến với bạn bè, đối tác, tân gia được may mắn, an cư lạc nghiệp, tài lộc dồi dào.\r\nTheo phong thuỷ, cây tượng trưng cho sức mạnh của loài hổ giúp xua đuổi ma quỷ, trừ tà ma. Lá lưỡi hổ mọc thẳng đứng từ gốc tượng trưng cho sức mạnh cá nhân.\r\nCây có màu xanh, viền vàng, hình lưỡi dao, hình thù và gam màu này phù hợp với các mệnh Thổ, Kim. Các tuổi thuộc 2 mệnh này sẽ hợp trồng Lưỡi Hổ trong nhà, tuy nhiên tuổi Ngọ thường được cho là hợp trồng nhất.\r\nCông dụng\r\n\r\nTheo nghiên cứu từ NASA, Lưỡi Hổ được chứng minh là hấp thụ độc tố gây ung thư như formaldehyde và nitrogen oxide... và thường được trồng tại các khu vực như nhà máy sản xuất, văn phòng toà nhà cao tầng.\r\nLưỡi Hổ rất phù hợp nhất đặt trồng trong phòng ngủ, vì nhờ cơ chế quang hợp CAM, cây thải ra Oxy vào ban đêm.\r\nThích hợp làm cây để bàn và trang trí trong nhà. Đặc biệt thường được trồng xen vào các tiểu cảnh sân vườn hoặc các thiết kế sân vườn mang tính phong thủy cao. \r\nNgoài ra, Lưỡi Hổ còn được dùng làm thuốc chữa bệnh rất hiệu quả trong Đông Y.\r\nCách chăm sóc\r\n\r\nÁnh sáng: Cây chịu được ánh nắng trực tiếp, nhưng vẫn sống khỏe mạnh trong nhà hoàn toàn hoặc bóng râm.\r\nĐất trồng: Cây có thể trồng được với mọi loại đất từ đất tốt đến đất khô cằn kể cả đất pha cát và sỏi. Đất trồng lưỡi hổ nên có độ kiềm cao.\r\nNước: Lưỡi hổ chịu hạn cực tốt, không nên tưới nhiều vì cây chịu úng rất kém. Thời tiết mùa đông,có thể tưới nước 1 tháng/ lần. Mùa hè khô hạn tăng cường hơn nhưng cũng ít hơn nhiều so với các giống cây trồng khác khoảng 1tuần/lần.\r\nNhiệt độ: Cây Lưỡi Hổ phát triển ở nhiệt độ ấm áp, nhiệt độ tối ưu cho sự phát triển từ 18-30oC, Nếu nhiệt độ dưới 10oC kéo dài quá lâu có thể làm lưỡi hổ kém phát triển và chết.\r\nĐộ ẩm: Lưỡi hổ ưa khô nên thích độ ẩm trung bình, nếu cao quá sẽ làm chết cây do thối rễ.\r\nPhân bón: Cây lưỡi hổ có khả năng phát triển mạnh mẽ, nhu cầu dinh dưỡng trung bình, khoảng vài tháng bạn bón phân cũng không sao, nhưng tránh bón vào mùa lạnh , lúc đó cây hấp thụ kém.', 'img_tree/caycanh/caydeban/cay-luoi-ho.jpg', 1, '2025-04-22 20:02:05'),
(6, 2, 'Cây Kim Tiền', 'cay-kim-tien', 200000.00, 5, 'Cây Kim Tiền là cây phong thuỷ số 1 được lựa chọn trang trí cho phòng khách, văn phòng, nhà hàng, khách sạn, hoặc làm quà tặng trong những dịp lễ, Tết, khai trương.\r\nLưu ý: Giá sản phẩm đã bao gồm chậu.', 'Giới thiệu cây Kim Tiền\r\n\r\nTên khác: Cây Kim Phát Tài\r\nTên tiếng Anh: ZZ Plant\r\nTên khoa học: Zamioculcas Zamiifolia\r\nHọ thực vật: Ráy (Araceae)\r\nXuất xứ: Châu Phi\r\nĐặc điểm\r\n\r\nKim Tiền là cây dễ trồng trong nhà, cây mọc thành bụi xanh mướt, phát triển tốt ở nơi ít ánh sáng, không cần tưới nước thường xuyên. \r\nCây có rễ chùm, thân chưa nhiều nước nên chịu hạn giỏi\r\nÝ nghĩa phong thủy\r\n\r\nKim Tiền có thân và lá cứng cáp, xanh tốt tượng trưng cho sự mạnh mẽ, kiên cường, tiếp thêm mạnh mẽ cho chủ nhân trước khó khăn cuộc sống.\r\nCây giúp mang tài lộc và thịnh vượng cho gia chủ. Kim Tiền ra hoa là dấu hiệu của sự may mắn, thành công sắp đến.\r\nCây hợp với người tuổi Tí.\r\nCây hợp với cả 5 mệnh trong ngũ hành, phù hợp nhất là Hoả, Mộc (Hoả cần lưu ý tránh trồng thuỷ sinh), mệnh Thuỷ nên chọn chậu màu trắng hoặc trồng thuỷ sinh sẽ phù hợp hơn, mệnh Kim - Thổ nếu trồng thì nên trang trí thêm các viên sỏi trắng hoặc vàng.\r\nCông dụng\r\n\r\nMang lại không gian xanh mát, đẹp mắt.\r\nDùng làm quà tặng trong các dịp quan trong như Lễ, Tết, thăng chức, khai trương\r\nTheo nghiên cứu của NASA, Kim Tiền giúp thanh lọc không khí, loại bỏ khói bụi, khí độc hại,... loại bỏ các chất gây hại như benzene, tolene, xylen và ethylbenzene.\r\nCách chăm sóc\r\n\r\nĐất: màu mỡ, tơi xốp và thoát nước tốt\r\nÁnh sáng: ưa sáng, thích hợp đặt ở chỗ bóng râm, có mái che.\r\nNước: 2 lần/tuần, tưới bằng bình xịt, tránh ngập nước, tránh mưa\r\nNhiệt độ: chịu được nhiệt độ cao, nhưng phát triển tốt nhất từ 25-27 độ C\r\nPhân bón: 1 tháng 1 lần, nên dùng phân hữu cơ hoặc vi sinh.\r\nLưu ý\r\nCây chứa nhiều calci oxalat gây kích thích da, niêm mạc môi, lưỡi, màng nhầy trong họng hoặc kết mạc mắt nếu ăn nhằm hoặc chạm phải dịch. Chất này có thể gây ra trạng thái nôn nao, khó thở, co giật, hôn mê,…\r\nCần cân nhắc việc trồng cây nếu trong nhà có trẻ nhỏ và phải đeo găng tay khi cắt, tỉa cành lá.', 'img_tree/caycanh/caydeban/cay-kim-tien.jpg', 1, '2025-04-22 20:02:05'),
(7, 2, 'Cây Hương Thảo', 'cay-huong-thao', 240000.00, 10, 'Cây Hương Thảo có khả năng làm giảm stress, đuổi muỗi, làm gia vị, chế biến mỹ phẩm,…\r\nLưu ý: Giá sản phẩm đã bao gồm chậu.', 'Giới thiệu\r\n\r\nTên thông thường: Cây Hương Thảo\r\nTên khác: Tây Dương Chổi\r\nTên khoa học: Rosemary.\r\nXuất xứ: Địa Trung Hải\r\nĐặc điểm\r\n\r\nCây mọc thành bụi, ngoài tự nhiên có thể cao tối đa 1-2m.\r\nLá cây thuôn ngắn (trông như lá hoa Mười giờ nhưng mảnh hơn)\r\nCông dụng\r\n\r\nCây hương thảo có khả năng làm giảm stress, đuổi muỗi, làm gia vị, chế biến mỹ phẩm,…\r\nChưng bày một vài cây hương thảo giúp vừa đem lại nét đẹp cho ngôi nhà bạn, vừa giúp bạn thư thái tinh thần.\r\nCây tỏa ra mùi hương thơm ngát, mùi dễ chịu, mùi tinh dầu cực thơm và dễ chịu. Mùi có thể khuyếch tán trong phòng rộng 15m2 vẫn có mùi thơm. Còn đối với nhân viên văn phòng khi phải thường xuyên làm việc căng thẳng, mùi hương cây hương thảo có thể giúp tinh thần thoải mái, giải tỏa stress nhanh nhất, giúp chống buồn ngủ, tạo hưng phấn khi làm việc.\r\nÝ nghĩa phong thuỷ\r\n\r\nLà biểu tượng của lòng trung thành\r\nTheo phong thuỷ, cây trừ được tà ma, mang lại may mắn, bình an cho chủ nhân.\r\nCây Hương Thảo hợp với tất cả các tuổi và mệnh, nhưng tuỳ vào bản mệnh mà bày trí theo hướng phù hợp nhất, như mệnh Mộc thì đặt hướng Đông - Đông Nam, Hoả thì hướng Tây Nam - Nam.\r\nLưu ý khi trồng\r\n\r\nLà loại thảo mộc nên cây có rễ chùm, mảnh. Cây thích hợp với đất có độ rút nước tốt, không chịu được úng. Tỉ lệ đất trồng như sau: 30% cát, 40% tro trấu, 20% sơ dừa xay, 10% phân vi sinh.\r\nNếu trồng ra đất , tốt nhất là đất thịt trộn thêm ít tro trấu và xơ dừa\r\nLà loài cây ưa nắng râm, mới mua về thì buổi trưa nắng gắt nên chuyển cây trong mát để tránh cháy lá, khô tinh dầu tốt nhất là để dưới lưới giống trồng hoa lan hoặc bóng mát\r\nKhi tưới cây hương thảo cần phun trên lá nước vừa ướt chậu là được, nếu nắng quá thì tưới thêm nước hoặc chiều phun lại lần nữa cho cây hương thảo.\r\nCây ưa nước nên cần tưới đẫm bề mặt đất, tránh trường hợp tưới quá nhiều gây hiện tượng úng rễ.', 'img_tree/caycanh/caydeban/cay-huong-thao.jpg', 1, '2025-04-22 20:03:57'),
(8, 2, 'Cây Hồng Môn', 'cay-hong-mon', 190000.00, 8, 'Cây Hồng Môn tượng trưng cho tình yêu và lòng hiếu khách, cây phù hợp để bày phòng khách, quầy lễ tân, nơi nhiều người thường xuyên qua lại, hoặc để trang trí nội thất đều rất hợp.\r\nLưu ý: Giá sản phẩm đã bao gồm chậu.', 'Giới thiệu\r\n\r\nXuất xứ từ Colombia và Ecuador.\r\nLà chi lớn nhất thuộc họ ráy Araceae với khoảng 600 – 800 ( có thể 1.000 ) loài phân bố ở vùng Trung và Nam Mỹ. Được phát hiện năm 1876 ở Colombia.\r\nTên gọi khác như: Môn Hồng, Vĩ Hoa Tròn, Buồm Đỏ…\r\nTên khoa học: Anthurium Andraeanum\r\nNgày xưa được nhà truyền giáo người Anh S.M.Damon đem từ Colombia đến Hawaii. Bén duyên với quê hương mới, nếu có dịp đến Hawaii bạn sẽ thấy cây Hồng Môn đã trở thành một trong những cây đặc trưng cho quần đảo Hawaii, được người dân ở đây còn yêu mến gọi chúng là “trái tim Hawaii”.\r\nÝ nghĩa phong thuỷ\r\n\r\nCây Hồng Môn trong phong thủy tượng trưng cho tình yêu, lòng hiếu khách.\r\nCây có nhiều hoa màu đỏ, hồng, vàng nên rất phù hợp với người thuộc mệnh Hỏa và mệnh Thổ. Hồng Môn sẽ mang đến tài lộc và may mắn cho những người bản mệnh này.\r\nCông dụng\r\n\r\nCây phù hợp làm cây để bàn, phòng khách, quầy lễ tân, trang trí quán cà phê, các góc nhỏ trong nhà.\r\nVới thân hình nhỏ nhắn, xinh xắn và nổi bật của những bông hoa màu đỏ hình trái tim trên những chiếc lá màu xanh, Hồng Môn được xem là lựa chọn hàng đầu để trang trí cho không gian sống.\r\nGiúp giảm stress, tăng hứng khởi, kích thích khả năng sáng tạo nhằm tăng hiệu quả công việc.\r\nHồng Môn là loài cây tượng trưng cho tình yêu nên đây cũng là một món quà tặng mang ý nghĩa to lớn. Nhiều người quan niệm rằng tình yêu sẽ bền chặt nếu tặng hồng môn cho người mình yêu thương.\r\nCây có tác dụng thanh lọc không khí hiệu quả. Những chiếc lá bản to, dày còn có khẳ năng hấp thụ những khí độc hại trong không khí như xylen, benzen, formandehit,... Những chất này gây nên các bệnh về đường hô hấp thậm chí dẫn đến bệnh ung thư.\r\nCách chăm sóc cây Hồng Môn\r\n\r\nThuộc dòng cây cảnh văn phòng nên Hồng Môn rất dễ sống và chăm sóc, hoa dạng lưỡng tính nên hoa cũng ra liên tục.\r\n\r\nNước tưới: Cây Hồng Môn khá ưa nước vì vậy cần tưới nước thường xuyên cho cây. Nên tưới từ 2-3 lần/tuần và mỗi lần tưới từ khoảng 200-500 ml nước tùy vào độ lớn của chậu. Với những cây sống trong môi trường máy lạnh hoặc vào mùa đông nên giảm lượng nước tưới và số lần tưới cây.\r\nNhiệt độ  thích hợp đối với cây Hồng Môn là từ 15 – 30 độ C, nếu nhiệt độ thấp hơn 15 độ c thì cây sẽ sinh trưởng và phát triển chậm, còn nếu trên 30 độ c thì cây bị vàng lá, thối lá, thậm chí là chết. \r\nĐất trồng: Cây Hồng Môn ưa loại đất có nhiều phù sa, tơi xốp, bạn có thể trộn phân chuồng hoặc phân hữu cơ đã được ủ hoai mục, trấu hun, xơ dừa…để tạo nên loại đất ưu thích giúp cây phát triển nhanh hơn.\r\nBệnh thường gặp: Cây Hồng Môn rất ít sâu bệnh thường có một số bệnh thường gặp như thối củ, thối gốc thối thân…Để các bệnh được hạn chế thì bạn nên cắt tỉa bớt lá già, làm sạch cỏ trong chậu để tạo độ thông thoáng, duy trì độ ẩm và ánh sáng thích hợp nhằm hạn chế nấm bệnh phát sinh, phát triển và gây hại.\r\nLưu ý khi trồng cây Hồng Môn\r\n\r\nCũng giống như những cây họ Ráy khác, trong lá của cây Hồng Môn cũng có chứa chất oxalate. Chất này gây kích ứng lên các niêm mạc mắt, miệng lưỡi,... Vì vậy khi trồng và chăm sóc cây bạn nên sử dụng găng tay để được đảm bảo an toàn. Đồng thời tránh đặt cây ở những nơi mà trẻ em và vật nuôi thường tiếp xúc để tránh bị ăn phải gây nguy hiểm.', 'img_tree/caycanh/caydeban/cay-hong-mon.jpg', 1, '2025-04-22 20:05:22'),
(9, 2, 'Cây Bàng Singapore', 'cay-bang-singapore', 155000.00, 10, 'Cây Bàng Singapore là loại cây kiểng mới lạ, độc đáo, thích hợp trang trí ở nhiều nơi như bàn làm việc, phòng họp, phòng khách,...\r\nLưu ý: Giá sản phẩm đã bao gồm chậu.', 'Giới thiệu\r\n\r\nTên gọi khác: cây Bàng Vuông, Bàng Lá To\r\nTên khoa học: Ficus Lyata, Fiddle-leaf fig\r\nHọ thực vật: Moraceae\r\nĐặc điểm\r\n\r\nCây có dáng cây thẳng, lá đơn mọc cách, to, tán lá rộng, đầu lá bầu tròn, màu xanh thẫm\r\nChiều cao trung bình từ 0,5-2m (để bàn hoặc trang trí nội thất đều được)\r\nNhân giống dễ dàng bằng cách chiết cành hoặc ươm từ hạt\r\nÝ nghĩa phong thủy\r\n\r\nCây mọc thẳng, tượng trưng cho sự chịu khó, cần cù và ý chí vươn lên trong cuộc sống\r\nRất thích hợp với người mệnh Mộc và Hỏa\r\nCông dụng\r\n\r\nLà loại cây kiểng mới lạ, độc đáo, thích hợp trang trí ở nhiều nơi như bàn làm việc, phòng họp, phòng khách,...\r\nKhả năng lọc không khí, khói bụi rất cao\r\nCách trồng\r\n\r\nĐất: đất tơi, xốp, có thể trộn đất thịt với phân sinh học, hữu cơ. Thay đất trong chậu 1 lần/năm hoặc thay chậu nếu cây phát triển quá lớn\r\nÁnh sáng: ánh sáng nhẹ, có thể sống được trong bóng râm, đèn huỳnh quang, không thích hợp trồng trực tiếp nơi có ánh sáng quá gắt bởi lá cây sẽ bị phai màu\r\nNước: tưới vừa đủ, mùa hè tưới 1 tuần/ lần; hạn chế tưới nước vào mùa đông, khoảng 2 tuần/lần\r\nNhiệt độ: lý tưởng nhất là khoảng 16-27 độ C\r\nPhân bón: bón phân cho cây khoảng 2-3 tháng/lần, có thể sử dụng phân bón lỏng pha loãng hoặc phân bón ngâm trong nước\r\nSâu bệnh: vệ sinh cây, lau lá thường xuyên để đảm bảo quang hợp tốt và luôn giữ được vẻ đẹp cho cây; cắt tỉa những lá vàng, lá bị sâu bệnh tấn công. Bên cạnh đó cần tỉa ngọn để kiểm soát chiều cao của cây', 'img_tree/caycanh/caydeban/cay-bang-singapore.jpg', 1, '2025-04-22 20:05:22'),
(10, 3, 'Cây Vạn Lộc thủy sinh', 'cay-van-loc-thuy-sinh', 190000.00, 9, 'Cây Vạn Lộc thủy sinh mang đến vẻ đẹp sang trọng, bắt mắt. Cây giúp gia chủ thêm tài lộc, may mắn\r\nLưu ý: Giá sản phẩm đã bao gồm chậu.', 'Giới thiệu cây Vạn lộc thuỷ sinh\r\n\r\nTên thường gọi: Vạn lộc\r\nTên khác: Thiên Phú\r\nTên khoa học: Aglaonema rotundum pink\r\nHọ: Araceae\r\nXuất xứ: Thái Lan, Indonesia\r\nĐặc điểm\r\n\r\nLà cây thân thảo, có lá màu hồng đậm khi già, lá non màu hồng nhạt, có rễ chùm, dễ sống và chăm sóc.\r\nHoa màu trắng, có rễ trùm nên rất dễ sống và chăm sóc.\r\nÝ nghĩa phong thuỷ\r\n\r\nMang đến tài lộc và may mắn\r\nCây vốn hợp mệnh Hoả, nhưng do trồng thuỷ sinh nên mệnh này hạn chế trồng.\r\nCông dụng\r\n\r\nThanh lọc không khí, hấp thụ các chất hữu cơ gây bệnh\r\nPhù hợp để bàn làm việc, bàn uống nước, trang trí quán cà phê\r\nCách chăm sóc\r\n\r\nÁnh sáng: ưa mát, thích ánh sáng nhẹ buổi sáng sớm và chiều muộn, thích hợp để cạnh cửa sổ, thoảng cho ra ngoài nắng để màu cây tốt hơn.\r\nNước: thay nước 1 lần / tuần. Với nước máy thì nên đổ ra xô, thau phơi ngoài sáng khoảng 3 giờ rồi hãy tiến hành thay nước. Khi lấy cây ra khỏi chậu thì cẩn thận làm đứt bộ rễ.\r\nPhân bón: sử dụng các loại dung dịch phù hợp với cây thuỷ sinh, tần suất cho dung dịch vào nước phải tuân theo khuyến cáo in trên chai.\r\nÁnh sáng: không nên để dưới ánh sáng trực tiếp quá lâu, nếu để liên tục nhiều giờ trong phòng thì nên chủ động đặt ra ngoài tầm 30-60 phút mỗi ngày.', 'img_tree/caycanh/caythuysinh/cay-van-loc-thuy-sinh.jpg', 1, '2025-04-22 20:08:01'),
(11, 3, 'Cây Phú Qúy thủy sinh', 'cay-phu-quy-thuy-sinh', 150000.00, 7, 'Cây Phú Quý thuỷ sinh rất được ưa chuộng bởi có khả năng thanh lọc không khí, giảm bớt ô nhiễm khói bụi, giúp cải thiện không gian sống. Ngoài ra cây còn là biểu tượng của phú quý, mang tài lộc đến cho gia chủ\r\nLưu ý: Giá sản phẩm đã bao gồm chậu.', 'Giới thiệu cây Phú Quý thuỷ sinh\r\n\r\nTên thường gọi: Cây phú quý\r\nTên khoa học: Aglaonema Hybrid \'Pride of Sumatra\'\r\nXuất xứ: Indonesia\r\nĐặc điểm\r\n\r\nCây Phú Quý có rễ chùm, to khỏe với thật nhiều rễ con dài khoảng 4-6cm màu trắng ngà\r\nThân cây được tạo thành bằng những bẹ lá, cuống lá có màu trắng hồng\r\nLá mỏng, viền lá có màu hồng đỏ, bên trong có màu xanh đậm\r\nCây rất dễ sống và chăm sóc, có thể trồng đất hoặc thủy sinh\r\nÝ nghĩa phong thuỷ\r\n\r\nLà loài cây biểu tượng cho sự may mắn, sang giàu. Trồng cây trong nhà, đặt nơi văn phòng giúp mang đến tài lộc dồi dào, tiền vào như nước, may mắn, suôn sẻ trong mọi việc.\r\nCây vốn dĩ phù hợp với mệnh Hỏa nhưng do trồng thuỷ sinh nên người mệnh này hạn chế trồng vì Thuỷ khắc Hoả. Mệnh Thổ thì có thể trồng một chậu Phú Quý trong nhà cũng mang lại nhiều phong thủy tốt lành.\r\nCông dụng\r\n\r\nGiúp thanh lọc không khí vô cùng tốt.\r\nGiảm bớt căng thẳng, giúp thư giãn trước những áp lực của công việc hàng ngày.\r\nCách chăm sóc\r\n\r\nÁnh sáng: Là cây ưa bóng mát, loài cây này có thể sống được trong môi trường ít ánh sáng, chỉ có ánh sáng điện huỳnh quang thôi, nó cũng có thể sinh trưởng và phát triển, tuy nhiên để lá lên màu đẹp thì bạn nên để cây ở nơi có ánh sáng buổi sớm và chiều muộn, tránh ánh nắng buổi trưa mùa hè có nhiệt độ cao sẽ khiến lá bị cháy nhìn sẽ không được đẹp.\r\nNước: cây Phú Quý trồng thủy sinh cần thay nước trong chậu 1 lần/tuần. Khi thay nước, lưu ý rửa sạch bộ rễ, lau sạch thành chậu trong và ngoài.\r\nPhân bón: sử dụng dung dịch thuỷ sinh bán theo cây \r\nNhiệt độ: nhiệt độ từ 15–28°C là nhiệt độ lý tưởng. Nhưng trong điều kiện khắc nhiệt thì cây vẫn có thể chịu đựng được nhiệt độ dưới 10°C hoặc trên 35°C. Tuy nhiên đối với nhiệt độ cao hơn hoặc thấp quá cây sẽ chậm hoặc ngừng phát triển.', 'img_tree/caycanh/caythuysinh/cay-phu-quy-thuy-sinh.jpg', 1, '2025-04-22 20:08:01'),
(12, 3, 'Cây Phát Tài thủy sinh', 'cay-phat-tai-thuy-sinh', 155000.00, 4, 'Cây Phát Tài thuỷ sinh dùng để trang trí bàn làm việc, nơi có không gian nhỏ, cây mang tính phong thủy đêm lại may mắn tài lộc cho nhiều người.\r\nLưu ý: Giá sản phẩm đã bao gồm chậu.', 'Giới thiệu cây Phát Tài thuỷ sinh\r\n\r\nTên thường gọi: Phát Tài \r\nTên khác:Phát Tài Trồng Nước\r\nTên khoa học: Dracaena deremensis\r\nHọ: Phát tài, trường sinh\r\nXuất xứ: Châu Á\r\nĐặc điểm\r\n\r\nPhát tài là cây thuộc thân bụi nhỏ, kích thước tầm 20-30cm nhỏ gọn, sống trong mát\r\nCó lá màu xanh, lá già cứng và màu xanh đậm hơn lá non, lá non màu xanh nhạt và bóng, lá cây mọc thành bẹ ôm sát thân, hầu như mọc xen kẻ quanh thân, tạo thành hình dáng như một búp sen hé nở\r\nLá xanh bóng vuốt nhọn ở cuối lá, hơi mo cong như móng tay dài. Lá dài khoảng 5-7cm, rộng khoảng 2-3cm, mềm và dễ gãy.\r\nThân mọc thẳng đứng, một gốc một thân, lột bẹ lá lộ ra thân trắng tinh, một thân có nhiều đốt nhỏ, giòn và dễ bẻ gãy.\r\nRễ trắng buốt, mọc bên dưới cùng của thân, một cây mọc tới hơn hai lớp rễ, dài và chắc khỏe, rễ hút nước khoẻ nên lá cây lúc nào cũng xanh bóng, ngoài ra rễ còn lọc được các chất cặn bẩn trong nước.\r\nÝ nghĩa phong thuỷ\r\n\r\nTheo phong thủy, cây giúp mang lại may mắn tiền tài và cả danh vọng.\r\nTùy nhu cầu và nơi đặt mà có số lượng cây cho phù hợp, thông thường sử dụng 3 cây vào một bình, vì nó mang ý nghĩa hạnh phúc, sum vầy, may mắn và thành công, còn dùng hai cây thì mang ý nghĩa bền vững, trong tình bạn ngày càng thân thiết, trong tình yêu thì gắn kết bền chặt.\r\nPhát Tài Búp Sen thuỷ sinh hợp với người mệnh Kim.\r\nCông dụng\r\n\r\nPhát tài búp sen trồng chủ yếu để trang trí nội thất trong nhà ở, văn phòng làm việc, hay ở không gian trưng bày…\r\nNgoài ra cây này cũng sử dụng khá phổ biến để trang trí bên cạnh bàn thờ thần linh, các bậc thánh nhân…\r\nCó tác dụng lọc nước khá tốt, lọc các chất bẩn\r\nLàm quà tặng dịp tân gia, khai trương, như lời chúc tốt đẹp đến người nhận\r\nCách chăm sóc\r\n\r\nNước: một tuần thay nước một lần, hoặc nếu trồng bán thuỷ sinh thì châm thêm nước nếu mực nước hiện tại quá nông, rễ cây không hấp thụ được hoàn toàn.\r\nÁnh sáng: tránh ánh sáng trực tiếp.\r\nPhân bón: sử dung dung dịch thuỷ sinh bán theo cây\r\nNhân giống: bằng cách giâm cành', 'img_tree/caycanh/caythuysinh/cay-phat-tai-thuy-sinh.jpg', 1, '2025-04-22 20:08:01'),
(13, 3, 'Cây Nha Đam thủy sinh', 'cay-nha-dam-thuy-sinh', 150000.00, 15, 'Cây Nha Đam Thuỷ Sinh có thể mang lại may mắn cho người sở hữu, giúp gia chủ giữ được tinh thần thoải mái, minh mẫn khi làm việc, cây có khả năng thanh lọc không khí, giải phóng oxy, hút các khí có hại cho cơ thể.\r\nLưu ý: Giá cây đã bao gồm chậu.', 'Giới thiệu cây Nha Đam Thuỷ Sinh\r\n\r\nTên khác: Lô Hội, La Hội, Lao Vỹ, Tượng Can\r\nTên khoa học: Aloe Vera\r\nHọ: Asphodelaceae\r\nXuất xứ: Trung cận Đông\r\nĐặc điểm\r\n\r\nCây có gốc, thân ngắn, lá không có cuống, mọc sát thân, hướng lên trên\r\nLá to, dày, mọng nước, có hình lưỡi giáo, vỏ màu xanh tươi đẹp mắt, phần gốc mọc dày và theo chiều mở dần ra.\r\nMép lá có răng nhọn như gai.\r\nHoa mọc thành cụm, cành hoa dài khoảng 10cm. Hoa dài 3-4cm, màu vàng hoặc màu đỏ.\r\nÝ nghĩa phong thủy\r\n\r\nMang lại may mắn cho người sở hữu, giúp gia chủ giữ được tinh thần thoải mái, minh mẫn khi làm việc.\r\nCông dụng\r\n\r\nCó khả năng thanh lọc không khí, giải phóng oxy, hút các khí có hại cho cơ thể.\r\nĐược đặt ở những nơi thiếu ánh sáng như phòng khách, phòng ngủ, nhà tắm… tạo màu xanh cho ngôi nhà\r\nTạo sự mới mẻ, lạ mắt cho bàn làm việc, bàn học... giúp bạn có cảm giác thư giãn và thoải mái hơn trước những bế tắc của công việc.\r\nCây còn có tác dụng trong làm đẹp, sát khuẩn, kháng viêm, tốt cho dạ dày và đường ruột, khỏe tim hoạt huyết, giảm đau, giúp trấn tĩnh, phòng ngừa lão hóa.\r\nCách trồng\r\n\r\nÁnh sáng: cần đủ ánh sáng cây để phát triển tốt, có thể sống trong môi trường thiếu sáng, nhưng khoảng từ 3-5 ngày nên cho cây ra ngoài ánh sáng để quang hợp.\r\nNhiệt độ: cây sợ lạnh và sương, nhiệt độ thích hợp nên vào khoảng 15-35 độ C.\r\nNước: thay nước định kì, tuần 1 lần.\r\nPhân bón: dùng dung dịch dinh dưỡng để bón, nhỏ trực tiếp vào bình thủy sinh. Lưu ý đừng dùng nhiều, một giọt nhỏ mỗi lần bón là đủ.', 'img_tree/caycanh/caythuysinh/cay-nha-dam-thuy-sinh.jpg', 1, '2025-04-22 20:09:37'),
(14, 3, 'Cây Hoa Tiên Ông', 'cay-hoa-tien-ong', 240000.00, 11, 'Cây hoa Tiên Ông được mệnh danh là “giáng Tiên” mang an khang đến cho mọi người, khá thích hợp để trồng trong nhà, bàn làm việc hoặc chưng dịp Tết', 'Giới thiệu cây Hoa Tiên Ông\r\n\r\nTên gọi khác: cây Dạ Lan Hương\r\nTên khoa học: Hyacinthus orientalis\r\nHọ thực vật: Hyacinthaceae, thuộc bộ Măng tây\r\nCây nở hoa vào ban đêm, có mùi hương dễ chịu và màu sắc đẹp\r\nĐặc điểm\r\n\r\nRễ trắng muốt như râu tiên ông nên cây mới có tên gọi là hoa Tiên Ông\r\nCây có củ bầu đầu nhọn và màu tím như củ hành tím, nhưng lớn hơn\r\nLá mọc lên từ đầu củ, màu xanh thuôn dài bao quanh hoa.\r\n\r\nHoa có nhiều màu (xanh, trắng, tím, hồng) mọc thành chùm với hương thơm quyến rũ\r\nÝ nghĩa phong thủy \r\n\r\nCây mang bình an, may mắn đến cho mọi người\r\nĐẩy lùi mọi xấu xa, xui xẻo ra khỏi cuộc sống của bạn\r\nCông dụng\r\n\r\nCây có hương thơm rất quyến rũ, trồng trong nước rất đẹp, thích hợp để trang trí trên bàn phòng khách, phòng làm việc\r\nLà cây hoa được trồng chưng nhiều trong dịp Tết Nguyên Đán\r\nCách trồng\r\n\r\nChọn củ: lành lặn, không dập nát hay bong tróc, vỏ bóng màu sắc sáng và không có mùi hôi. Đường kính củ tầm 4-5cm\r\nBảo quản củ: buộc kín bằng một túi đen và để ở nơi mát có nhiệt độ từ 2-8 độ C (có thể cho vào tủ lạnh)\r\nTrồng đất: cần đất tơi, xốp và giàu dinh dưỡng. Gồm xơ dừa, trấu hun, phân chuồng hoai mục và đất được trộn theo tỷ lệ 1:1:1:1\r\nTrồng nước: cần thay nước 1 lần/ngày, pha thêm nước ấm để kích hoa nở\r\nÁnh sáng: nên đặt cây trong phòng máy lạnh ánh sáng huỳnh quang, tránh nắng gắt\r\nNhiệt độ: tầm 10 độ C sẽ ra rễ trắng dài, 18 độ C thì phát triển chồi hoa\r\nPhân bón: bón phân vi sinh nếu cây trồng đất và pha thêm dung dịch dinh dưỡng nếu trồng thủy sinh', 'img_tree/caycanh/caythuysinh/cay-hoa-tien-ong.jpg', 1, '2025-04-22 20:09:37'),
(15, 5, 'Cây Trầu Bà chậu treo', 'cay-trau-ba-chau-treo', 190000.00, 8, 'Cây Trầu Bà chậu treo thể hiện mong muốn may mắn, sự nghiệp thành đạt, lên đường bình an, thường được dùng làm cây nội thất, cây văn phòng, treo cửa sổ, ban công hay có giàn treo riêng.\r\nLưu ý: Giá sản phẩm đã bao gồm chậu.', 'Giới thiệu cây Trầu Bà Vàng\r\n\r\nTên khoa học: Philodendron erubescens ‘gold’\r\nHọ: Araceae (họ ráy)\r\nThường cao từ 20 – 30 cm\r\nĐặc điểm\r\n\r\nLà cây thân thảo, có rễ khí sinh, thân tròn màu vàng nhạt Lá đơn, màu xanh vàng và cuống lá màu hồng nhạt.\r\nLá thuôn dài, nhọn ở đỉnh, hình tim ở gốc.\r\nLá có chiều dài khoảng 13 cm và rộng 6 cm\r\nÝ nghĩa phong thủy\r\n\r\nThể hiện mong muốn may mắn, sự nghiệp thành đạt, lên đường bình an\r\nCông dụng\r\n\r\nThường được dùng làm cây nội thất, cây văn phòng, có thể trồng chậu đứng làm cây trầu bà vàng leo cột, trồng chậu đất để bàn hay trồng nước.\r\nTrồng viền, nền trong cảnh quan, thường thấy dưới các chân cầu vượt, bồn cây.\r\nLàm tường cây\r\nLàm sạch không khí, loại bỏ Aldehyde formic và một số chất độc nguy hiểm\r\nCách trồng\r\n\r\nÁnh sáng: ưa bóng bán phần hoặc hoàn toàn râm mát, không nên để tiếp xúc trực tiếp với ánh nắng\r\nNhiệt độ: yêu cầu nhiệt độ cao, sợ lạnh, thích hợp nhiệt độ 18 – 25 độ C\r\nNước: ưa ẩm, cần nhiều nước trong quá trình sinh trưởng\r\nĐất: ưa đất màu mỡ, ẩm và thoát nước tốt\r\nPhân bón: bón định kỳ bằng phân lỏng hoặc phân đạm vô cơ để lá cây mọc khỏe và màu đẹp.', 'img_tree/caycanh/caychautreo/cay-trau-ba-chau-treo.jpg', 1, '2025-04-22 20:11:00'),
(16, 5, 'Cây Lam Tím ', 'cay-lam-tim', 190000.00, 5, 'Cây Lan Tim chứa từng cặp lá mọc đối nhau giống từng đôi tim yêu của các cặp tình nhân quấn quýt không muốn xa rời.\r\nLưu ý: Giá sản phẩm đã bao gồm chậu.', 'Giới thiệu cây Lan tim\r\n\r\nTên thường gọi: Lan tim, Khúc Thủy\r\nHọ: Asclepiadaceae (họ Thiên lý)\r\nXuất xứ: Thái Lan\r\nĐặc điểm\r\n\r\nLà loại dây leo xanh quanh năm, sống lâu và bền bỉ.\r\nLà cây thân thảo, mền mại, phân nhiều mánh mọc từ gốc rũ xuống.\r\nLá hình trái tim đẹp, mọc đối xứng, màu xanh đậm, bóng nhắn đầu lá \r\nCông dụng\r\n\r\nDùng trang trí nhà hàng, quán cafe, ban công, sân thượng\r\nÝ nghĩa phong thuỷ\r\n\r\nCây đem đến cho bạn cảm giác ấm áp, yên bình. Là món quà ý nghĩa dành tặng cho người thương yêu, là quà tặng thể hiện tình cảm đôi lứa.\r\nCách chăm sóc\r\n\r\nÁnh sáng: phát triển tốt trong điều kiện ánh sáng trung bình.\r\nNước: có khả năng chịu hạn tốt, không cần lo nếu quên tưới nước. Tất nhiên sẽ tươi tốt nếu được tưới đầy đủ\r\nĐất: Đất trồng cây lan tim cần đảm bảo thoát nước tốt.\r\nPhân bón: khoảng 15-30 ngày trong quá trình tưới nước nên bón phân, cung cấp dưỡng chất bằng phân bón hữu cơ tan chậm hay que dinh dưỡng sinh học để bổ sung dinh dưỡng cho cây trồng\r\nBệnh: Khi lá vàng, nhặt bỏ ngay hoặc cắt tỉa để thúc đẩy quá trình phát triển tốt nhất của cây.', 'img_tree/caycanh/caychautreo/cay-lan-tim.jpg', 1, '2025-04-22 20:11:00'),
(17, 5, 'Cây Hoa Hải Đường', 'cay-hoa-hai-duong', 240000.00, 8, 'Cây hải đường thể hiện cho sự tinh thiết, thanh cao may mắn và tài lộc nên rất nhiều gia đình lựa chọn hoa hải đường trong dịp tết để trưng bày. \r\nLưu ý: Giá sản phẩm đã bao gồm chậu.', NULL, 'img_tree/caycanh/caychautreo/cay-hoa-hai-duong.jpg', 1, '2025-04-22 20:12:19'),
(18, 4, 'Cây Xương Rồng Xanh', 'cay-xuong-rong-xanh', 190000.00, 15, 'Cây Xương Rồng Xanh tượng trưng cho sự bền chặt, lâu dài trong tình bạn, tình yêu. Đại diện cho sự không ngừng cố gắng vươn lên, tạo năng lượng tích cực trong cuộc sống.\r\nLưu ý: Giá cây đã bao gồm chậu.', 'Giới thiệu cây Xương Rồng Xanh\r\n\r\nTên khác: Tai Thỏ Xanh\r\nXương rồng xanh nổi bật bởi dáng vẻ nhỏ nhắn, là một hình ảnh thu nhỏ của các loại xương rồng lớn ngoài tự nhiên.\r\nĐặc điểm\r\n\r\nThân cây xanh, có gai mọc thưa chứ không dày đặc như các loại xương rồng khác.\r\nTừ thân chính mọc ra nhiều lá con có kích cỡ lớn nhỏ khác nhau.\r\nNở hoa màu tím to bằng đầu ngón tay út, một cây có thể ra 2,3 hoa 1 lúc.\r\nÝ nghĩa phong thủy\r\n\r\nCây tượng trưng cho sự bền chặt, lâu dài trong tình bạn, tình yêu Đại diện cho sự không ngừng cố gắng vươn lên, tạo năng lượng tích cực trong cuộc sống\r\nCông dụng\r\n\r\nTrang trí bàn làm việc, gia tăng hứng khởi, giúp tinh thần thoải mái\r\nQuà tặng ý nghĩa cho bạn bè, người quen\r\nCách trồng\r\n\r\nĐất: sử dụng hỗn hợp đất thường trồng cho các loại xương rồng, sen đá\r\nNước: tưới ít nước, 8-10 ngày tưới 1 lần, tưới xa gốc, không tưới trực tiếp lên thân', 'img_tree/caycanh/senda_xuongrong/cay-xuong-rong-xanh.jpg', 1, '2025-04-22 20:14:08'),
(19, 4, 'Cây Sen Đá Xanh', 'cay-sen-da-xanh', 90000.00, 9, 'Cây Sen Đá Xanh mang ý nghĩa về tình yêu, tình bạn vĩnh cửu theo thời gian, cây phù hợp trang trí bàn làm việc, góc học tập.\r\nLưu ý: Giá sản phẩm đã bao gồm chậu.', 'Giới thiệu cây Sen Đá Xanh\r\n\r\nTên khác: Liên Đài Xanh\r\nTên khoa học: Echeveria\r\nHọ: thuốc bỏng (Crassualaceae)\r\nĐặc điểm\r\n\r\nCây Sen Đá Xanh thường cao từ 10-20cm, lá mọng nước và xếp vòng xoắn quanh thân như bông hoa sen, lá có màu xanh ngọc, hơi xám của phấn phủ trên lá.\r\nCây có hoa lưỡng tính.\r\nÝ nghĩa phong thủy\r\n\r\nCây mang ý nghĩa về tình yêu, tình bạn vĩnh cửu theo thời gian.\r\nCông dụng\r\n\r\nPhù hợp trang trí bàn làm việc, góc học tập.\r\nCách trồng\r\n\r\nÁnh sáng: cây ưa sáng, chịu được nắng trực tiếp nhưng tốt nhất dưới giàn che để giảm bớt cường độ. Nếu đặt trong phòng, thì cỡ 2 ngày mang ra phơi nắng 1 lần\r\nNước: 2 ngày tưới nước 1 lần\r\nĐất: không kén đất, phù hợp với nhiều loại đất Nhiệt độ: cây ưa mát, phát triển tốt từ 15-35 độ C.\r\nPhân bón: không cần nhiều dinh dưỡng, có thể bổ sung phân dê, phân bò', 'img_tree/caycanh/senda_xuongrong/cay-sen-da-xanh.jpg', 1, '2025-04-22 20:14:08'),
(20, 7, 'Chậu đất nung đỏ 5x5', 'chau-dat-nung-do', 10000.00, 12, 'Kích thước:   5x5 cm\r\nMàu sắc:       Đỏ\r\nChất liệu:      Đất nung\r\nKiểu dáng:    Trụ tròn vát', 'Chậu đất nung làm bằng chất liệu đất nung Bát Tràng nhỏ nhắn xinh xắn thích hợp trồng sen đá xương rồng tiểu cảnh\r\n- Chậu được làm từ chất liệu đất nung, có khả năng hút nước tốt, giúp cây không bị úng nước.\r\n- Với hình dạng và màu sắc chậu vô cùng đa dạng, rất thích hợp để trồng các cây cảnh văn phòng, cây cảnh để bàn, cây cảnh mini, tiểu cảnh sen đá, xương rồng, trang trí bàn làm việc, bàn học.\r\n\r\n- Đáy chậu có lỗ thoát nước.\r\n- Cam kết sản phẩm giống như hình\r\n- Sản phẩm 100% thủ công mỹ nghệ của làng gốm cổ truyền Bát Tràng.\r\n- Giá rẻ tận lò nung', 'img_tree/chaucanh/chaudatnung/chau-gom-dat-nung-nau-5x5.jpg', 1, '2025-04-22 20:16:07'),
(21, 7, 'Chậu đất nung trắng', 'chau-dat-nung-trang', 10000.00, 10, 'Kích thước:   10x5 cm\r\nMàu sắc:       Trắng\r\nChất liệu:      Đất nung\r\nKiểu dáng:    Bầu tròn vát', 'Chậu đất nung làm bằng chất liệu đất nung Bát Tràng nhỏ nhắn xinh xắn thích hợp trồng sen đá xương rồng tiểu cảnh\r\n- Chậu được làm từ chất liệu đất nung, có khả năng hút nước tốt, giúp cây không bị úng nước.\r\n- Với hình dạng và màu sắc chậu vô cùng đa dạng, rất thích hợp để trồng các cây cảnh văn phòng, cây cảnh để bàn, cây cảnh mini, tiểu cảnh sen đá, xương rồng, trang trí bàn làm việc, bàn học.\r\n\r\n- Đáy chậu có lỗ thoát nước.\r\n- Cam kết sản phẩm giống như hình\r\n- Sản phẩm 100% thủ công mỹ nghệ của làng gốm cổ truyền Bát Tràng.\r\n- Giá rẻ tận lò nung', 'img_tree/chaucanh/chaudatnung/chau-dat-nung-trang.jpg', 1, '2025-04-22 20:16:07'),
(22, 8, 'Chậu đá mài trắng', 'chau-da-mai-trang', 15000.00, 13, 'Kích thước:  7x9 cm\r\nMàu sắc:       đỏ\r\nChất liệu:      Đá mài\r\nKiểu dáng:    Trụ tròn vát ', NULL, 'img_tree/chaucanh/chaudamaiximang/chau-da-mai-trang.jpg', 1, '2025-04-22 20:17:29'),
(23, 9, 'Chậu Composite trụ tròn nhỏ', 'chau-composite-tru-tron-nho', 15000.00, 11, 'Kich thước:  17x9 cm\r\nMàu sắc:     Trắng\r\nChất liệu:     Composite sơn bóng\r\nKiểu dáng:   Trụ tròn nhỏ', NULL, 'img_tree/chaucanh/chaucomposite/chau-composite-tru-tron-nho.jpg', 1, '2025-04-22 20:17:29'),
(24, 10, 'Chậu men sứ dáng thấp', 'chau-men-su-dang-thap', 15000.00, 3, '- Kích thước:  12x12\r\n- Màu sắc:      Xanh lam\r\n- Chất liệu:      Men sứ\r\n- Kiểu dáng:    Hình trụ tròn nhỏ', NULL, 'img_tree/chaucanh/chaumensu/chau-gom-su-dang-thap.jpg', 1, '2025-04-22 20:18:40'),
(25, 12, 'Đất trồng cây đa dụng', 'dat-trong-cay-da-dung', 45000.00, 2, NULL, NULL, 'img_tree/phukiencaycanh/dattrong/dat-trong-cay-da-dung.jpg', 1, '2025-04-22 20:18:40'),
(26, 13, 'Dụng cụ làm vườn mini', 'dung-cu-lam-vuon-mini', 15000.00, 8, 'Bộ dụng cụ làm vườn mini hỗ trợ việc chăm sóc cây cảnh được dễ dàng và hiệu quả hơn so với làm bằng tay.', NULL, 'img_tree/phukiencaycanh/dungculamvuon/dung-cu-lam-vuon-mini.jpg', 1, '2025-04-22 20:20:21'),
(27, 14, 'Sỏi trang trí', 'soi-trang-tri', 9000.00, 4, 'Sỏi Màu Trang Trí giúp làm đẹp bề mặt chậu, tạo vẻ thẩm mỹ cho chậu cây, sỏi có nhiều màu sắc có thể lựa chọn hợp với mệnh, tuổi, sở thích người trồng cây.', 'Nếu như sự kết hợp giữa chậu và cây đã tạo nên một vẻ đẹp tuyệt vời thì giờ đây với các viên sỏi trang trí nhiều màu sắc, lớn nhỏ khác nhau, sẽ làm vẻ đẹp ấy được nâng lên tầm cao mới.\r\n\r\nThông tin kỹ thuật\r\n\r\nKích thước mỗi viên sỏi: 1-1,5cm\r\nTrọng lượng: bịch 500gr\r\nMàu sắc: trắng, cam, vàng...\r\nCông dụng\r\n\r\nTrang trí bề mặt chậu, giúp tạo vẻ thẩm mỹ cho chậu cây\r\nKhi tưới nước không làm văng đất, phân bón ra ngoài, giữ vệ sinh xung quanh chậu cây\r\nCó nhiều màu sắc phù hợp với mệnh, tuổi, sở thích\r\nLưu ý\r\n\r\nSỏi sau một thời gian sử dụng sẽ bị úa màu, do nước, phân hoặc bụi bẩn bám vào, vì vậy nên thay sỏi sau khoảng 1-2 tuần, hoặc đem sỏi trong chậu ra chà rửa phơi khô rồi cho lại vào chậu\r\nKhông nên đặt sỏi quá dày, gây nặng chậu không cần thiết', 'img_tree/phukiencaycanh/trangtri/soi-mau-trang-tri.jpg', 1, '2025-04-22 20:20:21'),
(30, 14, 'Trang trí tiểu cảnh thỏ dễ thương, nhựa cây cảnh mini ', '', 10000.00, 7, 'Vật trang trí tiểu cảnh thỏ ngọc dễ thương\r\nLưu ý: Gía này là giá của nguyên set như trong ảnh', '', 'img_tree/1746211546_tieu-canh.jpg', 1, '2025-05-02 18:45:46'),
(41, 2, 'Cây Tuyết Tùng', 'cay-tuyet-tung', 200000.00, 9, 'Cây tuyết tùng (Cedrus) là cây lá kim thường xanh, họ Thông, từ vùng núi Himalaya và Địa Trung Hải. Thân cao, lá kim mềm, màu xanh đậm/xanh bạc, thơm nhẹ. Dùng trang trí, làm gỗ, bóng mát, mang ý nghĩa trường thọ, may mắn.', 'Giới thiệu\r\nTên gọi khác: Cây tuyết tùng Lebanon, tuyết tùng Himalaya.\r\nTên khoa học: Cedrus.\r\nTên tiếng Anh: Cedar.\r\nHọ: Pinaceae (họ Thông).\r\nXuất xứ: Vùng núi Himalaya, Lebanon, và khu vực Địa Trung Hải.\r\nĐặc điểm\r\nCây gỗ lớn, cao 30–60m, thân thẳng, vỏ xám nâu nứt mảng khi trưởng thành.\r\nLá kim mềm, mọc thành chùm 20–40 lá, dài 2–5cm, màu xanh đậm hoặc xanh bạc, tỏa mùi thơm nhẹ.\r\nTán lá hình chóp khi non, dạng ô rộng khi trưởng thành, rậm rạp.\r\nQuả nón hình trụ, dài 6–12cm, màu nâu nhạt, hạt có cánh phát tán nhờ gió.\r\nÝ nghĩa phong thủy\r\nTượng trưng cho sự trường thọ, bền vững, mang ý nghĩa về sức khỏe và mối quan hệ lâu dài.\r\nĐại diện cho tài lộc, may mắn, giúp gia chủ thêm vượng khí, bình an.\r\nPhù hợp với người mệnh Mộc, mang đến niềm tin, hy vọng và sự phát triển bền vững.\r\nCông dụng\r\nTrồng làm cây cảnh bonsai, cây bóng mát trong sân vườn, công viên, tạo không gian xanh mát.\r\nGỗ tuyết tùng bền, vân đẹp, dùng trong xây dựng, nội thất cao cấp, đóng tàu.\r\nTinh dầu tuyết tùng dùng trong mỹ phẩm, y học, giúp kháng khuẩn, thư giãn.\r\nThích hợp làm quà tặng dịp lễ Tết, tân gia, biểu tượng cho sự trường tồn.\r\nCách trồng và chăm sóc\r\n\r\n\r\n\r\n\r\n\r\nĐất trồng: Đất tơi xốp, thoát nước tốt. Hỗn hợp gồm: đất mùn + cát + đá perlite + phân hữu cơ.\r\nNước: Tưới vừa đủ, 1–2 lần/tuần tùy thời tiết, giữ đất ẩm nhẹ, tránh úng.\r\nÁnh sáng: Ưa sáng nhẹ, chịu được bóng râm, phơi nắng buổi sáng 2–3 lần/tuần, tránh nắng gắt.\r\nNhiệt độ: Thích hợp 15–25 độ C. Nhiệt độ quá thấp (&amp;lt;5 độ C) hoặc quá cao (&amp;gt;35 độ C) cây dễ héo.\r\nĐộ ẩm: Khoảng 60–70%, tránh không khí quá khô.\r\nTỉa cây: Cắt tỉa cành khô, lá hỏng định kỳ để cây thông thoáng, giảm sâu bệnh.\r\nBón phân: Bón 1–2 lần/tháng bằng phân hữu cơ hoại mục hoặc NPK, vùi cách gốc 10–15cm.', 'img_tree/1746380662_cay-tuyet-tung.jpg', 1, '2025-05-04 17:44:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tintuc`
--

CREATE TABLE `tintuc` (
  `MaTinTuc` int(11) NOT NULL,
  `TieuDe` varchar(255) NOT NULL,
  `DuongDan` varchar(255) NOT NULL,
  `MoTaNgan` text DEFAULT NULL,
  `NoiDung` text DEFAULT NULL,
  `HinhAnh` varchar(255) DEFAULT NULL,
  `NgayDang` timestamp NOT NULL DEFAULT current_timestamp(),
  `TrangThai` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tintuc`
--

INSERT INTO `tintuc` (`MaTinTuc`, `TieuDe`, `DuongDan`, `MoTaNgan`, `NoiDung`, `HinhAnh`, `NgayDang`, `TrangThai`) VALUES
(1, 'Cách chăm sóc cây cảnh để bàn', 'cach-cham-soc-cay-canh-de-ban', 'Hướng dẫn chi tiết cách chăm sóc cây cảnh để bàn giúp cây luôn xanh tốt.', 'Một ngày làm việc căng thẳng của bạn sẽ nhanh chóng tan biến khi có thêm những không gian xanh trong phòng làm việc. Những chậu hoa, chậu cây cảnh nhỏ xinh là một lựa chọn hợp lý. Tuy nhiên, việc chăm sóc loại cây trồng trong nhà này lại không dễ dàng như những gì bạn được hướng dẫn khi mua. Hãy tham khảo những mẹo nhỏ dưới đây để chăm sóc tốt cho chậu cây nhỏ của bạn mãi xanh tươi.\r\n\r\n1. Xử lý bộ rễ của cây hết sức thận trọng\r\n\r\nKhi cây cảnh nhỏ của bạn đang dần héo đi, không còn sức sống như lúc bạn mới mua về. Đó là khi cây cần thêm không gian hoặc cung cấp thêm dưỡng chất. Hãy bỏ cây ra khỏi chậu đang trồng và làm sạch rễ của chúng, thậm chí bạn nên đổi cây sang chậu mới. Hãy làm sạch rễ của cây một cách cẩn thận, làm chậm từng bước, không nên làm đứt dễ của cây. Lấy đất mới và trồng lại cây để cây hấp thụ đủ chất dinh dưỡng và tươi mới như khi vừa mua.\r\n\r\n2. Chỉ tưới cây bằng nước lọc\r\n\r\nHãy chỉ nên tưới cây bằng nước lọc bởi trong nước máy có chứa clo và các hóa chất khác không tốt cho cây. Các chuyên gia cũng cho biết, nước cất hoặc nước mưa cũng tốt cho cây, vì cả hai đều có tính axit nhẹ có thể loại bỏ tất cả các hóa chất và muối đã tích tụ trong đất do bạn đã sử dụng nước máy trước đó. Bạn cũng có thể đặt cây bên ngoài khi trời mưa hoặc trời ẩm, tuy nhiên đừng để quá lâu.\r\n\r\n3. Chuyển cây sang chậu hữu cơ\r\n\r\nBạn có thể thử di chuyển cây của vào chậu làm từ vỏ dừa. Đây không chỉ là chậu hữu cơ tốt nhất giúp thoát nước thừa khi bạn tưới cây giúp ngăn ngừa rễ bị thối mà nó sẽ cung cấp cho cây kẽm, đồng và sắt một cách tự nhiên\r\n\r\n4. Cắt tỉa những phần cây bị hỏng nhưng để lại khoảng 2cm\r\n\r\nHãy cắt, tỉa tất cả những phần bị hỏng trên cây, bao gồm cả lá vàng hoặc lá sắp hỏng. Tuy nhiên bạn nên cắt theo góc 45 độ và để chừa lại ít nhất 2 cm chứ đừng cắt cụt hẳn cành cây, nhánh cây.\r\n\r\n5. Ngâm cây và rễ cây trong nước khoảng nửa ngày\r\n\r\nSau một thời gian dài ở trong chậu và trong nhà, bạn bên bỏ cây ra khỏi đất và ngâm chúng vào nước để chúng được hồi sinh tự nhiên. Hãy đặt cây vào bồn tắm và rửa kỹ chúng dưới vòi hoa sen, chú ý đến cả hai mặt của lá. Bằng cách này, bạn sẽ rửa sạch mọi loại sâu bệnh còn sót lại trên lá và sẽ cho phép nước lấy đi các chất có hại đã tích tụ trong đất.', 'img_tree/cach-cham-soc-cay-canh-de-ban.jpg', '2025-04-22 02:00:00', 1),
(2, 'Top 4 loại cây phong thủy mang tài lộc', 'top-5-cay-phong-thuy', '4 loại cây phong thủy trong nhà vừa “hút” tài lộc, vừa mang đến lợi ích bất ngờ cho sức khỏe', 'Việc đặt cây xanh trong nhà có rất nhiều lợi ích. Đầu tiên, cây xanh, chậu hoa sẽ là nhân tố tạo điểm nhấn trong ngôi nhà “toàn bê tông, sắt thép”.\r\nMàu xanh cũng giúp căn nhà trở nên hài hòa, tươi mát hơn. Một số cây xanh trong nhà còn có thể làm sạch không khí và làm giảm độc tố, bức xạ của các thiết bị điện tử.\r\nĐặc biệt, theo chuyên gia phong thủy Nguyễn Sang (Hải Phòng) nếu biết cách bài trí, cây xanh còn là một yếu tố phong thủy đem lại may mắn, tài lộc cho gia chủ.\r\nDưới đây là những cây xanh bạn nên trồng trong nhà hoặc văn phòng.\r\n\r\nCây Trầu Bà\r\n\r\nCây trầu bà thuộc cây thân thảo, dạng leo, hình dáng mềm mại, có lá hình trái tim và giống cây trầu không. Đây là 1 trong 5 loại cây lọc khí hiệu quả, có khả năng hấp thụ chất độc từ khói thuốc, xăng xe, bức xạ điện tử…\r\nTrồng một cây trầu bà trong nhà, không chỉ giúp căn nhà có thêm những khoảng không gian thoáng đãng mà còn giúp thanh lọc môi trường xung quanh, tốt cho sức khỏe.\r\nTrong phong thủy, cây trầu bà còn là loại cây tượng trưng cho tài lộc, thịnh vượng và mang lại may mắn cho gia chủ. Là loại cây có hình dáng mềm mại, uyển chuyển nên trầu bà cũng thích hợp với những nhà quản lý, giám đốc doanh nghiệp… bởi nó tượng trưng cho sự không ngừng vươn lên trong sự nghiệp.\r\nBạn có thể đặt một chậu cây trầu bà trên bàn làm việc, tại ban công hay các góc nhà. Tuy nhiên, trầu bà sẽ độc nếu vô tình ăn phải. Do đó, không nên trồng hoặc đặt cây ở những nơi có trẻ em.\r\n\r\nCây Kim Tiền\r\n\r\nCây kim tiền là loài cây khóm (bụi) lá xanh mướt có sức sống mãnh liệt, dễ chăm sóc nên rất phù hợp để trồng trong nhà, văn phòng. Đây cũng là loài cây có tác dụng cung cấp oxy, thanh lọc không khí, phủ xanh không gian sống, giúp căn nhà trở nên thoáng đãng, chan hòa với thiên nhiên.\r\nTrong phong thủy, cây kim tiền còn được mệnh danh là “cây kim phát tài”. Thân cây vươn cao, lá xanh hướng lên trên ý nghĩa như bàn tay hứng lộc trời cho, tượng trưng cho sự cầu tiến, không ngừng vươn lên. Đặc biệt, cây kim tiền cũng mang ý nghĩa tốt đẹp về tiền bạc, tài lộc.\r\nBạn có thể đặt cây kim tiền trên bàn làm việc, tại các không gian đón ánh sáng trong căn nhà để cây sinh trưởng và phát triển tốt.\r\n\r\nCây Lưỡi Hổ\r\n\r\nĐây là loại cây có nguồn gốc từ vùng nhiệt đới, cây có thân dạng dẹt, mọng nước, trên thân thường có 2 màu xanh và màu vàng dọc từ gốc đến ngọn. Khi ra hoa, hoa lưỡi hổ thường nở thành từng cụm.\r\nTheo các nghiên cứu, cây lưỡi hổ rất tốt trong việc thanh lọc không khí, loại bỏ độc tố trong khí thải, bụi bẩn… Ngoài ra, cây cung cấp lượng oxy lớn ra môi trường nên rất tốt cho sức khỏe. Bạn có thể trồng lưỡi hổ trong chậu hoặc làm các giá treo trang trí.  \r\nVới hình dáng sắc nhọn như lưỡi kiếm, cây lưỡi hổ trong phong thủy có ý nghĩa tượng trưng cho khí phách người quân tử, có chí hướng vươn lên trong cuộc sống. Ngoài ra, dáng vẻ uy nghi từ thân đến ngọn của cây còn là biểu tượng của sự uy quyền, danh gia vọng tộc, phú quý.\r\nNgười Trung Hoa trồng loại cây này trong nhà như một cây quý giá có ý nghĩa phong thủy hưng thịnh, vì tám vị thần sẽ ban tặng 8 đức tính quý giá của họ cho người sở hữu cây lưỡi hổ: Thịnh vượng, sắc đẹp, sống lâu, thông minh, sức khỏe, nghệ thuật, sức mạnh và thơ ca.\r\n\r\nCây Lan Ý\r\n\r\nCây lan ý hay còn gọi là bạch môn, vỹ hoa trắng, cây thường mọc thành bụi. Đây là loại cây rất được trồng trong nhà bởi đặc tính lọc bẩn trong không khí rất tốt.\r\nNgoài ra, nó còn hấp thụ năng lượng bức xạ nhân tạo phát ra từ tivi, điện thoại, lò vi sóng, máy tính, đài, đồng hồ điện tử… Vì thế, lan ý thường đường nhiều người đặt ở bàn làm việc, quầy lễ tân, ban công, cửa sổ… để đem lại những lợi ích cho căn nhà.\r\nTrong phong thủy, lan ý là loài cây có ý nghĩa điều hoà và hấp thu những nguồn năng lượng xung khắc trong nhà, giúp gia chủ có một không gian sống hài hoà và yên bình.\r\nCây lan ý có thể sống tốt trong môi trường máy lạnh ở văn phòng, trong nhà kín dưới ánh sáng đèn quang. Tuy nhiên để cây sinh trưởng và phát triển tốt, bạn nên thường xuyên xoay chậu cây ra phía có ánh sáng mặt trời.\r\n\r\n\r\n', 'img_tree/top-5-cay-phong-thuy.jpg', '2025-04-22 03:00:00', 1),
(8, 'Loại cây được ví như thần dược cho sức khỏe, người Việt lại chỉ trồng làm cảnh', 'lo-i-c-y-c-v-nh-th-n-d-c-cho-s-c-kh-e-ng-i-vi-t-l-i-ch-tr-ng-l-m-c-nh', ' Nha đam từ lâu đã được biết đến như một loại cây thần kỳ với vô vàn lợi ích cho sức khỏe và sắc đẹp. Không chỉ là một loại cây cảnh dễ trồng, nha đam còn là một kho tàng các dưỡng chất quý giá, mang đến những tác dụng tuyệt vời mà bạn có thể chưa khám phá hết. ', ' Nha đam từ lâu đã được biết đến như một loại cây thần kỳ với vô vàn lợi ích cho sức khỏe và sắc đẹp. Không chỉ là một loại cây cảnh dễ trồng, nha đam còn là một kho tàng các dưỡng chất quý giá, mang đến những tác dụng tuyệt vời mà bạn có thể chưa khám phá hết. \r\n\r\nHỗ trợ hệ tiêu hóa khỏe mạnh\r\n\r\nCác enzyme tự nhiên trong nha đam như amylase và lipase giúp phân hủy carbohydrate và chất béo, hỗ trợ quá trình tiêu hóa diễn ra trơn tru hơn. Nha đam còn có khả năng làm dịu niêm mạc dạ dày, giảm các triệu chứng khó tiêu, đầy hơi và ợ nóng. Một số nghiên cứu cũng cho thấy nha đam có thể giúp cải thiện tình trạng viêm loét dạ dày và hội chứng ruột kích thích (IBS).\r\n\r\nTăng cường hệ miễn dịch tự nhiên\r\n\r\nNha đam chứa các polysaccharide, một loại carbohydrate phức tạp có khả năng kích thích hệ thống miễn dịch của cơ thể. Các hợp chất này giúp tăng cường hoạt động của các tế bào miễn dịch, giúp cơ thể chống lại các tác nhân gây bệnh như vi khuẩn, virus và nấm. Việc bổ sung nha đam vào chế độ ăn uống có thể giúp bạn có một hệ miễn dịch khỏe mạnh hơn, ít bị ốm vặt.\r\n\r\nHỗ trợ kiểm soát lượng đường trong máu\r\n\r\nMột số nghiên cứu ban đầu cho thấy nha đam có thể có tác động tích cực đến việc kiểm soát lượng đường trong máu ở những người mắc bệnh tiểu đường type 2. Các hợp chất trong nha đam có thể giúp cải thiện độ nhạy insulin và giảm lượng đường huyết. Tuy nhiên, người bệnh tiểu đường nên tham khảo ý kiến bác sĩ trước khi sử dụng nha đam như một liệu pháp hỗ trợ điều trị và không nên thay thế các phương pháp điều trị chính bằng nha đam.\r\n\r\nKháng viêm và giảm đau tự nhiên\r\n\r\nNha đam chứa các hợp chất có khả năng kháng viêm mạnh mẽ, giúp giảm sưng, đau và viêm trong cơ thể. Việc bôi gel nha đam lên các vùng da bị viêm hoặc sử dụng các sản phẩm từ nha đam có thể giúp giảm đau nhức cơ bắp, khớp và các vết thương nhỏ.\r\n\r\nCung cấp vitamin và khoáng chất thiết yếu\r\n\r\nNha đam là một nguồn cung cấp vitamin và khoáng chất đa dạng, bao gồm vitamin A, C, E, các vitamin nhóm B (B1, B2, B3, B6), canxi, magie, kẽm và sắt. Những dưỡng chất này đóng vai trò quan trọng trong nhiều chức năng của cơ thể, từ việc duy trì hệ thần kinh khỏe mạnh đến việc hỗ trợ quá trình trao đổi chất và sản xuất năng lượng.\r\n\r\nHỗ trợ sức khỏe răng miệng\r\n\r\nMột số nghiên cứu cho thấy gel nha đam có thể có lợi cho sức khỏe răng miệng. Khả năng kháng khuẩn và kháng viêm của nha đam có thể giúp giảm viêm nướu, ngăn ngừa sự phát triển của vi khuẩn gây sâu răng và hôi miệng.\r\n\r\nGiải độc cơ thể\r\n\r\nNha đam chứa các chất chống oxy hóa giúp bảo vệ tế bào khỏi tổn thương do các gốc tự do gây ra. Ngoài ra, nha đam còn có tác dụng lợi tiểu nhẹ, giúp cơ thể đào thải độc tố và chất thải ra ngoài hiệu quả hơn.\r\n\r\nHỗ trợ giảm cân\r\n\r\nMặc dù không phải là một thần dược giảm cân trực tiếp, nhưng nha đam có thể hỗ trợ quá trình giảm cân nhờ hàm lượng calo thấp và khả năng thúc đẩy quá trình trao đổi chất. Chất xơ trong nha đam cũng giúp tạo cảm giác no lâu, giảm cảm giác thèm ăn.\r\n\r\nCứu tinh cho làn da mịn màng và tươi trẻ\r\n\r\nNha đam nổi tiếng với khả năng làm dịu và phục hồi da tuyệt vời. Gel nha đam chứa nhiều vitamin (A, C, E, B12), khoáng chất, enzyme và axit amin, giúp dưỡng ẩm sâu, làm mềm da, giảm kích ứng, mẩn đỏ và cháy nắng. Đặc biệt, các hợp chất như anthraquinones trong nha đam còn có khả năng kháng khuẩn, kháng viêm, hỗ trợ điều trị mụn trứng cá và các vấn đề da liễu khác, mang lại làn da mịn màng, tươi sáng và khỏe mạnh.\r\n\r\nLiều thuốc tự nhiên cho mái tóc bóng mượt\r\n\r\nKhông chỉ tốt cho da, nha đam còn là một &amp;amp;amp;amp;amp;amp;quot;bí quyết&amp;amp;amp;amp;amp;amp;quot; cho mái tóc chắc khỏe và bóng mượt. Gel nha đam giúp cân bằng độ pH của da đầu, làm sạch dầu thừa và bụi bẩn, kích thích mọc tóc, giảm gãy rụng và chẻ ngọn. Các vitamin và khoáng chất trong nha đam còn cung cấp dưỡng chất cần thiết cho tóc, giúp tóc trở nên mềm mại, óng ả và khỏe mạnh hơn.\r\n\r\n', 'img_tree/1746210981_1746210105_cay-nha-dam 2.jpg', '2025-05-02 18:30:00', 1),
(9, '5 loại cây quen thuộc không tốn công chăm sóc vừa đẹp nhà vừa tốt phong thuỷ', '5-lo-i-c-y-quen-thu-c-kh-ng-t-n-c-ng-ch-m-s-c-v-a-p-nh-v-a-t-t-phong-thu', 'Có nhiều loại cây không chỉ tốt cho phong thuỷ, tôn thêm vẻ đẹp cho căn nhà mà còn không tốn nhiều thời gian chăm và tưới nước.', 'Có nhiều loại cây không chỉ tốt cho phong thuỷ, tôn thêm vẻ đẹp cho căn nhà mà còn không tốn nhiều thời gian chăm và tưới nước.\r\nCây ngọc bích\r\n\r\nĐây là loại cây có thân nhỏ, lá tròn và dẹt như đồng xu, chúng được trồng làm cảnh, thích hợp trồng trong các căn nhà hoặc văn phòng, nơi có nhiều bóng râm, ít ánh sáng mặt trời.\r\n\r\nCây ngọc bích có lá xanh tốt quanh năm, ra hoa vào mùa xuân hoặc cuối đông. Trong phong thủy, người ta quan niệm, cành lá ngọc bích tượng trưng cho sự giàu có, tiền bạc, phúc lộc. Cây này càng ra lá nhiều sẽ được quan niệm thịnh vượng càng đến với chủ nhà.\r\nƯu điểm của loại cây này là không cần chăm sóc nhiều do khả năng chịu hạn tốt. Bạn có thể chỉ cần tưới nước 2-3 ngày/lần mà cây ngọc bích vẫn tươi xanh. Tuy nhiên, thỉnh thoảng gia chủ nên đưa cây ngọc bích ra tiếp xúc với ánh nắng nhẹ, nhất là buổi sáng.\r\n\r\nXương rồng\r\n\r\nKhi nhắc đến các cây chịu hạn tốt, không thể không nhắc đến xương rồng. Xương rồng là cây được đặt trong nhà, trên bàn làm việc hoặc ở ban công.\r\nTừ xa xưa, cây xương rồng xuất phát nơi sống là vùng sa mạc, đất khô cằn như hoang mạc. Cho nên, sức chịu đựng với thời tiết nắng nóng, ít nước của cây xương rồng rất lớn. Ngoài sức sống mãnh liệt, cây xương rồng có thể tồn tại lên đến 30 năm.\r\n\r\nKhi trồng xương rồng, gia chủ không cần quá chăm chỉ. Bởi, nếu bạn tưới nước quá nhiều, cây xương rồng bị úng ngập có thể bị chết. Cho nên, bạn chỉ cần tưới một lượng vừa phải. Cây xương rồng cần tưới nước khoảng một lần trong tuần và có thể sống tốt trong một tháng không tưới nước.\r\n\r\nCây lưỡi hổ\r\n\r\nCây lưỡi hổ được dùng đặt làm cây trang trí trong nhà vì lá có nhiều hoa văn đẹp. Cây mọc thành bụi thấp, cứng cáp và dễ phát triển ở mọi điều kiện trong nhà.\r\nTương tự như xương rồng, cây lưỡi hổ cũng xuất phát từ vùng khô hạn nên khả năng chịu hạn tốt. Do đó, khi trồng cây lưỡi hổ sẽ không cần tưới nước thường xuyên.\r\n\r\nTuy nhiên, đây là loại cây ưa ánh sáng do đó chúng cần ánh sáng quanh năm. Vào những ngày mùa hè, cây lưỡi hổ sinh trưởng tốt nhưng vào mùa đông chúng sinh trưởng chậm lại.\r\n\r\nCây nha đam\r\n\r\nĐây là loại cây được nhiều người thích trồng trong phòng. Cây nha đam có thể dùng trong y học giúp chữa nhiều bệnh, bên cạnh đó nó còn mang đến vẻ đẹp xanh tươi, giàu sức sống.\r\nChúng thích hợp cho những người không có nhiều thời gian rảnh để chăm sóc cây cối thường xuyên. Đây là loại cây dễ trồng và phát triển nhanh. Sở dĩ chúng không cần chăm sóc nhiều vì khả năng chịu hạn tốt.\r\n\r\nTrong mùa khô, không có nước, cây vẫn sống bình thường, đến mùa mưa với độ ẩm thích hợp cây sẽ phát triển tốt. Sau khi trồng 6 tháng, cây nha đam có thể cho thu hoạch.\r\n\r\nCây đa cẩm thạch\r\n\r\nCây đa cẩm thạch có lá với màu sắc đẹp, ưa ánh nắng. Tuy nhiên, cây không cần nhiều nước và phát triển tốt ở nhiệt độ 16-27 độ C. Điều đặc biệt là cây đa cẩm thạch có thể giúp hút độc tố trong không khí, thanh lọc đưa lại môi trường sống trong lành cho căn nhà hay văn phòng.\r\n\r\nTheo quan niệm trong phong thủy, cây đa cẩm thạch mang đến sự bình an, hòa thuận. Ngoài ra, loại cây này còn tượng trưng cho sự trường tồn, vĩnh cửu.', 'img_tree/1746211224_ngoc-bich.jpg', '2025-05-02 18:40:24', 1),
(10, 'Sen đá viền hồng: Đặc điểm, công dụng, ý nghĩa, cách trồng và chăm sóc cây', 'sen-vi-n-h-ng-c-i-m-c-ng-d-ng-ngh-a-c-ch-tr-ng-v-ch-m-s-c-c-y', 'Giữa thế giới muôn loài cây cảnh, sen đá viền hồng nổi bật bởi sắc màu viền lá độc đáo và được yêu thích bởi sức sống mãnh liệt. Không cần đến sự chăm sóc quá cầu kỳ, loài cây này vẫn có thể phát triển mạnh mẽ và tỏa sáng trong không gian sống. Bài viết sau, Vườn Cây Việt sẽ chia sẻ đến bạn những thông tin về sen đá viền hồng như đặc điểm, công dụng, cách trồng và chăm sóc để bạn có thể dễ dàng sở hữu một chậu cây xinh xắn.', 'Sen đá viền hồng: Đặc điểm, công dụng, ý nghĩa, cách trồng và chăm sóc cây\r\n\r\nGiữa thế giới muôn loài cây cảnh, sen đá viền hồng nổi bật bởi sắc màu viền lá độc đáo và được yêu thích bởi sức sống mãnh liệt. Không cần đến sự chăm sóc quá cầu kỳ, loài cây này vẫn có thể phát triển mạnh mẽ và tỏa sáng trong không gian sống. Bài viết sau, Vườn Cây Việt sẽ chia sẻ đến bạn những thông tin về sen đá viền hồng như đặc điểm, công dụng, cách trồng và chăm sóc để bạn có thể dễ dàng sở hữu một chậu cây xinh xắn.\r\n\r\nTên gọi, nguồn gốc, đặc điểm của sen đá viền hồng như thế nào?\r\nLoài cây này có tên khoa học là Echeveria &quot;Perle von Nurnberg&quot;. Chúng có nguồn gốc từ khu vực bán hoang mạc và vùng núi thấp của Mexico và Trung Mỹ. Những điều kiện khí hậu khô ráo và ánh sáng mạnh ở đây đã tạo nên đặc tính chịu hạn đặc trưng của chúng.\r\nĐặc điểm của sen đá viền hồng:\r\n\r\nHình dáng và màu sắc của sen đá viền hồng\r\nCây có những chiếc lá dày, mọng nước và cạnh cứng cáp.\r\nLá cây có màu xanh lá cây ở phần cơ bản và có viền hồng ở phần mép lá.\r\nCây có kích thước từ nhỏ đến trung bình, thích hợp để trồng trong chậu hoặc làm cây cảnh nội thất.\r\nCông dụng của sen đá viền hồng là gì?Trang trí không gian sống và làm việc\r\nViền hồng nhẹ nhàng quanh mép lá xanh tạo nên sự cân bằng giữa màu sắc, vừa dịu dàng vừa nổi bật. Dùng loài cây này để trang trí sẽ giúp không gian trở nên sinh động và tươi mới. Chúng phù hợp để đặt ở các vị trí như bàn làm việc, kệ sách, cửa sổ, và ban công. Cây có thể kết hợp với các loại chậu khác nhau, từ chậu gốm, sứ đến chậu đất nung, để tạo nên phong cách trang trí đa dạng và ấn tượng.\r\n\r\nTăng cường chất lượng không khí\r\nLoài cây này có khả năng hấp thụ các khí độc trong không khí như formaldehyde, toluene và benzene. Việc đặt một chậu cây trong nhà giúp thanh lọc không khí, mang lại môi trường sống lành mạnh hơn. Ngoài ra, chúng có khả năng nhả oxy vào ban đêm, do đó bạn có thể đặt một chậu cây trong phòng ngủ để giúp cải thiện giấc ngủ, làm cho không khí trong phòng trở nên trong lành, thoáng đãng hơn.\r\n\r\nGiảm căng thẳng, mang đến sự thư thái\r\nTheo nghiên cứu, màu xanh lá và màu hồng có tác động tích cực đến tinh thần, giúp giảm căng thẳng và lo lắng. Việc quan sát chậu cây này mỗi ngày giúp bạn thư giãn và tạo cảm giác dễ chịu, nhẹ nhàng hơn. Điều này rất hữu ích trong những không gian làm việc căng thẳng hay môi trường sống bận rộn.\r\n\r\nTăng khả năng tập trung, hiệu suất công việc\r\nCây xanh không chỉ là một vật trang trí, mà còn đóng vai trò như một “liệu pháp xanh” giúp tâm trí tỉnh táo, tránh mệt mỏi. Vì vậy, ngắm nhìn chậu cây sen đá này sẽ giúp cải thiện khả năng tập trung và tăng hiệu suất công việc.\r\n\r\nSen đá viền hồng mang lại những ý nghĩa gì?Thể hiện tình yêu chân thành và bền chặt\r\nLoài cây này có sức sống mạnh mẽ, chịu đựng tốt trong các điều kiện khắc nghiệt. Vì vậy, chúng được xem như một biểu tượng của tình yêu vững bền, lòng chung thủy. Những chiếc lá có viền hồng nhẹ nhàng tượng trưng cho tình cảm dịu dàng và lãng mạn, thích hợp làm quà tặng cho người thương hoặc bạn đời.\r\n\r\nThể hiện tình bạn vĩnh cửu\r\nKhông chỉ tượng trưng cho tình yêu đôi lứa, loài cây này còn mang ý nghĩa về một tình bạn dài lâu và đáng trân trọng. Mỗi chiếc lá xanh với viền hồng nhẹ nhàng thể hiện sự gắn kết và chia sẻ, khuyến khích mối quan hệ bền lâu giữa những người bạn tốt.\r\n\r\nMang may mắn và tài lộc\r\nTrong phong thủy, loài cây này gắn liền với sự thịnh vượng và may mắn. Chúng còn kích hoạt vượng khí và tài lộc. Bạn nên đặt cây ở phía Đông hoặc Đông Nam của ngôi nhà hoặc văn phòng để phát huy tối đa hiệu quả phong thủy.\r\n\r\nBiểu tượng của sự kiên cường\r\nLoài cây này phát triển tốt ngay cả trong môi trường khô hạn và điều kiện thời tiết khắc nghiệt, nhờ khả năng trữ nước trong lá. Đây là biểu tượng của tinh thần độc lập, kiên trì vượt qua thử thách. Trong cuộc sống hiện đại, chúng nhắc nhở chúng ta về sự kiên nhẫn và ý chí mạnh mẽ, không dễ bị khuất phục trước khó khăn.\r\n\r\nTạo sự cân bằng âm dương\r\nMàu xanh lá cây của thân và lá cùng màu hồng viền ngoài tượng trưng cho sự cân bằng âm dương. Theo phong thủy, sự cân bằng này có thể giúp điều hòa năng lượng trong nhà, mang lại sự an yên và hòa thuận cho gia đình.\r\nCách trồng sen đá viền hồng như thế nào để cây phát triển tốt?Chuẩn bị\r\nChậu trồng: Nên chọn chậu có lỗ thoát nước ở đáy để tránh ngập úng, giúp rễ cây thông thoáng và phát triển tốt. Chất liệu chậu có thể là gốm, đất nung, hoặc nhựa tùy ý, nhưng chậu đất nung và gốm sẽ giúp thoát nước tốt hơn.\r\nĐất trồng: Nên chọn đất tơi xốp, thoát nước nhanh. Có thể trộn đất theo tỉ lệ sau: 2 phần đất trồng cây cảnh, 1 phần cát hoặc xỉ than đã đập vụn, và 1 phần phân hữu cơ hoặc phân vi sinh để cung cấp dưỡng chất. Thêm một ít than hoạt tính vào hỗn hợp đất để ngăn ngừa nấm mốc và sâu bệnh.\r\nCây giống khỏe mạnh: Chọn cây giống có lá căng mọng, không bị sâu bệnh hay có dấu hiệu héo úa.\r\nCác bước trồng cây\r\nBước 1: Lấy lượng đất đã chuẩn bị, đổ vào chậu sao cho cách miệng chậu khoảng 2-3 cm. Sau đó tạo một lỗ ở chính giữa chậu.\r\nBước 2: Đặt cây giống vào giữa chậu, cố định nhẹ nhàng để cây không bị nghiêng.\r\nBước 3: Thêm một lớp đất nữa để đảm bảo rễ được bao phủ hoàn toàn, không để rễ lộ ra ngoài.\r\nBước 4: Tưới nước làm ẩm đất và đặt chậu cây ở nơi có ánh sáng nhẹ để cây phát triển.\r\nLưu ý, khi mua cây về bạn nên đặt cây ở nơi thoáng mát 1-2 ngày để cây thích nghi với môi trường sống rồi mới đem đi trồng.\r\n\r\n', 'img_tree/1746436641_cay-sen-da-lola.jpg', '2025-05-05 09:17:21', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `trangthaidonhang`
--

CREATE TABLE `trangthaidonhang` (
  `MaTrangThai` int(11) NOT NULL,
  `TenTrangThai` varchar(50) NOT NULL,
  `MoTa` text DEFAULT NULL,
  `TrangThai` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `trangthaidonhang`
--

INSERT INTO `trangthaidonhang` (`MaTrangThai`, `TenTrangThai`, `MoTa`, `TrangThai`) VALUES
(1, 'Chờ xác nhận', 'Đơn hàng vừa được đặt, đang chờ người bán xác nhận', 1),
(2, 'Đang xử lý', 'Đơn hàng đã được xác nhận, đang được chuẩn bị', 1),
(3, 'Đang giao hàng', 'Đơn hàng đang được giao ', 1),
(4, 'Hoàn thành', 'Đơn hàng đã giao thành công và hoàn tất', 1),
(5, 'Hủy', 'Đơn hàng đã bị hủy', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `idUser` int(11) NOT NULL,
  `HoTen` varchar(100) NOT NULL,
  `TenDangNhap` varchar(50) NOT NULL,
  `MatKhau` varchar(255) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `SoDienThoai` varchar(15) NOT NULL,
  `DiaChi` text NOT NULL,
  `VaiTro` enum('admin','khachhang') DEFAULT 'khachhang',
  `TrangThai` tinyint(1) DEFAULT 1,
  `NgayTao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`idUser`, `HoTen`, `TenDangNhap`, `MatKhau`, `Email`, `SoDienThoai`, `DiaChi`, `VaiTro`, `TrangThai`, `NgayTao`) VALUES
(1, 'Nhóm 9', 'Nhom9', 'nhom9@2025', 'admin@cuahang.com', '0343294824', '', 'admin', 1, '2025-04-22 19:34:58'),
(2, 'Nguyễn Thanh An', 'thanhan12', 'thanhan@123', 'thanhan123@gmail.com', '0909123456', '70 Tô Ký,Quận 12', 'khachhang', 1, '2025-04-22 19:36:26'),
(3, 'Lê Bảo Anh', 'baoanh34', 'Baoanh34@2025', 'baoanh34@gmail.com', '0395761254', 'Quận 7, TPHCM', 'khachhang', 1, '2025-04-22 20:38:07'),
(9, 'Nguyễn Văn Tèo', 'teonv', 'teonv@123', 'teo123@gmail.com', '0321456789', 'Tp,HCM', 'khachhang', 1, '2025-04-27 04:21:19'),
(10, 'Nguyễn Văn T', 'tnv', 'tnv123@', 'tnv123@gmail.com', '023145678', 'Tp,HCM', 'khachhang', 1, '2025-04-27 05:51:20'),
(13, 'Nguyễn Thanh Vân', 'thanhvan', 'thanhvan@234', 'thanhvan@gmail.com', '0341235665', '70 Tô ký,Quận 12', 'khachhang', 1, '2025-05-02 18:06:07'),
(14, 'Lê Văn Tám', 'letam@123', 'letam123@', 'letam123@gmail.com', '0942315678', '134/2 Tân Chánh Hiệp, Quận 12', 'khachhang', 1, '2025-05-05 07:44:51'),
(15, 'Nguyễn Văn A', 'NguyenA', 'nguyen@123', 'nguyena@gmail.com', '0341235678', '123/45 Phan Văn Trị, Q Gò Vấp', 'khachhang', 1, '2025-05-05 08:33:19'),
(16, 'Lê Văn Dậu', 'ledau123', 'ledau123@', 'levandau@gmail.com', '03425612378', '123/45 Phan Văn Trị, Q Gò Vấp', 'khachhang', 1, '2025-05-05 08:40:40'),
(17, 'Bùi Đức Long', 'duclong12', 'duclong12@', 'buiduclong@gmail.com', '0341235678', '123/45 Phan Văn Trị, Q Gò Vấp', 'khachhang', 1, '2025-05-05 09:01:23');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  ADD PRIMARY KEY (`MaChiTiet`),
  ADD KEY `MaDonHang` (`MaDonHang`),
  ADD KEY `MaSanPham` (`MaSanPham`);

--
-- Chỉ mục cho bảng `danhmuc`
--
ALTER TABLE `danhmuc`
  ADD PRIMARY KEY (`MaDanhMuc`),
  ADD KEY `MaDanhMucCha` (`MaDanhMucCha`);

--
-- Chỉ mục cho bảng `donhang`
--
ALTER TABLE `donhang`
  ADD PRIMARY KEY (`MaDonHang`),
  ADD KEY `idUser` (`idUser`),
  ADD KEY `MaTrangThai` (`MaTrangThai`);

--
-- Chỉ mục cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD PRIMARY KEY (`MaGioHang`),
  ADD KEY `idUser` (`idUser`),
  ADD KEY `MaSanPham` (`MaSanPham`);

--
-- Chỉ mục cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`MaSanPham`),
  ADD UNIQUE KEY `DuongDan` (`DuongDan`),
  ADD KEY `MaDanhMuc` (`MaDanhMuc`);

--
-- Chỉ mục cho bảng `tintuc`
--
ALTER TABLE `tintuc`
  ADD PRIMARY KEY (`MaTinTuc`),
  ADD UNIQUE KEY `DuongDan` (`DuongDan`);

--
-- Chỉ mục cho bảng `trangthaidonhang`
--
ALTER TABLE `trangthaidonhang`
  ADD PRIMARY KEY (`MaTrangThai`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`idUser`),
  ADD UNIQUE KEY `TenDangNhap` (`TenDangNhap`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  MODIFY `MaChiTiet` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT cho bảng `danhmuc`
--
ALTER TABLE `danhmuc`
  MODIFY `MaDanhMuc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `donhang`
--
ALTER TABLE `donhang`
  MODIFY `MaDonHang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT cho bảng `giohang`
--
ALTER TABLE `giohang`
  MODIFY `MaGioHang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  MODIFY `MaSanPham` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT cho bảng `tintuc`
--
ALTER TABLE `tintuc`
  MODIFY `MaTinTuc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `trangthaidonhang`
--
ALTER TABLE `trangthaidonhang`
  MODIFY `MaTrangThai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `idUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  ADD CONSTRAINT `chitietdonhang_ibfk_1` FOREIGN KEY (`MaDonHang`) REFERENCES `donhang` (`MaDonHang`) ON DELETE CASCADE,
  ADD CONSTRAINT `chitietdonhang_ibfk_2` FOREIGN KEY (`MaSanPham`) REFERENCES `sanpham` (`MaSanPham`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `danhmuc`
--
ALTER TABLE `danhmuc`
  ADD CONSTRAINT `danhmuc_ibfk_1` FOREIGN KEY (`MaDanhMucCha`) REFERENCES `danhmuc` (`MaDanhMuc`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `donhang`
--
ALTER TABLE `donhang`
  ADD CONSTRAINT `donhang_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE SET NULL,
  ADD CONSTRAINT `donhang_ibfk_2` FOREIGN KEY (`MaTrangThai`) REFERENCES `trangthaidonhang` (`MaTrangThai`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD CONSTRAINT `giohang_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE CASCADE,
  ADD CONSTRAINT `giohang_ibfk_2` FOREIGN KEY (`MaSanPham`) REFERENCES `sanpham` (`MaSanPham`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD CONSTRAINT `sanpham_ibfk_1` FOREIGN KEY (`MaDanhMuc`) REFERENCES `danhmuc` (`MaDanhMuc`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
