SYSTEMD
=======

A systemd timer was provided for execute in daemon mode. Just start
and enable ``duckdns.timer``.

By default every 5 minutes the ip's will be update in server. You can change
such frecuency editing ``OnUnitActiveSec`` value with:

::

        systemctl edit duckdns.timer

FILES
=====

**/usr/bin/duckdns**
    The executable script executed by service.

**/usr/lib/systemd/system/duckdns.service**
    The service associated to timer.

**/usr/lib/systemd/system/duckdns.timer**
    The systemd timer.

**/etc/duckdns.d/default.conf**
   Example configuration file with empty fields. Edit at convenience or remove
   it.

BUGS
====

Probably. If you found any let me know, please.


SEE ALSO
========

systemd.unit(5) systemd.timer(5)
