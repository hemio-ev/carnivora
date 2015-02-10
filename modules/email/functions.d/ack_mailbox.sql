name: ack_mailbox
description: ACK

returns: void

body: |
    DELETE FROM email.mailbox WHERE backend_status='del';
    UPDATE email.mailbox SET backend_status=NULL;
