name: srv_records
description: |
 Servers both record types combined: Raw entries and the ones assembled
 from records templates for services (system.service_entity_dns).

templates:
 - backend.backend

returns: TABLE
returns_columns:
 -
  name: registered
  type: dns.t_domain
 -
  name: domain
  type: dns.t_domain
 -
  name: type
  type: dns.t_type
 -
  name: rdata
  type: dns.t_rdata
 -
  name: ttl
  type: dns.t_ttl
 -
  name: backend_status
  type: backend.t_status

body: |

    RETURN QUERY
        WITH

        -- DELETE
        d_s AS (
            DELETE FROM dns.service AS t
            USING dns.registered AS s
            WHERE
                s.domain = t.registered AND
                backend._deleted(t.backend_status) AND
                backend._machine_priviledged_service('dns', s.service_entity_name)
        ),

        d_c AS (
            DELETE FROM dns.custom AS t
            USING dns.registered AS s
            WHERE
                s.domain = t.registered AND
                backend._deleted(t.backend_status) AND
                backend._machine_priviledged_service('dns', s.service_entity_name)
        ),

        -- UPDATE
        u_s AS (
            UPDATE dns.service AS t
                SET backend_status = NULL
            FROM dns.registered AS s
            WHERE
                s.domain = t.registered AND
                backend._machine_priviledged_service('dns', s.service_entity_name) AND
                backend._active(t.backend_status)
        ),

        u_c AS (
            UPDATE dns.custom AS t
                SET backend_status = NULL
            FROM dns.registered AS s
            WHERE
                s.domain = t.registered AND
                backend._machine_priviledged_service('dns', s.service_entity_name) AND
                backend._active(t.backend_status)
        )

        SELECT
            t.registered,
            COALESCE(s.domain_prefix || t.domain, t.domain)::dns.t_domain,
            s.type,
            s.rdata,
            s.ttl,
            t.backend_status
        FROM dns.service AS t
        JOIN system.service_entity_dns AS s
            USING (service, service_entity_name)
        JOIN dns.registered AS u
            ON t.registered = u.domain
        WHERE
            u.subservice = 'managed' AND
            backend._machine_priviledged_service('dns', u.service_entity_name) AND
            (backend._active(t.backend_status) OR p_include_inactive)

        UNION ALL

        SELECT
            t.registered,
            t.domain,
            t.type,
            t.rdata,
            t.ttl,
            t.backend_status
        FROM dns.custom AS t
        JOIN dns.registered AS u
            ON t.registered = u.domain
        WHERE
            u.subservice = 'managed' AND
            backend._machine_priviledged_service('dns', u.service_entity_name) AND
            (backend._active(t.backend_status) OR p_include_inactive)
        ;
