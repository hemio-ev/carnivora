\set v_cert '''' `xxd -p 1.der` ''''
SELECT * FROM (SELECT * FROM ssl.cert_request_info(decode(:v_cert, 'hex'))) AS x
