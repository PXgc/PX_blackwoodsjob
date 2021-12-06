INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_bariste', 'bariste', 1);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_bariste', 'bariste', 1);

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('society_bariste', 'bariste', 1);

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('bariste', 'Bariste', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('bariste', 0, 'novice', 'Novice', 100, '', ''),
('bariste', 1, 'experimente', 'Experimenté', 100, '', ''),
('bariste', 2, 'boss', 'Patron', 100, '', '');

INSERT INTO `items` (`name`, `label`) VALUES
	('cafe', 'Café'),
	('cookie', 'Cookie')
;