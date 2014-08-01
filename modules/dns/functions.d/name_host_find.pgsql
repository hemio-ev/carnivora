name: name_host_find
description: Find resource record using MX and name.

return: uuid
null: true

parameters:
 -
  name: p_name
  type: dns.domain_name
 -
  name: p_type
  type: dns.type

body: |
 RETURN ( 
     SELECT id FROM dns.name_host
        JOIN dns.name USING (id)
        WHERE dns.name.type = p_type AND dns.name.name = p_name
 );
