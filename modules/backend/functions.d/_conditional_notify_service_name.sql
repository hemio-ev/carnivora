name: _conditional_notify_service_name
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
  name: p_service_name
  type: dns.t_domain

body: |
    IF p_condition THEN
        PERFORM backend._notify_service_name(p_service, p_service_name);
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;