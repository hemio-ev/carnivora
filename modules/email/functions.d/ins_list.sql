name: ins_list
description: |
 Creates a mailing list

returns: void

templates:
 - user.userlogin

parameters:
 -
  name: p_localpart
  type: email.t_localpart 
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_admin
  type: email.t_address

variables:
 -
  name: v_num_total
  type: int
 -
  name: v_num_domain
  type: int

body: |

    v_num_total := (SELECT COUNT(*) FROM email.list AS t WHERE t.owner=v_owner);
    v_num_domain := (SELECT COUNT(*) FROM email.list AS t WHERE t.owner=v_owner AND t.domain = p_domain);

    PERFORM "user"._contingent_exceeded(
        p_user:=v_owner,
        p_domain:=p_domain, 
        p_service:='email__list',
        p_current_quantity_total:=v_num_total,
        p_current_quantity_domain:=v_num_domain);

    PERFORM email._address_valid(p_localpart, p_domain);

    INSERT INTO email.list
        (localpart, domain, owner, admin) VALUES
        (p_localpart, p_domain, v_owner, p_admin);

    PERFORM backend._notify('email__list', p_domain);
