#!/bin/sh

duckdns_onipchange() {
	printf %s\\n "Updating DuckDNS entries..."

	for file in ${DUCKDNS_CONFIGDIR-/etc}/duckdns.d/*.conf; do
		printf %s\\n "Executing config file '${file}'..."

		curl_log=$(
			. "${file}"
			curl --insecure --silent \
				--get "https://www.duckdns.org/update" \
				--data-urlencode "domains=${duckdns_domain:-${DOMAIN:?}}" \
				--data-urlencode "token=${duckdns_token:-${TOKEN:?}}" \
				--data-urlencode "ip=${1?}" \
			;
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
		"$latest")
			printf %s\\n "ip not changed"
		;;
		*)
			current=$latest

			# or you can provide empty argument to `onchange` function if you want to set the publick ip that will access duckdns
			current_ip="${current}"
			current_ip="${current_ip#*src }"
			current_ip="${current_ip%% *}"

			duckdns_onipchange "${current_ip}"
		;;
	esac

	sleep 5m
done
