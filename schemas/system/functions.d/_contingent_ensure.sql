---
name: _contingent_ensure
description: |
 Throws exceptions if the contingent is exceeded

returns: void

parameters:
 -
  name: p_owner
  type: user.t_user
 -
  name: p_service
  type: commons.t_key
 -
  name: p_subservice
  type: commons.t_key
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_current_quantity_total
  type: integer
 -
  name: p_current_quantity_domain
  type: integer

variables:
 -
  name: v_remaining
  type: integer
 -
  name: v_total_contingent
  type: integer
 -
  name: v_domain_contingent
  type: integer
 -
  name: v_domain_contingent_default
  type: integer
 -
  name: v_domain_contingent_specific
  type: integer
 -
  name: v_service_entity_name
  type: dns.t_domain
 -
  name: v_domain_owner
  type: user.t_user
---

IF p_owner IS NULL
THEN
    RAISE 'Owner argument must not be NULL.';
END IF;

SELECT
    t.service_entity_name,
    s.owner
INTO
    v_service_entity_name,
    v_domain_owner
FROM dns.service AS t
JOIN dns.registered AS s
    ON s.domain = t.registered

WHERE
    t.domain = p_domain AND
    t.service = p_service;

-- check dns.service entry
IF v_domain_owner IS NULL
THEN
    RAISE 'Contingent check impossible, since dns.service entry missing.'
        USING
            DETAIL = '$carnivora:system:no_contingent$',
            HINT = (p_owner, p_service, p_domain);
END IF;

SELECT domain_contingent, total_contingent
    INTO v_domain_contingent_default, v_total_contingent
FROM system._effective_contingent()
WHERE
    service = p_service AND
    subservice = p_subservice AND
    service_entity_name = v_service_entity_name AND
    owner = p_owner
;

SELECT domain_contingent
    INTO v_domain_contingent_specific
FROM system._effective_contingent_domain()
WHERE
    service = p_service AND
    subservice = p_subservice AND
    service_entity_name = v_service_entity_name AND
    owner = p_owner
;

v_domain_contingent :=
    COALESCE(v_domain_contingent_default, v_domain_contingent_specific);

IF
    v_total_contingent IS NULL AND
    v_domain_contingent IS NULL
THEN
    RAISE 'You do no have a contingent'
        USING
            DETAIL = '$carnivora:system:no_contingent$',
            HINT = (p_owner, p_service, v_service_entity_name);
END IF;

IF v_domain_contingent IS NULL AND p_owner <> v_domain_owner
THEN
    RAISE 'You are not the owner of the registered domain'
        USING
            DETAIL = '$carnivora:system:contingent_not_owner$',
            HINT = (p_owner, p_service, v_service_entity_name);
END IF;

IF v_total_contingent <= p_current_quantity_total
THEN
    RAISE 'Total contingent exceeded'
        USING
            DETAIL = '$carnivora:system:contingent_total_exceeded$',
            HINT = (p_owner, p_service, p_domain, v_total_contingent);
END IF;

IF v_domain_contingent <= p_current_quantity_domain
THEN
    RAISE 'Domain contingent exceeded'
        USING
            DETAIL = '$carnivora:system:contingent_domain_exceeded$',
            HINT = (p_owner, p_service, p_domain, v_domain_contingent);
END IF;
