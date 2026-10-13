-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 13, 2026 at 06:38 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `autolavadopruun`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `clasificacion`
-- (See below for the actual view)
--
CREATE TABLE `clasificacion` (
`ID` int(11)
,`N_Cliente` varchar(50)
,`totalG` decimal(32,2)
,`Clasificacion` varchar(18)
);

-- --------------------------------------------------------

--
-- Table structure for table `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `edad` int(11) NOT NULL,
  `Nacionalidad` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombre`, `edad`, `Nacionalidad`) VALUES
(1, 'juan', 29, 'mx'),
(2, 'maria', 45, 'mx'),
(3, 'pedro', 29, 'mx'),
(4, 'ana', 36, 'ca'),
(5, 'luis', 56, 'usa'),
(6, 'carlos', 49, 'co'),
(7, 'sofia', 19, 'cl'),
(8, 'diego', 66, 'ar'),
(9, 'valeria', 25, 'br'),
(10, 'jorge', 44, 'am');

-- --------------------------------------------------------

--
-- Stand-in structure for view `clientes_activos`
-- (See below for the actual view)
--
CREATE TABLE `clientes_activos` (
`id_cliente` int(11)
,`nombre` varchar(50)
,`c_compra` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `gastosxcliente`
-- (See below for the actual view)
--
CREATE TABLE `gastosxcliente` (
`id_cliente` int(11)
,`nombre` varchar(50)
,`Cantidad` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `reto`
-- (See below for the actual view)
--
CREATE TABLE `reto` (
`id_cliente` int(11)
,`nombre` varchar(50)
,`compras_R` bigint(21)
,`TG` decimal(32,2)
,`Clasificacion` varchar(17)
);

-- --------------------------------------------------------

--
-- Table structure for table `servicios`
--

CREATE TABLE `servicios` (
  `id_servicio` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `servicios`
--

INSERT INTO `servicios` (`id_servicio`, `Nombre`, `precio`) VALUES
(1, 'lavadoBasico', '100.00'),
(2, 'lavadoPremium', '300.00'),
(3, 'aspirado', '150.00'),
(4, 'encerado', '200.00'),
(5, 'lavadodeMotor', '300.00'),
(6, 'pulido', '600.00'),
(7, 'lavadoExpres', '150.00'),
(8, 'desinfeccion', '400.00'),
(9, 'lavadoCompleto', '400.00'),
(10, 'tratamientoPintura', '2500.00'),
(11, 'servicio_Detallado', '200.00');

-- --------------------------------------------------------

--
-- Stand-in structure for view `servicios_caros`
-- (See below for the actual view)
--
CREATE TABLE `servicios_caros` (
`id_servicio` int(11)
,`nombre` varchar(50)
,`precio` decimal(10,2)
,`Clasificacion` varchar(18)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `servicios_vendidos`
-- (See below for the actual view)
--
CREATE TABLE `servicios_vendidos` (
`ID` int(11)
,`N_Servicios` varchar(50)
,`Cantidad_sV` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_servicio` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ventas`
--

INSERT INTO `ventas` (`id_venta`, `id_cliente`, `id_servicio`, `fecha`) VALUES
(1, 1, 10, '2026-01-25'),
(2, 2, 7, '2026-02-12'),
(3, 3, 6, '2026-02-20'),
(4, 4, 3, '2026-03-05'),
(5, 5, 8, '2026-04-10'),
(6, 6, 2, '2026-04-22'),
(7, 7, 1, '2026-01-30'),
(8, 8, 5, '2026-02-28'),
(9, 9, 4, '2026-03-22'),
(10, 2, 9, '2026-02-02'),
(11, 1, 2, '2026-04-29'),
(12, 1, 9, '2026-04-11'),
(13, 1, 7, '2026-03-29'),
(14, 5, 8, '2026-01-19'),
(15, 5, 5, '2026-03-30'),
(16, 4, 2, '2026-02-05'),
(17, 5, 1, '2026-01-09'),
(18, 7, 7, '2026-02-01'),
(19, 8, 4, '2026-03-15');

-- --------------------------------------------------------

--
-- Stand-in structure for view `ventasxmes`
-- (See below for the actual view)
--
CREATE TABLE `ventasxmes` (
`Mes` int(2)
,`TGXM` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Structure for view `clasificacion`
--
DROP TABLE IF EXISTS `clasificacion`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `clasificacion`  AS SELECT `c`.`id_cliente` AS `ID`, `c`.`nombre` AS `N_Cliente`, coalesce(sum(`s`.`precio`),0) AS `totalG`, CASE WHEN coalesce(sum(`s`.`precio`),0) >= 2000 THEN 'Cliente-VIP' WHEN coalesce(sum(`s`.`precio`),0) >= 700 THEN 'Cliente_Frecuente ' WHEN coalesce(sum(`s`.`precio`),0) < 700 THEN 'Cliente_Normal' END AS `Clasificacion` FROM ((`clientes` `c` join `ventas` `v` on(`c`.`id_cliente` = `v`.`id_cliente`)) join `servicios` `s` on(`v`.`id_servicio` = `s`.`id_servicio`)) GROUP BY `c`.`id_cliente`, `c`.`nombre``nombre`  ;

-- --------------------------------------------------------

--
-- Structure for view `clientes_activos`
--
DROP TABLE IF EXISTS `clientes_activos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `clientes_activos`  AS SELECT `c`.`id_cliente` AS `id_cliente`, `c`.`nombre` AS `nombre`, count(`v`.`id_cliente`) AS `c_compra` FROM (`clientes` `c` join `ventas` `v` on(`c`.`id_cliente` = `v`.`id_cliente`)) GROUP BY `c`.`id_cliente`, `c`.`nombre``nombre`  ;

-- --------------------------------------------------------

--
-- Structure for view `gastosxcliente`
--
DROP TABLE IF EXISTS `gastosxcliente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gastosxcliente`  AS SELECT `c`.`id_cliente` AS `id_cliente`, `c`.`nombre` AS `nombre`, coalesce(sum(`s`.`precio`),0) AS `Cantidad` FROM ((`clientes` `c` join `ventas` `v` on(`c`.`id_cliente` = `v`.`id_cliente`)) join `servicios` `s` on(`v`.`id_servicio` = `s`.`id_servicio`)) GROUP BY `c`.`id_cliente`, `c`.`nombre``nombre`  ;

-- --------------------------------------------------------

--
-- Structure for view `reto`
--
DROP TABLE IF EXISTS `reto`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `reto`  AS SELECT `c`.`id_cliente` AS `id_cliente`, `c`.`nombre` AS `nombre`, count(`v`.`id_cliente`) AS `compras_R`, coalesce(sum(`s`.`precio`),0) AS `TG`, CASE WHEN count(`v`.`id_cliente`) >= 3 THEN 'cliente_VIP' WHEN count(`v`.`id_cliente`) >= 2 THEN 'cliente_Frecuente' ELSE 'cliente_Normal' END AS `Clasificacion` FROM ((`clientes` `c` join `ventas` `v` on(`c`.`id_cliente` = `v`.`id_cliente`)) join `servicios` `s` on(`v`.`id_servicio` = `s`.`id_servicio`)) GROUP BY `c`.`id_cliente`, `c`.`nombre``nombre`  ;

-- --------------------------------------------------------

--
-- Structure for view `servicios_caros`
--
DROP TABLE IF EXISTS `servicios_caros`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `servicios_caros`  AS SELECT `s`.`id_servicio` AS `id_servicio`, `s`.`Nombre` AS `nombre`, `s`.`precio` AS `precio`, CASE WHEN `s`.`precio` >= 2000 THEN 'Servicio_caro' WHEN `s`.`precio` >= 200 THEN 'servicios_Normales' WHEN `s`.`precio` < 200 THEN 'servicio_Economico' END AS `Clasificacion` FROM `servicios` AS `s` GROUP BY `s`.`id_servicio`, `s`.`Nombre``Nombre`  ;

-- --------------------------------------------------------

--
-- Structure for view `servicios_vendidos`
--
DROP TABLE IF EXISTS `servicios_vendidos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `servicios_vendidos`  AS SELECT `s`.`id_servicio` AS `ID`, `s`.`Nombre` AS `N_Servicios`, count(`v`.`id_servicio`) AS `Cantidad_sV` FROM (`servicios` `s` join `ventas` `v` on(`s`.`id_servicio` = `v`.`id_servicio`)) GROUP BY `s`.`id_servicio`, `s`.`Nombre``Nombre`  ;

-- --------------------------------------------------------

--
-- Structure for view `ventasxmes`
--
DROP TABLE IF EXISTS `ventasxmes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ventasxmes`  AS SELECT month(`v`.`fecha`) AS `Mes`, coalesce(sum(`s`.`precio`),0) AS `TGXM` FROM (`servicios` `s` join `ventas` `v` on(`s`.`id_servicio` = `v`.`id_servicio`)) GROUP BY month(`v`.`fecha`)  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indexes for table `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id_servicio`);

--
-- Indexes for table `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_servicio` (`id_servicio`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
