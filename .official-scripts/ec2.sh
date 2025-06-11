#!/bin/bash
current=""
while true; do
	latest=`ec2-metadata --public-ipv4`
	echo "public-ipv4=$latest"
	if [ "$current" == "$latest" ]
	then
		echo "ip not changed"
	else
		echo "ip has changed - updating"
		current=$latest
		echo url="https://www.duckdns.org/update?domains=exampledomain&token=abc-123-abc-123&ip=" | curl -k -o ~/duckdns/duck.log -K -
	fi
	sleep 5m
done
