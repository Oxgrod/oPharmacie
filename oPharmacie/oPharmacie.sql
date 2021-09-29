INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_pharmacie', 'pharmacie', 1);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_pharmacie', 'pharmacie', 1);

INSERT INTO `jobs` (`name`, `label`) VALUES
('pharmacie', 'pharmacie');

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(180, 'pharmacie', 0, 'novice', 'Novice', 100, '', ''),
(181, 'pharmacie', 1, 'experimente', 'Experimenté', 100, '', ''),
(182, 'pharmacie', 2, 'boss', 'Patron', 100, '', '');