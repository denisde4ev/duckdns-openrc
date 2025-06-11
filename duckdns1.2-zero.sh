#!/bin/sh -x

current=''
while :; do

	#latest=$(curl -s ipinfo.io/ip) # publick ip
	latest=$(ip r g 1) # local ip
	case "$current" in "$latest");; *)

current=$latest
for file in ${DUCKDNS_CONFIGDIR-/etc}/duckdns.d/*.conf
do case $( . "${file}"; printf %s url="https://www.duckdns.org/update?domains=${duckdns_domain:-${DOMAIN:?}}&token=${duckdns_token:-${TOKEN:?}}&ip=$(printf %s "$1" | sed -nEe 's/.* src ([^ ]*).*/\1/p')" | curl -k -K - || echo >&2 "curl($?)" ) in OK) ;; *) echo err response; esac
done


	esac

sleep 5m; done
