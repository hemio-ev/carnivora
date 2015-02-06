templates:
 - user.userlogin

name: sel_mailbox
description: List all mailboxes


returns: TABLE
returns_columns:
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
   t.domain, 
   t.local_part, 
   t.owner, 
   t.quota, 
   t.backend_job
  FROM
   email.mailbox AS t
  WHERE
   t.owner = v_owner;
