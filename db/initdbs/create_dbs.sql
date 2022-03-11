CREATE DATABASE IF NOT EXISTS `reddish_production`;
GRANT ALL ON `reddish_production`.* TO 'processor'@'%';

CREATE DATABASE IF NOT EXISTS `reddish_development`;
GRANT ALL ON `reddish_development`.* TO 'processor'@'%';

CREATE DATABASE IF NOT EXISTS `reddish_test`;
GRANT ALL ON `reddish_test`.* TO 'processor'@'%';