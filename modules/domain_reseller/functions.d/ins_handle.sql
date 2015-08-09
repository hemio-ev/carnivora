name: ins_handle
description: Insert Handle

templates:
 - user.userlogin

returns: void

parameters:
# internal
 -
  name: p_alias
  type: varchar
 -
  name: p_service_entity_name
  type: dns.t_domain

# mandatory fields
 -
  name: p_fname
  type: varchar
 -
  name: p_lname
  type: varchar
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

    INSERT INTO domain_reseller.handle
    (
      service_entity_name,
      service,
      subservice,
      owner,
      alias,
      fname,
      lname,
      address,
      pcode,
      city,
      country,
      state,
      email,
      phone,
      fax,
      mobile_phone
    )
    VALUES
    (
      p_service_entity_name,
      'domain_reseller',
      'handle',
      v_owner,
      p_alias,
      p_fname,
      p_lname,
      p_address,
      p_pcode,
      p_city,
      p_country,
      p_state,
      p_email,
      p_phone,
      p_fax,
      p_mobile_phone
    );