name: _rdata_txtdata_valid
description: Rdata txt-data valid

parameters:
 - name: p_txtdata
   type: varchar[]

returns: bool

body: |
 RETURN ((
    SELECT DISTINCT TRUE
        FROM UNNEST(p_txtdata) AS s
        WHERE octet_length(s) > 255
 ) IS NULL);
