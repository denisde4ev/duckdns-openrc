=========
 duckdns
=========

---------------------------------------------
A DuckDNS ip updater program
---------------------------------------------

:Author: <<??>>
:Date:   <<??>>
:Copyright: GPLv3
:Version: <<??>>
:Manual section: 1
:Manual group: network tools


SYNOPSIS
========

``duckdns``

DESCRIPTION
===========

DuckDNS is a free service which will point a DNS (sub domains of duckdns.org)
to an IP of your choice

When you run ``duckdns`` without options it will read the default
configuration files in ``/etc/duckdns.d/*.conf`` and then it will update
the ip's associated.

You must add a conf file for every domain registered in duckdns.org. For example:

::

        $ cat /etc/duckdns.d/example.conf
        duckdns_domain=example
        duckdns_token=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX

Every configuration file in ``/etc/duckdns.d/`` must end in ``.conf``.
