

SELECT /*!99999 token.selectValidOne */ *
    FROM `token_2`
    WHERE token_key = 'Ec5Dm9PP8Pb5KsjlmA52' AND cancel_status IS NULL
    ORDER BY issued DESC
    LIMIT 1;