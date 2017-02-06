


SELECT /*!99999 nonce.selectOne */ *
    FROM `token_nonce_2`
    WHERE token_key = 'EcQU38UcXwyGUbuq8Ba2'\G

SELECT /*!99999 token.selectValidOne */ *
    FROM `token_2`
    WHERE token_key = 'Ec5Dm9PP8Pb5KsjlmA52' AND cancel_status IS NULL
    ORDER BY issued DESC
    LIMIT 1\G

INSERT IGNORE INTO /*!99999 token.insertIgnore */ `token_2`
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

SELECT /*!99999 token.selectValidListBySearch */ *
    FROM `token_2`
    WHERE
    user_hash = 'abf5451957ad7e0d91707ae8b1460ee2'
    AND cancel_status IS NULL
     
      AND consumer_key in
         (  
            'awi4t3ljhfzilgj'
         )\G

UPDATE /*!99999 token.updateCancelStatusInUserHashShard */ `token_3`
    cancel_status = 'DL',
    updated = '2016-12-28 15:32:48'
    WHERE token_key = '97blFs6qNPhhnh6Wmcw3'\G
select 
    cancel_status = 'DL',
    updated = '2016-12-28 15:32:48' from /*!99999 token.updateCancelStatusInUserHashShard */ `token_3` where  token_key = '97blFs6qNPhhnh6Wmcw3'\G

SELECT /*!99999 token.selectValidListBySearch */ *
    FROM `token_3`
    WHERE
    user_hash = '896989ba5cd2e20bcea893a7bd8c1d13'
    AND cancel_status IS NULL\G

INSERT IGNORE INTO /*!99999 nonce.insertIgnore */ `token_nonce_2`
    token_key = 'Ec5Dm9PP8Pb5KsjlmA52',
    nonce = 1482906768307,
    expired = '2016-12-30 15:32:48',
    created = '2016-12-28 15:32:48',
    updated = '2016-12-28 15:32:48'\G

DELETE /*!99999 nonce.delete */
    FROM `token_nonce_2`
    WHERE token_key = 'Ec4lm3OEAlZhQFVhKMW2'\G
select * from  `token_nonce_2`
    WHERE token_key = 'Ec4lm3OEAlZhQFVhKMW2'\G



UPDATE /*!99999 nonce.update */ `token_nonce_1`
    nonce = 1482906767966,
    expired = '2016-12-30 15:32:47',
    updated = '2016-12-28 15:32:47'
    WHERE
    token_key = 'EcR6kqW6oL53mzbrmJ21' AND nonce = 1482819493360\G
select 
    nonce = 1482906767966,
    expired = '2016-12-30 15:32:47',
    updated = '2016-12-28 15:32:47' from /*!99999 nonce.update */ `token_nonce_1` where 
    token_key = 'EcR6kqW6oL53mzbrmJ21' AND nonce = 1482819493360\G


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


SELECT @@session.autocommit\G



SELECT @@session.sql_mode\G

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

UPDATE mysql.mmm SET lasttime=now()\G
select  lasttime=now() from mysql.mmm \G
