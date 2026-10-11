CREATE DATABASE QuanLyBanHang;
GO

USE QuanLyBanHang;
GO

CREATE TABLE KhachHang (
    MaKH CHAR(5) PRIMARY KEY,
    HoTen NVARCHAR(50) NOT NULL,
    DiaChi NVARCHAR(100),
    DienThoai VARCHAR(15)
);

CREATE TABLE NhanVien (
    MaNV CHAR(5) PRIMARY KEY,
    HoTen NVARCHAR(50) NOT NULL,
    GioiTinh NVARCHAR(5),
    NgaySinh DATE,
    DienThoai VARCHAR(15)
);

CREATE TABLE LoaiSanPham (
    MaLoai CHAR(5) PRIMARY KEY,
    TenLoai NVARCHAR(50) NOT NULL
);

CREATE TABLE SanPham (
    MaSP CHAR(5) PRIMARY KEY,
    TenSP NVARCHAR(100) NOT NULL,
    MaLoai CHAR(5),
    GiaBan DECIMAL(18, 2),
    SoLuongTon INT,
    FOREIGN KEY (MaLoai) REFERENCES LoaiSanPham(MaLoai)
);

CREATE TABLE HoaDon (
    MaHD CHAR(5) PRIMARY KEY,
    MaKH CHAR(5),
    MaNV CHAR(5),
    NgayLapHD DATE,
    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

CREATE TABLE ChiTietHoaDon (
    MaHD CHAR(5),
    MaSP CHAR(5),
    SoLuongMua INT,
    DonGiaMua DECIMAL(18, 2),
    PRIMARY KEY (MaHD, MaSP),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
    FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
);



INSERT INTO KhachHang VALUES ('KH01', N'Nguyễn Văn An', N'Hà Nội', '0901111222');
INSERT INTO KhachHang VALUES ('KH02', N'Trần Thị Bình', N'Hồ Chí Minh', '0912222333');
INSERT INTO KhachHang VALUES ('KH03', N'Lê Văn Cường', N'Đà Nẵng', '0923333444');

INSERT INTO NhanVien VALUES ('NV01', N'Phạm Văn Minh', N'Nam', '1998-05-12', '0981111222');
INSERT INTO NhanVien VALUES ('NV02', N'Hoàng Thị Lan', N'Nữ', '2000-08-20', '0982222333');

INSERT INTO LoaiSanPham VALUES ('L01', N'Điện thoại');
INSERT INTO LoaiSanPham VALUES ('L02', N'Laptop');

INSERT INTO SanPham VALUES ('SP01', N'iPhone 15 Pro', 'L01', 25000000, 10);
INSERT INTO SanPham VALUES ('SP02', N'Samsung Galaxy S24', 'L01', 22000000, 15);
INSERT INTO SanPham VALUES ('SP03', N'MacBook Air M2', 'L02', 28000000, 5);

INSERT INTO HoaDon VALUES ('HD01', 'KH01', 'NV01', '2026-10-01');
INSERT INTO HoaDon VALUES ('HD02', 'KH02', 'NV02', '2026-10-05');

INSERT INTO ChiTietHoaDon VALUES ('HD01', 'SP01', 1, 25000000);
INSERT INTO ChiTietHoaDon VALUES ('HD01', 'SP02', 2, 22000000);
INSERT INTO ChiTietHoaDon VALUES ('HD02', 'SP03', 1, 28000000);





SELECT * FROM SanPham;
SELECT * FROM KhachHang;

SELECT TenSP, GiaBan 
FROM SanPham 
WHERE GiaBan > 24000000;

SELECT * 
FROM SanPham 
ORDER BY GiaBan DESC;

SELECT SUM(SoLuongTon) AS TongSoLuongTon FROM SanPham;
SELECT COUNT(*) AS TongSoKhachHang FROM KhachHang;

SELECT 
    hd.MaHD,
    kh.HoTen,
    kh.DienThoai,
    hd.NgayLapHD
FROM HoaDon hd
JOIN KhachHang kh ON hd.MaKH = kh.MaKH;

SELECT 
    MaLoai,
    COUNT(MaSP) AS SoLuongSanPham
FROM SanPham
GROUP BY MaLoai;