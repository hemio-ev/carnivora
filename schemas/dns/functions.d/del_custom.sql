---
name: del_custom
description: Delete Custom

templates:
 - user.userlogin

parameters:
 -
  name: p_id
  type: uuid

returns: void

variables:
 -
  name: v_nameserver
  type: dns.t_hostname
 -
  name: v_managed
  type: commons.t_key
---

UPDATE dns.custom AS t
       SET backend_status = 'del'
FROM dns.registered AS s
WHERE
    s.domain = t.registered AND

    t.id = p_id AND
    s.owner = v_owner

RETURNING s.service_entity_name, s.subservice
INTO v_nameserver, v_managed;

PERFORM backend._conditional_notify_service_entity_name(
    FOUND, v_nameserver, 'dns', v_managed
);
