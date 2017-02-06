
# 12.6s user time, 60ms system time, 23.64M rss, 174.76M vsz
# Current date: Wed Dec 28 15:37:58 2016
# Hostname: VCCMNTD1503
# Files: general_query.log
# Overall: 64.86k total, 82 unique, 212.67 QPS, 0x concurrency ___________
# Time range: 2016-12-28 15:27:43 to 15:32:48
# Attribute          total     min     max     avg     95%  stddev  median
# ============     ======= ======= ======= ======= ======= ======= =======
# Exec time              0       0       0       0       0       0       0
# Query size        12.58M       8     931  203.42  563.87  137.22  166.51

# Profile
# Rank Query ID           Response time Calls R/Call V/M   Item
# ==== ================== ============= ===== ====== ===== ===============
#    1 0xF78DB60D5A0EC3A9  0.0000  0.0% 12610 0.0000  0.00 SELECT token_nonce_?
#    2 0xD704059F644FBDAA  0.0000  0.0% 11694 0.0000  0.00 SELECT token_?
#    3 0x0006CE4E6E71CFB9  0.0000  0.0%  6836 0.0000  0.00 INSERT
#    4 0x346FED6D70D41FD4  0.0000  0.0%  6560 0.0000  0.00 SELECT token_?
#    5 0x8C070A15296D141E  0.0000  0.0%  6007 0.0000  0.00 UPDATE
#    6 0x7A0785E0D30B399B  0.0000  0.0%  5847 0.0000  0.00 SELECT token_?
#    7 0x3E4AED918D139170  0.0000  0.0%  5564 0.0000  0.00 INSERT
#    8 0x5D9793959BFD98D5  0.0000  0.0%  4971 0.0000  0.00 DELETE token_nonce_?
#    9 0xAA353644DE4C4CB4  0.0000  0.0%   499 0.0000  0.00 ADMIN QUIT
#   10 0x5D51E5F01B88B79E  0.0000  0.0%   498 0.0000  0.00 ADMIN CONNECT
#   11 0x9E77CAC3D078711A  0.0000  0.0%   446 0.0000  0.00 UPDATE
#   12 0x3AEAAD0E15D725B5  0.0000  0.0%   422 0.0000  0.00 SET
#   13 0x3293FA2D09738ACE  0.0000  0.0%   383 0.0000  0.00 SELECT token_?
#   14 0xE4CF7146873CCC28  0.0000  0.0%   316 0.0000  0.00 SET
#   15 0xE795E438F52CEF3A  0.0000  0.0%   316 0.0000  0.00 SELECT
#   16 0xAD312D56C6B3D880  0.0000  0.0%   305 0.0000  0.00 SET
#   17 0x5E7B7A2B492F56AC  0.0000  0.0%   305 0.0000  0.00 SET
#   18 0xF0265D81808CE240  0.0000  0.0%   304 0.0000  0.00 SELECT
#   19 0x49E4A5290E7E796D  0.0000  0.0%   251 0.0000  0.00 SELECT token_? token_nonce_? token_?
#   20 0xAB5577DB6446DA03  0.0000  0.0%   122 0.0000  0.00 UPDATE mysql.mmm
# MISC 0xMISC              0.0000  0.0%   608 0.0000   0.0 <62 ITEMS>

# Query 1: 41.34 QPS, 0x concurrency, ID 0xF78DB60D5A0EC3A9 at byte 14349737
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:48
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count         19   12610
# Exec time      0       0       0       0       0       0       0       0
# Query size    10   1.27M     106     106     106     106       0     106
# String:
# Databases    mysql (12564/99%), authct_tok... (46/0%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
# Tables
#    SHOW TABLE STATUS FROM `mysql` LIKE 'token_nonce_2'\G
#    SHOW CREATE TABLE `mysql`.`token_nonce_2`\G
# EXPLAIN /*!50100 PARTITIONS*/
SELECT /*!99999 nonce.selectOne */ *
    FROM `token_nonce_2`
    WHERE token_key = 'EcQU38UcXwyGUbuq8Ba2'\G

# Query 2: 38.34 QPS, 0x concurrency, ID 0xD704059F644FBDAA at byte 14349164
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:48
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count         18   11694
# Exec time      0       0       0       0       0       0       0       0
# Query size    14   1.87M     168     168     168     168       0     168
# String:
# Databases    mysql (11649/99%), authct_tok... (45/0%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
# Tables
#    SHOW TABLE STATUS FROM `mysql` LIKE 'token_2'\G
#    SHOW CREATE TABLE `mysql`.`token_2`\G
# EXPLAIN /*!50100 PARTITIONS*/
SELECT /*!99999 token.selectValidOne */ *
    FROM `token_2`
    WHERE token_key = 'Ec5Dm9PP8Pb5KsjlmA52' AND cancel_status IS NULL
    ORDER BY issued DESC
    LIMIT 1\G

# Query 3: 22.41 QPS, 0x concurrency, ID 0x0006CE4E6E71CFB9 at byte 14348599
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:48
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count         10    6836
# Exec time      0       0       0       0       0       0       0       0
# Query size    29   3.70M     549     598  567.21  563.87   10.14  563.87
# String:
# Databases    mysql (6816/99%), authct_tok... (20/0%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
INSERT IGNORE INTO /*!99999 token.insertIgnore */ `token_2`
    SET
    token_key = 'Ec5Dm9PP8Pb5KsjlmA52',
    token_secret = 'WjBGOaMjC3MTR2x0aZYU',
    user_hash = 'abf5451957ad7e0d91707ae8b1460ee2',
    slice = 2492,
    cancel_status = null,
    issued = '2016-12-28 15:32:48',
    expired = '2017-12-28 15:32:48',
    updated = '2016-12-28 15:32:48',
    consumer_key = 'awi4t3ljhfzilgj',
    client_type = 'CA',
    verification_type = 'Q',
    ip = '153.179.25.205',
    system_name = 'Chrome',
    temp1 = IF(0 = 0, NULL, 0),
    temp2 = IF(0 = 0, NULL, 0)\G

# Query 4: 21.51 QPS, 0x concurrency, ID 0x346FED6D70D41FD4 at byte 14348326
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:48
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count         10    6560
# Exec time      0       0       0       0       0       0       0       0
# Query size    12   1.54M     246     246     246     246       0     246
# String:
# Databases    mysql (6539/99%), authct_tok... (21/0%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
# Tables
#    SHOW TABLE STATUS FROM `mysql` LIKE 'token_2'\G
#    SHOW CREATE TABLE `mysql`.`token_2`\G
# EXPLAIN /*!50100 PARTITIONS*/
SELECT /*!99999 token.selectValidListBySearch */ *
    FROM `token_2`
    WHERE
    user_hash = 'abf5451957ad7e0d91707ae8b1460ee2'
    AND cancel_status IS NULL
     
      AND consumer_key in
         (  
            'awi4t3ljhfzilgj'
         )\G

# Query 5: 19.70 QPS, 0x concurrency, ID 0x8C070A15296D141E at byte 14342235
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:48
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          9    6007
# Exec time      0       0       0       0       0       0       0       0
# Query size     8   1.05M     183     183     183     183       0     183
# String:
# Databases    mysql (5981/99%), authct_tok... (26/0%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
UPDATE /*!99999 token.updateCancelStatusInUserHashShard */ `token_3`
    SET
    cancel_status = 'DL',
    updated = '2016-12-28 15:32:48'
    WHERE token_key = '97blFs6qNPhhnh6Wmcw3'\G
# Converted for EXPLAIN
# EXPLAIN /*!50100 PARTITIONS*/
select 
    cancel_status = 'DL',
    updated = '2016-12-28 15:32:48' from /*!99999 token.updateCancelStatusInUserHashShard */ `token_3` where  token_key = '97blFs6qNPhhnh6Wmcw3'\G

# Query 6: 19.17 QPS, 0x concurrency, ID 0x7A0785E0D30B399B at byte 14344925
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:48
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          9    5847
# Exec time      0       0       0       0       0       0       0       0
# Query size     7 913.59k     160     160     160     160       0     160
# String:
# Databases    mysql (5826/99%), authct_tok... (21/0%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
# Tables
#    SHOW TABLE STATUS FROM `mysql` LIKE 'token_3'\G
#    SHOW CREATE TABLE `mysql`.`token_3`\G
# EXPLAIN /*!50100 PARTITIONS*/
SELECT /*!99999 token.selectValidListBySearch */ *
    FROM `token_3`
    WHERE
    user_hash = '896989ba5cd2e20bcea893a7bd8c1d13'
    AND cancel_status IS NULL\G

# Query 7: 18.24 QPS, 0x concurrency, ID 0x3E4AED918D139170 at byte 14349498
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:48
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          8    5564
# Exec time      0       0       0       0       0       0       0       0
# Query size    10   1.33M     250     250     250     250       0     250
# String:
# Databases    mysql (5547/99%), authct_tok... (17/0%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
INSERT IGNORE INTO /*!99999 nonce.insertIgnore */ `token_nonce_2`
    SET
    token_key = 'Ec5Dm9PP8Pb5KsjlmA52',
    nonce = 1482906768307,
    expired = '2016-12-30 15:32:48',
    created = '2016-12-28 15:32:48',
    updated = '2016-12-28 15:32:48'\G

# Query 8: 16.30 QPS, 0x concurrency, ID 0x5D9793959BFD98D5 at byte 14340950
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:48
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          7    4971
# Exec time      0       0       0       0       0       0       0       0
# Query size     3 490.30k     101     101     101     101       0     101
# String:
# Databases    mysql (4949/99%), authct_tok... (22/0%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
# Tables
#    SHOW TABLE STATUS FROM `mysql` LIKE 'token_nonce_2'\G
#    SHOW CREATE TABLE `mysql`.`token_nonce_2`\G
DELETE /*!99999 nonce.delete */
    FROM `token_nonce_2`
    WHERE token_key = 'Ec4lm3OEAlZhQFVhKMW2'\G
# Converted for EXPLAIN
# EXPLAIN /*!50100 PARTITIONS*/
select * from  `token_nonce_2`
    WHERE token_key = 'Ec4lm3OEAlZhQFVhKMW2'\G

# Query 9: 1.64 QPS, 0x concurrency, ID 0xAA353644DE4C4CB4 at byte 14324339
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:47
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          0     499
# Exec time      0       0       0       0       0       0       0       0
# Query size     0  13.16k      27      27      27      27       0      27
# String:
# Databases    mysql (497/99%), authct_tok... (2/0%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
administrator command: Quit\G

# Query 10: 1.64 QPS, 0x concurrency, ID 0x5D51E5F01B88B79E at byte 14323999
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:47
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          0     498
# Exec time      0       0       0       0       0       0       0       0
# Query size     0  14.59k      30      30      30      30       0      30
# String:
# Databases    mysql (496/99%), authct_tok... (2/0%)
# Hosts        127.0.0.1 (315/63%), 10.32.131.220 (105/21%)... 4 more
# Users        agent (305/61%), mmm (166/33%)... 3 more
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
administrator command: Connect\G

# Query 11: 1.47 QPS, 0x concurrency, ID 0x9E77CAC3D078711A at byte 14333034
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:44 to 15:32:47
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          0     446
# Exec time      0       0       0       0       0       0       0       0
# Query size     0 100.18k     230     230     230     230       0     230
# String:
# Databases    mysql (445/99%), authct_tok... (1/0%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
UPDATE /*!99999 nonce.update */ `token_nonce_1`
    SET
    nonce = 1482906767966,
    expired = '2016-12-30 15:32:47',
    updated = '2016-12-28 15:32:47'
    WHERE
    token_key = 'EcR6kqW6oL53mzbrmJ21' AND nonce = 1482819493360\G
# Converted for EXPLAIN
# EXPLAIN /*!50100 PARTITIONS*/
select 
    nonce = 1482906767966,
    expired = '2016-12-30 15:32:47',
    updated = '2016-12-28 15:32:47' from /*!99999 nonce.update */ `token_nonce_1` where 
    token_key = 'EcR6kqW6oL53mzbrmJ21' AND nonce = 1482819493360\G

# Query 12: 1.39 QPS, 0x concurrency, ID 0x3AEAAD0E15D725B5 at byte 14324279
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:47
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          0     422
# Exec time      0       0       0       0       0       0       0       0
# Query size     0   6.59k      16      16      16      16       0      16
# String:
# Databases    mysql (421/99%), authct_tok... (1/0%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
SET autocommit=1\G

# Query 13: 1.27 QPS, 0x concurrency, ID 0x3293FA2D09738ACE at byte 14211598
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:45
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          0     383
# Exec time      0       0       0       0       0       0       0       0
# Query size     0 110.17k     284     325  294.55  313.99   19.01  271.23
# String:
# Databases    mysql
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
# Tables
#    SHOW TABLE STATUS FROM `mysql` LIKE 'token_3'\G
#    SHOW CREATE TABLE `mysql`.`token_3`\G
# EXPLAIN /*!50100 PARTITIONS*/
SELECT /*!99999 token.selectValidListBySearch */ *
    FROM `token_3`
    WHERE
    user_hash = '9a60b1b99e2a4de7917795b5e2c85ad3'
    AND cancel_status IS NULL
     
      AND consumer_key in
         (  
            '7fa8282ad93047'
         ) 
     
     
     
      AND temp2 = 1\G

# Query 14: 1.04 QPS, 0x concurrency, ID 0xE4CF7146873CCC28 at byte 14324245
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:47
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          0     316
# Exec time      0       0       0       0       0       0       0       0
# Query size     0   9.88k      32      32      32      32       0      32
# String:
# Databases    mysql (315/99%), authct_tok... (1/0%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
SET character_set_results = NULL\G

# Query 15: 1.04 QPS, 0x concurrency, ID 0xE795E438F52CEF3A at byte 14324195
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:47
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          0     316
# Exec time      0       0       0       0       0       0       0       0
# Query size     0   8.33k      27      27      27      27       0      27
# String:
# Databases    mysql (315/99%), authct_tok... (1/0%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
# EXPLAIN /*!50100 PARTITIONS*/
SELECT @@session.autocommit\G

# Query 16: 1.00 QPS, 0x concurrency, ID 0xAD312D56C6B3D880 at byte 14324150
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:47
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          0     305
# Exec time      0       0       0       0       0       0       0       0
# Query size     0   8.94k      30      30      30      30       0      30
# String:
# Databases    mysql
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
SET SESSION  wait_timeout=1800\G

# Query 17: 1.00 QPS, 0x concurrency, ID 0x5E7B7A2B492F56AC at byte 14323999
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:47
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          0     305
# Exec time      0       0       0       0       0       0       0       0
# Query size     0  25.32k      85      85      85      85       0      85
# String:
# Databases    mysql
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
SET SESSION sql_mode='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION,NO_AUTO_CREATE_USER'\G

# Query 18: 1 QPS, 0x concurrency, ID 0xF0265D81808CE240 at byte 14324322
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:47
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          0     304
# Exec time      0       0       0       0       0       0       0       0
# Query size     0   7.42k      25      25      25      25       0      25
# String:
# Databases    mysql
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
# EXPLAIN /*!50100 PARTITIONS*/
SELECT @@session.sql_mode\G

# Query 19: 0.82 QPS, 0x concurrency, ID 0x49E4A5290E7E796D at byte 14344374
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:43 to 15:32:48
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          0     251
# Exec time      0       0       0       0       0       0       0       0
# Query size     0  88.00k     359     359     359     359       0     359
# String:
# Databases    mysql (247/98%), authct_tok... (4/1%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
# Tables
#    SHOW TABLE STATUS FROM `mysql` LIKE 'token_0'\G
#    SHOW CREATE TABLE `mysql`.`token_0`\G
#    SHOW TABLE STATUS FROM `mysql` LIKE 'token_nonce_0'\G
#    SHOW CREATE TABLE `mysql`.`token_nonce_0`\G
# EXPLAIN /*!50100 PARTITIONS*/
SELECT t.* /*!99999 token.selectValidListHasNonceByTokenKey */
    FROM `token_0` t, `token_nonce_0` n
    WHERE t.user_hash = (
    SELECT user_hash
    FROM `token_0`
    WHERE token_key='91eRvfIzBPcVhwm6o7n0' AND cancel_status IS NULL LIMIT 1
    )
    AND t.cancel_status IS NULL
    AND t.token_key = n.token_key
    AND n.expired > '2016-12-28 15:32:48'\G

# Query 20: 0.41 QPS, 0x concurrency, ID 0xAB5577DB6446DA03 at byte 14287840
# This item is included in the report because it matches --limit.
# Scores: V/M = 0.00
# Time range: 2016-12-28 15:27:46 to 15:32:46
# Attribute    pct   total     min     max     avg     95%  stddev  median
# ============ === ======= ======= ======= ======= ======= ======= =======
# Count          0     122
# Exec time      0       0       0       0       0       0       0       0
# Query size     0   4.17k      35      35      35      35       0      35
# String:
# Databases    mysql (120/98%), authct_tok... (2/1%)
# Query_time distribution
#   1us
#  10us
# 100us
#   1ms
#  10ms
# 100ms
#    1s
#  10s+
# Tables
#    SHOW TABLE STATUS FROM `mysql` LIKE 'mmm'\G
#    SHOW CREATE TABLE `mysql`.`mmm`\G
UPDATE mysql.mmm SET lasttime=now()\G
# Converted for EXPLAIN
# EXPLAIN /*!50100 PARTITIONS*/
select  lasttime=now() from mysql.mmm \G
;