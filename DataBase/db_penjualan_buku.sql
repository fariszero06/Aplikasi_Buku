-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 26 Des 2022 pada 10.42
-- Versi server: 10.4.27-MariaDB
-- Versi PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_penjualan_buku`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `kd_buku` varchar(10) NOT NULL,
  `judul` varchar(50) NOT NULL,
  `jenis` varchar(10) NOT NULL,
  `penulis` varchar(50) NOT NULL,
  `penerbit` varchar(50) NOT NULL,
  `tahun` varchar(4) NOT NULL,
  `stok` int(3) NOT NULL,
  `harga_pokok` int(5) NOT NULL,
  `harga_jual` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`kd_buku`, `judul`, `jenis`, `penulis`, `penerbit`, `tahun`, `stok`, `harga_pokok`, `harga_jual`) VALUES
('BK01', 'Bahasa Pemrograman', 'Pendidikan', 'Sunandi', 'Gramedia', '2017', 700, 90, 120),
('BK02', 'Manusia Setengah Salmon', 'Novel', 'Raditya Dika', 'Gagas Media', '2011', 900, 75, 85),
('K0003', 'Matekmatika', 'Edukasi', 'Ahmad', 'Gramedia', '2019', 8, 90, 120);

-- --------------------------------------------------------

--
-- Struktur dari tabel `distributor`
--

CREATE TABLE `distributor` (
  `kd_distributor` varchar(10) NOT NULL,
  `nama_distributor` varchar(50) NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `telepon` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `distributor`
--

INSERT INTO `distributor` (`kd_distributor`, `nama_distributor`, `alamat`, `telepon`) VALUES
('D0001', 'Zhafari Irsyad', 'Ciawi', '081804958151'),
('D0002', 'Pramudya Saputra', 'Caringin Maseng', '0901313123332');

-- --------------------------------------------------------

--
-- Struktur dari tabel `login`
--

CREATE TABLE `login` (
  `nama` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `login`
--

INSERT INTO `login` (`nama`, `username`, `password`) VALUES
('Zhafari Irsyad', 'admin', 'admin'),
('Faris Syahluthfi', 'faris', '123'),
('Shobahus Solichin', 'shoba', '123');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `kd_pelanggan` varchar(10) NOT NULL,
  `nama_pelanggan` varchar(50) NOT NULL,
  `jenis_kelamin` varchar(1) NOT NULL,
  `alamat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `pelanggan`
--

INSERT INTO `pelanggan` (`kd_pelanggan`, `nama_pelanggan`, `jenis_kelamin`, `alamat`) VALUES
('PL0001', 'Zhafari Irsyad', 'L', 'Ciawi'),
('PL0002', 'Pramudya Saputra', 'P', 'Caringin Maseng'),
('PL0003', 'ADIT', 'L', 'CIKARANG');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penjualan`
--

CREATE TABLE `penjualan` (
  `kd_pretransaksi` varchar(10) NOT NULL,
  `kd_transaksi` varchar(10) NOT NULL,
  `kd_pelanggan` varchar(10) NOT NULL,
  `kd_buku` varchar(10) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `sub_total` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `penjualan`
--

INSERT INTO `penjualan` (`kd_pretransaksi`, `kd_transaksi`, `kd_pelanggan`, `kd_buku`, `jumlah`, `sub_total`) VALUES
('PS0001', 'TR0001', 'PL0001', 'K0004', 2, 120000),
('PS0002', 'TR0001', 'PL0001', 'K0004', 4, 240000),
('PS0003', 'TR0001', 'PL0001', 'K0003', 2, 300000),
('PS0004', 'TR0002', 'PL0002', 'K0004', 2, 120000),
('PS0005', 'TR0002', 'PL0002', 'K0004', 2, 120000),
('PS0006', 'TR0002', 'PL0002', 'K0003', 1, 150000),
('PS0007', 'TR0003', 'PL0001', 'K0004', 3, 180000),
('PS0008', 'TR0003', 'PL0001', 'K0004', 2, 120000);

--
-- Trigger `penjualan`
--
DELIMITER $$
CREATE TRIGGER `Batal` AFTER DELETE ON `penjualan` FOR EACH ROW UPDATE buku
SET stok = stok + OLD.jumlah
WHERE
kd_buku = OLD.kd_buku
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `penjualan2`
--

CREATE TABLE `penjualan2` (
  `kd_transaksi` varchar(10) NOT NULL,
  `nama_pelanggan` varchar(50) NOT NULL,
  `total` int(50) NOT NULL,
  `tanggal_beli` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `penjualan2`
--

INSERT INTO `penjualan2` (`kd_transaksi`, `nama_pelanggan`, `total`, `tanggal_beli`) VALUES
('TR0001', 'Zhafari Irsyad', 660000, '2018-02-16 23:11:36'),
('TR0002', 'Pramudya Saputra', 390000, '2018-02-16 23:13:13'),
('TR0003', 'Zhafari Irsyad', 300000, '2018-02-21 20:50:22'),
('TR0004', 'faris', 240000, '2022-12-26 09:23:18');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `perbulan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `perbulan` (
`kd_buku` varchar(10)
,`judul` varchar(50)
,`jenis` varchar(10)
,`jumlah` int(11)
,`tanggal_beli` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `struk`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `struk` (
`nama_pelanggan` varchar(50)
,`total` int(50)
,`tanggal_beli` timestamp
,`kd_transaksi` varchar(10)
,`jumlah` int(11)
,`sub_total` int(20)
,`judul` varchar(50)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `perbulan`
--
DROP TABLE IF EXISTS `perbulan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `perbulan`  AS SELECT `buku`.`kd_buku` AS `kd_buku`, `buku`.`judul` AS `judul`, `buku`.`jenis` AS `jenis`, `penjualan`.`jumlah` AS `jumlah`, `penjualan2`.`tanggal_beli` AS `tanggal_beli` FROM ((`buku` join `penjualan` on(`buku`.`kd_buku` = `penjualan`.`kd_buku`)) join `penjualan2` on(`buku`.`kd_buku` = `penjualan`.`kd_buku`))  ;

-- --------------------------------------------------------

--
-- Struktur untuk view `struk`
--
DROP TABLE IF EXISTS `struk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `struk`  AS SELECT `penjualan2`.`nama_pelanggan` AS `nama_pelanggan`, `penjualan2`.`total` AS `total`, `penjualan2`.`tanggal_beli` AS `tanggal_beli`, `penjualan`.`kd_transaksi` AS `kd_transaksi`, `penjualan`.`jumlah` AS `jumlah`, `penjualan`.`sub_total` AS `sub_total`, `buku`.`judul` AS `judul` FROM ((`penjualan2` join `penjualan` on(`penjualan2`.`kd_transaksi` = `penjualan`.`kd_transaksi`)) join `buku` on(`penjualan`.`kd_buku` = `buku`.`kd_buku`))  ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`kd_buku`);

--
-- Indeks untuk tabel `distributor`
--
ALTER TABLE `distributor`
  ADD PRIMARY KEY (`kd_distributor`);

--
-- Indeks untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`kd_pelanggan`);

--
-- Indeks untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`kd_pretransaksi`),
  ADD KEY `kd_transaksi` (`kd_transaksi`),
  ADD KEY `kd_pelanggan` (`kd_pelanggan`);

--
-- Indeks untuk tabel `penjualan2`
--
ALTER TABLE `penjualan2`
  ADD PRIMARY KEY (`kd_transaksi`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `penjualan_ibfk_1` FOREIGN KEY (`kd_transaksi`) REFERENCES `penjualan2` (`kd_transaksi`),
  ADD CONSTRAINT `penjualan_ibfk_2` FOREIGN KEY (`kd_pelanggan`) REFERENCES `pelanggan` (`kd_pelanggan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
