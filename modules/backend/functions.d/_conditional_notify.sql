name: _conditional_notify
description: Notifies if first argument is true. Throws inaccessible otherwise.

returns: void

parameters:
 -
  name: p_condition
  type: boolean
 -
  name: p_service
  type: system.t_service
 -
  name: p_domain
  type: dns.t_domain

body: |
    IF p_condition THEN
        PERFORM backend._notify(p_service, p_domain);
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;
