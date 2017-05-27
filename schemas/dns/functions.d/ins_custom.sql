---
name: ins_custom
description: Ins Custom

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_registered
  type: dns.t_hostname
 -
  name: p_domain
  type: dns.t_hostname
 -
  name: p_type
  type: dns.t_type
 -
  name: p_rdata
  type: dns.t_rdata
 -
  name: p_ttl
  type: integer

variables:
 -
  name: v_nameserver
  type: dns.t_hostname
 -
  name: v_managed
  type: commons.t_key
---

SELECT service_entity_name, subservice INTO v_nameserver, v_managed FROM dns.registered
WHERE
    domain = p_registered AND
    owner = v_owner;

IF v_nameserver IS NULL THEN
    PERFORM commons._raise_inaccessible_or_missing();
END IF;

IF v_nameserver IS NULL THEN
    PERFORM commons._raise_inaccessible_or_missing();
END IF;

INSERT INTO dns.custom
(registered, domain, type, rdata, ttl)
VALUES
(p_registered, p_domain, p_type, p_rdata, p_ttl);

PERFORM backend._notify_service_entity_name(v_nameserver, 'dns', v_managed);
