---
name: _conditional_notify
description: Notifies if first argument is true. Throws inaccessible otherwise.

returns: void

parameters:
 -
  name: p_condition
  type: boolean
 -
  name: p_service
  type: commons.t_key
 -
  name: p_subservice
  type: commons.t_key
 -
  name: p_domain
  type: dns.t_domain
---

IF p_condition THEN
    PERFORM backend._notify_domain(p_service, p_subservice, p_domain);
ELSE
    PERFORM commons._raise_inaccessible_or_missing();
END IF;
