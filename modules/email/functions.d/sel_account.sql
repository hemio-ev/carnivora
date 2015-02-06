templates:
 - user.userlogin

name: sel_account
description: List all accounts


return: TABLE
return_columns:
 -
  name: domain
  type: dns.t_domain
 -
  name: local_part
  type: email.t_local_part
 -
  name: owner
  type: commons.t_key
 -
  name: quota
  type: int
 -
  name: backend_job
  type: varchar(20)

body: |
 RETURN QUERY
  SELECT
   acc.domain, 
   acc.local_part, 
   acc.owner, 
   acc.quota, 
   acc.backend_job
  FROM
   email.account AS acc
  WHERE
   acc.owner = v_owner;
