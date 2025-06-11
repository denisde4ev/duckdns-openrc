#!/usr/bin/env bash

EXITCODE=0

echo 'Updating DuckDNS entries...'

for file in ${DUCKDNS_CONFIGDIR-/etc}/duckdns.d/*.conf; do
	(
		source "${file}"
		printf %s\\n "Executing config file '${file}'..."
		#OUTPUT=$(curl -k -s "https://www.duckdns.org/update?domains=${duckdns_domain}&token=${duckdns_token}&ip=")

		## comment for easy copy test.
		# duckdns_domain=''
		# duckdns_token=''  TOKEN='ea0f8a33-5491-4ef1-bf48-3696f8990283'

		OUTPUT=$(
			curl --insecure --silent \
				--get "https://www.duckdns.org/update" \
				--data-urlencode "domains=${duckdns_domain}" \
				--data-urlencode "token=${duckdns_token}" \
				--data-urlencode "ip=" \
			;
		);

	)
	echo ${OUTPUT}

	case ${OUTPUT} in
		OK) ;;
		KO|*) EXITCODE=1;;
	fi
done


case $EXITCODE in
	0)   echo OK ;;
	1|*) echo KO ;;
esac

exit $EXITCODE
