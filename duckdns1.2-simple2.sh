#!/bin/sh

duckdns_onipchane() {
	set -- $(printf %s "$1" | sed -nEe 's/.* src ([^ ]*).*/\1/p') # NOTE:! needed only if set by `ip r g 1` command
	printf %s\\n "Updating DuckDNS entries..."

	for file in ${DUCKDNS_CONFIGDIR-/etc}/duckdns.d/*.conf; do
		printf %s\\n "Executing config file '${file}'..."

		curl_log=$(
			. "${file}"
			printf %s url="https://www.duckdns.org/update?domains=${duckdns_domain:-${DOMAIN:?}}&token=${duckdns_token:-${TOKEN:?}}&ip=${1?}" | curl -k -K -
		)
		printf %s\\n "$curl_log"

		case "$curl_log" in
			OK) ;;
			KO|*) EXITCODE=1;;
		fi
	done

	return "$EXITCODE"
}


# based on https://www.duckdns.org/install.jsp?tab=ec2

current=''
while :; do
	#latest=$(curl -s ipinfo.io/ip) # publick ip
	latest=$(ip r g 1) # local ip

	case "$current" in
		"$latest") printf %s\\n "ip not changed" ;;
		*) current=$latest;  duckdns_onchange "${current_ip}";;
		# you can provide empty argument if you want to set the publick ip that will access duckdns
	esac

	sleep 5m
done
