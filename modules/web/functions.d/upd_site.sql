name: upd_site
description: set https identif.

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_port
  type: commons.t_port
 -
  name: p_identifier
  type: commons.t_key

body: |

    UPDATE web.site AS t
        SET https = p_identifier
    FROM server_access.user AS s, dns.service AS u
    WHERE
        s.user = t.user AND
        s.service_entity_name = u.service_entity_name AND

        -- dns.service JOIN
        t.domain = u.domain AND
        t.service = u.service AND

        s.owner = v_owner AND
        t.domain = p_domain AND
        t.port = p_port;

    PERFORM backend._conditional_notify(FOUND, 'web', p_domain);
