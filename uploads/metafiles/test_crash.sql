-- Current Database: `test_crash`

USE `test_crash`;

CREATE TABLE `t31` ( `c1` bigint(20), `c2` bigint(20), UNIQUE KEY `k1` (`c1`,`c2`) );
