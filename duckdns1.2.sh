#!/bin/sh

getip() {

	## for publick ip (0.0.0.0):
	# curl -s ipinfo.io/ip

	## for local IP (192.168...):
	ip r g 1

	# if CPU is powerful, substract every time:
	# ip route get 1 | grep -o "src [^ ]*" | cut-f 2
	# ip route get 1 | rg -o "src [^ ]*" | cut-f 2)
	# ip r g 1 | sed -ne 's/.* src \([^ ]*\).*/\1/p'




	# I got this from neofetch, and btr:
	# https://github.com/denisde4ev/shrc/blob/51f5f2d91dbcb17c4b539f5df6b21c42f3de0391/a#L155
	#  alias myip='(curl -s ipinfo.io/ip;echo)'
	# https://github.com/denisde4ev/bin/blob/master/192
	# https://github.com/denisde4ev/bin/blob/master/192-

}


duckdns_onipchange() {
	printf %s\\n "I: Detected new IP${1+='${1?}'}. Updating DuckDNS entries..."


	#EXITCODE=0

	for file in "${DUCKDNS_CONFIGDIR-/etc}"/duckdns.d/*.conf; do
		printf %s\\n "I: Executing config file '${file}'..."
		## comment for easy copy test.
		# duckdns_domain=''
		# duckdns_token=''

		curl_log=$(
			. "${file}"
			curl --insecure --silent \
				--get "https://www.duckdns.org/update" \
				--data-urlencode "domains=${duckdns_domain:-${DOMAIN:?}}" \
				--data-urlencode "token=${duckdns_token:-${TOKEN:?}}" \
				--data-urlencode "ip=${1?}" \
			;
		) || {
			printf %s\\n "E: curl ($?)"
			#EXITCODE=1
		}

		printf 'curl log: %s\n' ${curl_log:+"$curl_log"} # in most cases will have log

		#case "$curl_log" in
		#	OK) ;;
		#	KO|*) EXITCODE=1;;
		#fi

		echo
	done


	#return "$EXITCODE"
}



# based on https://www.duckdns.org/install.jsp?tab=ec2

current=''
while :; do
	latest=$(getip) || {
		printf %s\\n "W: failed to get current IP"
		case ${latest:+x} in x) printf 'log: %s\n' "${latest}"; esac
		sleep 5m
		continue
	}

	
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
