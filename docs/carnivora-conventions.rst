===============
API Conventions
===============

Function Naming
---------------

Prefix ``_``
    Internal functions which do not belong to API.

Frontend API
++++++++++++

Prefix ``del_``
    Delete object from database. Returns ``void``.

Prefix ``ins_``
    Insert object to database. Returns ``void``.

Prefix ``sel_``
    Gives all object for which the user has ownership. Returns a recordset that
    can be used as ``<table>`` in a ``SELECT ... FROM <table>`` statement.

Prefix ``upd_``
    Updates objects in database. Returns ``void``.

Backend API
+++++++++++

Prefix ``srv_``
    Gives all object designated to the connected machine. Returns a recordset.

Prefix ``fwd_``
    Forwards informations from a machine to carnivora. Similar to ``upd_`` but
    for backend.

Backend Notification Naming
---------------------------

Carnivora sents push notifications (usign the PostgreSQL ``NOTFIY`` command)
if objects are changed. Machines can connect to to channels that only give
notifications relevant to them.

Channel
    ``carnivora/`` *machine name*

Payload
    *service entity name* ``/`` *service* ``/`` *subservice*

    Example ``mail.example.org/mail/mailbox``.
    
    The emitted signals are
    documented in the schema description. The sevice entity name is silently
    omitted in those documentations.

