#!/bin/sh -x

b=''
while :; do
	#a=$(curl -s ipinfo.io/ip) || echo >&2 "get ip, curl($?)" # publick ip
	a=$(ip r g 1) || echo >&2 "ip($?)" # local ip

	case "$a" in "$b");; *)
		b=$a
		for f in ${DUCKDNS_CONFIGDIR-/etc}/duckdns.d/*.conf; do (
			. "$f"
			printf %s url="https://www.duckdns.org/update?" \
				"domains=${duckdns_domain:-${DOMAIN:?}}&token=${duckdns_token:-${TOKEN:?}}&ip=" \
				"$( printf %s "$ip" | sed -ne 's/.* src \([^ ]*\).*/\1/p' )" | curl -k -K - || echo >&2 "curl($?)" \
			;
		) done

	esac

	sleep 5m
done
