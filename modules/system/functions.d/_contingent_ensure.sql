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
  name: v_contingent_total
  type: integer
 -
  name: v_contingent_domain
  type: integer
 -
  name: v_service_entity_name
  type: dns.t_domain
 -
  name: v_the_owner
  type: user.t_user

body: |
    IF p_owner IS NULL
    THEN
        RAISE 'Owner argument must not be NULL.';
    END IF;

    SELECT
        t.service_entity_name,
        s.owner
    INTO v_service_entity_name, v_the_owner
    FROM dns.service AS t
    JOIN dns.registered AS s
        ON s.domain = t.registered

    WHERE
        t.domain = p_domain AND
        t.service = p_service;

    -- check dns.service entry
    IF v_the_owner IS NULL
    THEN
        RAISE 'Contingent check impossible, since dns.service entry missing.'
            USING
                DETAIL = '$carnivora:system:no_contingent$',
                HINT = (p_owner, p_service, p_domain);
    END IF;

    v_contingent_total := (
            SELECT system._contingent_total
                (
                    p_owner := p_owner,
                    p_service := p_service,
                    p_service_entity_name := v_service_entity_name
                )
        );

    v_contingent_domain := (
            SELECT system._contingent_domain
                (
                    p_owner := p_owner,
                    p_service := p_service,
                    p_service_entity_name := v_service_entity_name,
                    p_domain := p_domain
                )
        );

    IF
        v_contingent_total IS NULL AND
        v_contingent_domain IS NULL
    THEN
        RAISE 'You do no have a contingent'
            USING
                DETAIL = '$carnivora:system:no_contingent$',
                HINT = (p_owner, p_service, v_service_entity_name);
    END IF;

    IF v_contingent_domain IS NULL AND p_owner <> v_the_owner
    THEN
        RAISE 'You are not the owner of dns.service'
            USING
                DETAIL = '$carnivora:system:contingent_not_owner$',
                HINT = (p_owner, p_service, v_service_entity_name);
    END IF;

    IF v_contingent_total <= p_current_quantity_total
    THEN
        RAISE 'Total contingent exceeded'
            USING
                DETAIL = '$carnivora:system:contingent_total_exceeded$',
                HINT = (p_owner, p_service, p_domain, v_contingent_total);
    END IF;

    IF v_contingent_domain <= p_current_quantity_domain
    THEN
        RAISE 'Domain contingent exceeded'
            USING
                DETAIL = '$carnivora:system:contingent_domain_exceeded$',
                HINT = (p_owner, p_service, p_domain, v_contingent_domain);
    END IF;
