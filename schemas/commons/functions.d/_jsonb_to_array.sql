---
name: _jsonb_to_array
description: |
 Converts a JSONB array to a PostgreSQL text[] array

parameters:
 - name: p_jsonb
   type: jsonb

returns: text[]
---

RETURN ARRAY(SELECT jsonb_array_elements_text(p_jsonb));
