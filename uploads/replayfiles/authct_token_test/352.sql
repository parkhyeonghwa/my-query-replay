

SELECT /*!99999 token.selectValidListBySearch */ *
    FROM `token_2`
    WHERE
    user_hash = 'abf5451957ad7e0d91707ae8b1460ee2'
    AND cancel_status IS NULL
     
      AND consumer_key in
         (  
            'awi4t3ljhfzilgj'
         );