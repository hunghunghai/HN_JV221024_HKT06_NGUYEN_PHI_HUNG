create database QLSV;
use QlSV;

create table dmMakhoa(
	MaKhoa varchar(20) primary key,
    TenKhoa varchar(255)
);

create table dmnganh(
	MaNganh int primary key,
    TenNanganh varchar(255),
    MaKhoa varchar(20),
    foreign key(MaKhoa) references dmMaKhoa(MaKhoa)
);

create table dmhocphan(
	MaHP int primary key,
    TenHP varchar(255),
    Sohvht int,
    MaNganh int,
    Hocky int,
    foreign key(MaNganh) references dmnganh(MaNganh)
);

create table dmlop(
	MaLop varchar(20) primary key,
    TenLop varchar(255),
    MaNganh int,
    KhoaHoc int,
    HeDT varchar(255),
    NamNhapHoc int,
    foreign key(MaNganh) references dmnganh(MaNganh)
);

create table sinhvien(
	MaSv int primary key,
    HoTen varchar(255),
    MaLop varchar(20),
    Gioitinh tinyint(1),
    NgaySinh date,
    DiaChi varchar(255),
    foreign key(MaLop) references dmlop(MaLop)
);

create table diemhp(
MaSV int ,
MaHP int ,
foreign key (MaSV) references sinhvien(MaSV),
foreign key (MaHP) references dmhocphan(MaHP),
DiemHp float
);

INSERT INTO dmMakhoa (MaKhoa, TenKhoa)
VALUES
    ('CNTT', 'Công nghệ thông tin'),
    ('KT', 'Kế Toán'),
    ('SP', 'Sư phạm');

INSERT INTO dmnganh (MaNganh, TenNanganh, MaKhoa)
VALUES
    (140902, 'Sư phạm toán tin', 'SP'),
    (480202, 'Tin học ứng dụng','CNTT');

INSERT INTO dmlop (MaLop, TenLop, MaNganh, KhoaHoc, HeDT, NamNhapHoc)
VALUES
    ('CT11', 'Cao đẳng tin học', '480202', 11, 'TC', 2013),
    ('CT12', 'Cao đẳng tin học', '480202', 12, 'CĐ', 2013),
    ('CT13', 'Cao đẳng tin học', '480202', 13, 'TC', 2014);

INSERT INTO dmhocphan (MaHP, TenHP, Sohvht, MaNganh, Hocky)
VALUES
    (1, 'Toán cấp cấp A1', 4, '480202', 1),
    (2, 'Tiếng Anh 1', 3, '480202', 1),
    (3, 'Vật lý đại cương', 4, '480202', 1),
    (4, 'Tiếng Anh 2', 7, '480202', 1),
    (5, 'Tiếng Anh 1', 3, '140902', 2),
    (6, 'Xác suất thống kê', 3, '480202', 2);

INSERT INTO sinhvien (MaSV, HoTen, MaLop, Gioitinh, NgaySinh, DiaChi)
VALUES
    (1, 'Phan Thanh', 'CT12', 0, '1990-09-12', 'Tuy Phước'),
    (2, 'Nguyễn Thị Cẩm CT12', 'CT12', 1, '1994-01-12', 'Quy Nhơn'),
    (3, 'Võ Thị Hà', 'CT12', 1, '1995-07-02', 'An Nhơn'),
    (4, 'Trần Hoài Nam', 'CT12', 0, '1994-04-05', 'Tây Sơn'),
    (5, 'Trần Văn Hoàng', 'CT13', 0, '1995-08-04', 'Vĩnh Thạnh'),
    (6, 'Đặng Thị Thảo', 'CT13', 1, '1995-06-12', 'Quy Nhơn'),
    (7, 'Lê Thị Sen', 'CT13', 1, '1994-08-12', 'Phù Mỹ'),
    (8, 'Nguyễn Văn Huy CT11', 'CT11', 0, '1995-06-04', 'Tuy Phước'),
    (9, 'Trần Thị Hoa', 'CT11', 1, '1994-08-09', 'Hoài Nhơn');

insert into diemhp(MaSV,MaHP,DiemHp)values
(2,3,5.9),
(2,3,4.5),
(3,1,4.3),
(3,2,6.7),
(3,3,7.3),
(4,1,4),
(4,2,5.2),
(4,3,3.5),
(5,1,9.8),
(5,2,7.9),
(5,3,7.5),
(6,1,6.1),
(6,2,5.6),
(6,3,4),
(7,1,6.2);

SELECT sv.MaSV, sv.HoTen, sv.MaLop, dh.DiemHp, dh.MaHP
FROM sinhvien sv
JOIN diemhp dh ON sv.MaSV = dh.MaSV
WHERE dh.DiemHp >= 5;

SELECT DISTINCT sv.MaSV,sv.HoTen,sv.MaLop,dh.MaHP,dh.DiemHp,hp.TenHP
FROM sinhvien sv
JOIN diemhp dh ON sv.MaSV = dh.MaSV
JOIN dmhocphan hp ON dh.MaHP = hp.MaHP
ORDER BY sv.MaLop ASC,sv.HoTen ASC;

SELECT sv.MaSV,sv.HoTen,sv.MaLop,dh.DiemHp,hp.Hocky
FROM sinhvien sv
JOIN diemhp dh ON sv.MaSV = dh.MaSV
JOIN dmhocphan hp ON dh.MaHP = hp.MaHP
WHERE dh.DiemHp BETWEEN 5 AND 7 AND hp.Hocky = 1;

SELECT sv.MaSV,sv.HoTen,sv.MaLop,lp.TenLop,mk.MaKhoa
FROM sinhvien sv
JOIN dmlop lp ON sv.MaLop = lp.MaLop
JOIN dmnganh ng ON lp.MaNganh = ng.MaNganh
JOIN dmMakhoa mk ON ng.MaKhoa = mk.MaKhoa
WHERE mk.MaKhoa = 'CNTT';

SELECT lp.MaLop,lp.TenLop,COUNT(sv.MaSV) AS SiSo
FROM dmlop lp
LEFT JOIN sinhvien sv ON lp.MaLop = sv.MaLop
GROUP BY lp.MaLop,lp.TenLop;

SELECT sv.MaSV,sv.HoTen,hp.Hocky,SUM(dh.DiemHp * hp.Sohvht) / SUM(hp.Sohvht) AS DiemTBC
FROM sinhvien sv
JOIN diemhp dh ON sv.MaSV = dh.MaSV
JOIN dmhocphan hp ON dh.MaHP = hp.MaHP
GROUP BY sv.MaSV,sv.HoTen,hp.Hocky;

SELECT lp.MaLop,lp.TenLop,COUNT(CASE WHEN sv.Gioitinh = 1 THEN 1 END) AS SoLuongNam,COUNT(CASE WHEN sv.Gioitinh = 0 THEN 1 END) AS SoLuongNu
FROM dmlop lp
LEFT JOIN sinhvien sv ON lp.MaLop = sv.MaLop
GROUP BY lp.MaLop,lp.TenLop;

SELECT sv.MaSV,sv.HoTen,SUM(dh.DiemHp * hp.Sohvht) / SUM(hp.Sohvht) AS DiemTBC
FROM sinhvien sv
JOIN diemhp dh ON sv.MaSV = dh.MaSV
JOIN dmhocphan hp ON dh.MaHP = hp.MaHP
WHERE hp.Hocky = 1
GROUP BY sv.MaSV,sv.HoTen;

SELECT sv.MaSV,sv.HoTen,COUNT(CASE WHEN dh.DiemHp < 5 THEN 1 END) AS SoLuongHocPhanThieuDiem
FROM sinhvien sv
LEFT JOIN diemhp dh ON sv.MaSV = dh.MaSV
GROUP BY sv.MaSV,sv.HoTen;

SELECT dh.MaHP,hp.TenHP,COUNT(CASE WHEN dh.DiemHp < 5 THEN 1 END) AS SoLuongSinhVienDiemThap
FROM diemhp dh
JOIN dmhocphan hp ON dh.MaHP = hp.MaHP
GROUP BY dh.MaHP,hp.TenHP;

SELECT dh.MaSV,sv.HoTen,SUM(hp.Sohvht) AS TongSoDonViHocTrinh
FROM diemhp dh
JOIN dmhocphan hp ON dh.MaHP = hp.MaHP
JOIN sinhvien sv ON dh.MaSV = sv.MaSV
WHERE dh.DiemHp < 5
GROUP BY dh.MaSV,sv.HoTen;

SELECT lp.MaLop,lp.TenLop,COUNT(sv.MaSV) AS SiSo
FROM dmlop lp
JOIN sinhvien sv ON lp.MaLop = sv.MaLop
GROUP BY lp.MaLop,lp.TenLop
HAVING COUNT(sv.MaSV) > 2;

SELECT DISTINCT sv.HoTen, COUNT(CASE WHEN dh.DiemHp < 5 THEN 1 END) AS soluong
FROM sinhvien sv
JOIN diemhp dh ON sv.MaSV = dh.MaSV
WHERE dh.DiemHp < 5
GROUP BY sv.HoTen
HAVING COUNT(DISTINCT dh.MaHP) >= 2;

SELECT sv.HoTen,COUNT(CASE WHEN dh.MaHP IN (1, 2, 3) THEN 1 END) AS Soluong
FROM sinhvien sv
JOIN diemhp dh ON sv.MaSV = dh.MaSV
WHERE dh.MaHP IN (1, 2, 3)
GROUP BY sv.HoTen
HAVING COUNT(DISTINCT dh.MaHP) >= 3;