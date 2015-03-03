name: ins_alias
description: Insert alias

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_site
  type: dns.t_domain

body: |

    INSERT INTO web.alias
    (domain, site, service_name)
    VALUES
    (p_domain, p_site,
        (SELECT service_name FROM web.site
        WHERE
            domain = p_site));

    PERFORM backend._notify('web', p_domain);
