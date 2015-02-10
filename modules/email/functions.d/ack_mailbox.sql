name: ack_mailbox
description: ACK
templates:
 - backend.backend

returns: void

body: |
    DELETE FROM email.mailbox
        WHERE
            backend_status='del' AND
            backend._machine_priviledged(service, domain);
    
    UPDATE email.mailbox
    SET backend_status=NULL
        WHERE
            backend._machine_priviledged(service, domain);
