#!/bin/sh

TOKEN='abc-123-abc-123'
DOMAINS='exampledomain'

HOST="www.duckdns.org"
PORT="80"

# MAKE THE REQUEST PATTERN - remove the Verbose if you want to
URI=$(echo /update?domains=$DOMAINS\&token=$TOKEN\&ip=\&verbose=true)

# BUILD FULL HTTP REQUEST - note extra \ at the end to ignore editor and OS carraige returns
HTTP_QUERY="GET $URI HTTP/1.1\r\n\
Host: $HOST\r\n\
Accept: text/html\r\n\
Connection: close\r\n\
\r\n"

# OUTPUT TO SCREEN - Nice for Debug
echo "$HTTP_QUERY"
(printf "$HTTP_QUERY" && sleep 5) | nc $HOST $PORT
