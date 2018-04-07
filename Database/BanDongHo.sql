DROP DATABASE BANDONGHO
CREATE DATABASE BANDONGHO
GO
USE BANDONGHO
GO

---Tạo bảng sản phẩm
CREATE TABLE SANPHAM 
(
	MASP CHAR(7) NOT NULL PRIMARY KEY,
	TENSP NVARCHAR(50),
	HINHLON CHAR(50), 
	HINHNHO CHAR(50),
	MOTA NTEXT,
	MATH CHAR(7),
	DANHGIA NTEXT,
	SOLUONG INT,
	MALOAISP NVARCHAR(50),
	DONGIA FLOAT
)

---Tạo bảng loại sản phẩm
CREATE TABLE LOAISANPHAM 
(
	MALOAISP CHAR(7) NOT NULL PRIMARY KEY,
	TENLOAISP NVARCHAR(50),
)


---Tạo bảng thương hiệu
CREATE TABLE THUONGHIEU 
(
	MATH CHAR(7) NOT NULL PRIMARY KEY,
	TENTH NVARCHAR(50),
	HINHTH CHAR(50)
)

---Tạo bảng đơn đặt hàng
CREATE TABLE DONHANG
(
	MADH CHAR(7) NOT NULL PRIMARY KEY,
	MAKH CHAR(7),
	TRANGTHAI NVARCHAR(20),
	DIACHIGIAO NTEXT,
	SDT VARCHAR(12),
	NGAYDAT DATETIME NOT NULL,
	NGAYGIAO DATETIME,
	MOTA NTEXT,
	TONGTIEN FLOAT
)

------Tạo bảng chi tiết đơn đặt hàng
CREATE TABLE CHITIETDONHANG 
(
	MADH CHAR(7) NOT NULL,
	MASP CHAR(7) NOT NULL,
	SOLUONG INT,
	PRIMARY KEY(MADH, MASP)
)

---Tạo bảng khuyến mãi
CREATE TABLE KHUYENMAI
(
	MAKM CHAR(7) NOT NULL PRIMARY KEY,
	TENKM NVARCHAR(50)
)

---Tạo bảng chi tiết khuyến mãi
CREATE TABLE CHITIETKM
(
	MACTKM CHAR(7) NOT NULL PRIMARY KEY,
	MAKM CHAR(7),
	MASP CHAR(7),
	NGAYBATDAUKM DATETIME,
	NGAYKETTHUCKM DATETIME,
	PHANTRAMKM INT
)

---Tạo bảng khách hàng
CREATE TABLE KHACHHANG
(
	MAKH CHAR(7) NOT NULL PRIMARY KEY,
	MATK CHAR(7),
	HOTEN NVARCHAR(50),
	EMAIL VARCHAR(50),
	SDT VARCHAR(12),
	GIOITINH NVARCHAR(3),
	DIACHI NTEXT,
	NGAYSINH DATETIME,	
)

---Tạo bảng tài khoản
CREATE TABLE TAIKHOAN
(
	MATK CHAR(7) NOT NULL PRIMARY KEY,
	TENDN VARCHAR(20),
	MATKHAU VARCHAR(32),
	MALOAITK CHAR(7)
)

---Tạo bảng loại tài khoản
CREATE TABLE LOAITK
(
	MALOAITK CHAR(7) NOT NULL PRIMARY KEY,
	TENLOAITK NVARCHAR(20)
)

---Tạo bảng bình luận
--CREATE TABLE BINHLUAN
--(
--	MABL CHAR(7) NOT NULL PRIMARY KEY,
--	MATK CHAR(7),
--	MASP CHAR(7),
--	NOIDUNG NTEXT,
--	NGAYBINHLUAN DATETIME 
--)

-----Tạo bảng đánh giá
--CREATE TABLE DANHGIA
--(
--	MADG CHAR(7) NOT NULL PRIMARY KEY,
--	MASP CHAR(7),
--	MATK CHAR(7),
--	NOIDUNG NTEXT,
--	SOSAO VARCHAR(1) 
--)



---Tạo khóa ngoại cho bảng  chi tiết sản phẩm
--ALTER TABLE CHITIETSANPHAM ADD CONSTRAINT FK_CTSP_LSP FOREIGN KEY(MALOAISP) REFERENCES LOAISANPHAM(MALOAISP)
--ALTER TABLE CHITIETSANPHAM ADD CONSTRAINT FK_CTSP_MAU FOREIGN KEY(MAMAU) REFERENCES MAUSAC(MAMAU)
--ALTER TABLE CHITIETSANPHAM ADD CONSTRAINT FK_CTSP_SIZE FOREIGN KEY(MASIZE) REFERENCES SIZE(MASIZE)
--ALTER TABLE CHITIETSANPHAM ADD CONSTRAINT FK_CTSP_SP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)


---Tạo khóa ngoại cho bảng sản phẩm
ALTER TABLE SANPHAM ADD CONSTRAINT FK_SP_TH FOREIGN KEY(MATH) REFERENCES THUONGHIEU(MATH)
ALTER TABLE SANPHAM ADD CONSTRAINT FK_SP_LSP FOREIGN KEY(MALOAISP) REFERENCES LOAISANPHAM(MALOAISP)

---Tạo khóa ngoại cho bảng đơn hàng
ALTER TABLE DONHANG ADD CONSTRAINT FK_DH_KH FOREIGN KEY(MAKH) REFERENCES KHACHHANG(MAKH)

---Tạo khóa ngoại cho bảng chi tiết đơn hàng
ALTER TABLE CHITIETDONHANG ADD CONSTRAINT FK_CTDH_DH FOREIGN KEY(MADH) REFERENCES DONHANG(MADH)
ALTER TABLE CHITIETDONHANG ADD CONSTRAINT FK_CTDH_SP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)

---Tạo khóa ngoại cho bảng chi tiết khuyến mãi
ALTER TABLE CHITIETKM ADD CONSTRAINT FK_CTKM_KM FOREIGN KEY(MAKM) REFERENCES KHUYENMAI(MAKM)
ALTER TABLE CHITIETKM ADD CONSTRAINT FK_CTKM_SP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)

---Tạo khóa ngoại cho bảng khách hàng
ALTER TABLE KHACHHANG ADD CONSTRAINT FK_KH_TK FOREIGN KEY(MATK) REFERENCES TAIKHOAN(MATK)

---Tạo khóa ngoại cho bảng tài khoản
ALTER TABLE TAIKHOAN ADD CONSTRAINT FK_TK_LTK FOREIGN KEY(MALOAITK) REFERENCES LOAITK(MALOAITK)

---Tạo khóa ngoại cho bảng bình luận
--ALTER TABLE BINHLUAN ADD CONSTRAINT FK_BL_TK FOREIGN KEY(MATK) REFERENCES TAIKHOAN(MATK)
--ALTER TABLE BINHLUAN ADD CONSTRAINT FK_BL_SP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)

-----Tạo khóa ngoại cho bảng đánh giá
--ALTER TABLE DANHGIA ADD CONSTRAINT FK_DG_SP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)
--ALTER TABLE DANHGIA ADD CONSTRAINT FK_DG_TK FOREIGN KEY(MATK) REFERENCES TAIKHOAN(MATK)