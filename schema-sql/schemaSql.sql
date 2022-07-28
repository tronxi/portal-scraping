CREATE TABLE `portals` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `portal`.`cities` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`));


CREATE TABLE `rooms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `portal_id` int NOT NULL,
  `city_id` int NOT NULL,
  `link` varchar(512) DEFAULT NULL,
  `rent_value` varchar(45) DEFAULT NULL,
  `rent_type` varchar(45) DEFAULT NULL,
  `neighbourhood` varchar(100) DEFAULT NULL,
  `title` varchar(512) DEFAULT NULL,
  `configuration` varchar(512) DEFAULT NULL,
  `persons` varchar(45) DEFAULT NULL,
  `bedrooms` varchar(45) DEFAULT NULL,
  `bathrooms` varchar(45) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `modification_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_portal_idx` (`portal_id`),
  KEY `fk_city_idx` (`city_id`),
  CONSTRAINT `fk_city` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_portal` FOREIGN KEY (`portal_id`) REFERENCES `portals` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
);

INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('0', 'coimbra');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('1', 'valencia');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('2', 'lisbon');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('3', 'madrid');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('5', 'granada');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('6', 'seville');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('7', 'porto');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('8', 'rome');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('9', 'london');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('10', 'prague');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('11', 'barcelona');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('12', 'vila-nova-de-gaia');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('13', 'turin');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('14', 'leipzig');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('15', 'manchester');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('16', 'bilbao');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('17', 'malaga');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('18', 'zaragoza');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('19', 'bologna');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('20', 'aachen');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('21', 'munich');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('22', 'lille');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('23', 'cadiz');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('24', 'palma-de-mallorca');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('25', 'berlin');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('26', 'potsdam');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('27', 'paris');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('28', 'cordova');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('29', 'salamanca');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('30', 'milan');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('31', 'frankfurt');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('32', 'stuttgart');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('33', 'dublin');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('34', 'alicante');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('35', 'hamburg');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('36', 'new-york');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('37', 'boston');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('38', 'los-angeles');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('39', 'rio-de-janeiro');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('40', 'sao-paulo');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('41', 'sydney');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('42', 'cardiff');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('43', 'leeds');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('44', 'nottingham');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('45', 'sheffield');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('46', 'braga');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('47', 'murcia');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('48', 'florence');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('49', 'toulouse');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('50', 'buenos-aires');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('51', 'adelaide');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('52', 'brisbane');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('53', 'gold-coast');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('54', 'melbourne');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('55', 'perth');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('56', 'calgary');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('57', 'montreal');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('58', 'ottawa');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('59', 'surrey');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('60', 'toronto');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('61', 'vancouver');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('62', 'aarhus');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('63', 'amsterdam');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('64', 'castricum');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('65', 'delft');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('66', 'eindhoven');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('67', 'groningen');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('68', 'maastricht');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('69', 'rotterdam');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('70', 'the-hague');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('71', 'utrecht');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('72', 'oslo');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('73', 'gothenburg');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('74', 'stockholm');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('75', 'brussels');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('76', 'krakow');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('77', 'warsaw');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('78', 'budapest');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('79', 'vienna');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('80', 'cape-town');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('81', 'atlanta');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('82', 'chicago');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('83', 'houston');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('84', 'orlando');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('85', 'philadelphia');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('86', 'san-diego');
INSERT INTO `portal`.`cities` (`id`, `name`) VALUES ('87', 'san-francisco');

