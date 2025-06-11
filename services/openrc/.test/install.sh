#!/bin/sh

echo exit 123, TODO in openrc install
# TODO
exit 123

# consider using BASH_SOURCE=

OPENRC_DEST="/etc/init.d/$EXECUTABLE_NAME"


{ # prepare()
# TODO:!!! edit in, command and other path probably
```
#!/sbin/openrc-run

command="${PREFIX}/bin/duckdns"
command_args=""
pidfile="/run/duckdns.pid"
command_background="yes"
name="DuckDNS Updater"

depend() {
    need net
}
```
	# AI:
	##sed "s|^command=.*|command=\"$PREFIX/bin/$EXECUTABLE_NAME\"|" "services/openrc/$EXECUTABLE_NAME" > "$OPENRC_DEST"
	case $PREFIX in /usr) ;; *)
		sed -i "s|^command=.*|command=\"$PREFIX/bin/$EXECUTABLE_NAME\"|" "/etc/init.d/$EXECUTABLE_NAME"
	esac
}


ln -sf "/usr/local/etc/init.d/$EXECUTABLE_NAME" "/etc/init.d/$EXECUTABLE_NAME"

install -Dm755 "services/openrc/$EXECUTABLE_NAME"      "/etc/init.d/$EXECUTABLE_NAME"
sed -i "s|\${PREFIX}|$PREFIX|" "/etc/init.d/$EXECUTABLE_NAME"
# install -Dm644 "services/openrc/$EXECUTABLE_NAME.conf" "/etc/conf.d/$EXECUTABLE_NAME"



