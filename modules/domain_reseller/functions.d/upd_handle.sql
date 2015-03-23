name: upd_handle
description: Update Handle

templates:
 - user.userlogin

returns: void

parameters:
# internal
 -
  name: p_alias
  type: varchar

# mandatory fields
 -
  name: p_address
  type: varchar
 -
  name: p_pcode
  type: varchar
 -
  name: p_city
  type: varchar
 -
  name: p_country
  type: varchar
 -
  name: p_state
  type: varchar
 -
  name: p_email
  type: email.t_address
 -
  name: p_phone
  type: varchar

# optional fields
 -
  name: p_fax
  type: varchar
 -
  name: p_mobile_phone
  type: varchar

body: |

    UPDATE domain_reseller.handle
        SET
            backend_status = 'upd',
            address = p_address,
            pcode = p_pcode,
            city = p_city,
            country = p_country,
            state = p_state,
            email = p_email,
            phone = p_phone,
            fax = p_fax,
            mobile_phone = p_mobile_phone

    WHERE
        alias = p_alias AND
        owner = v_owner;
  