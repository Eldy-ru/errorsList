/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;
/*
Набросал по памяти структуру DB
*/

CREATE DATABASE `errors` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `errors`;

#
# Table structure for table company
#

CREATE TABLE `company` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
UNLOCK TABLES;

#
# Table structure for table error
#

CREATE TABLE `error` (
  `id` int(11) NOT NULL auto_increment,
  `ec_id` int(11) default NULL COMMENT 'error_code.id',
  `p_id` int(11) default NULL COMMENT 'product.id',
  PRIMARY KEY  (`id`),
  KEY `fk_error_error_code` (`ec_id`),
  KEY `fk_error_product` (`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
UNLOCK TABLES;

#
# Table structure for table error_code
#

CREATE TABLE `error_code` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
UNLOCK TABLES;

#
# Table structure for table error_descr
#

CREATE TABLE `error_descr` (
  `id` int(11) NOT NULL auto_increment,
  `err_id` int(11) default NULL COMMENT 'error.id',
  `lang_id` char(3) NOT NULL default 'rus',
  `name` varchar(255) NOT NULL default '',
  `descr` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_err_descr_err` (`err_id`),
  KEY `fk_err_descr_lang` (`lang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
UNLOCK TABLES;

#
# Table structure for table lang
#

CREATE TABLE `lang` (
  `id` char(3) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `lang` VALUES ('eng','English');
INSERT INTO `lang` VALUES ('rus','Русский');
UNLOCK TABLES;

#
# Table structure for table product
#

CREATE TABLE `product` (
  `id` int(11) NOT NULL auto_increment,
  `comp_id` int(11) default NULL COMMENT 'company.id',
  `name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `fk_prod_comp` (`comp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
UNLOCK TABLES;

#
#  Foreign keys for table error
#

ALTER TABLE `error`
ADD CONSTRAINT `fk_error_error_code` FOREIGN KEY (`ec_id`) REFERENCES `error_code` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_error_product` FOREIGN KEY (`p_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

#
#  Foreign keys for table error_descr
#

ALTER TABLE `error_descr`
ADD CONSTRAINT `fk_err_descr_lang` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`),
  ADD CONSTRAINT `fk_err_descr_err` FOREIGN KEY (`err_id`) REFERENCES `error` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

#
#  Foreign keys for table product
#

ALTER TABLE `product`
ADD CONSTRAINT `fk_prod_comp` FOREIGN KEY (`comp_id`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
