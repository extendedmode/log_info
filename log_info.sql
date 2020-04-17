
-- Dumping structure for table panda_db.account_info
CREATE TABLE IF NOT EXISTS `account_info` (
  `steam64_hex` varchar(30) NOT NULL,
  `rockstar` varchar(60) DEFAULT NULL,
  `ipv4` varchar(15) DEFAULT NULL,
  `rp_name` varchar(100) DEFAULT NULL,
  `steam_name` varchar(100) DEFAULT NULL,
  `live` varchar(25) DEFAULT NULL,
  `fivem` varchar(25) DEFAULT NULL,
  `discord` varchar(30) DEFAULT NULL,
  `xbl` varchar(25) DEFAULT NULL,
  `online_time` mediumint(9) DEFAULT '0',
  `last_connection` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`steam64_hex`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
