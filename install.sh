#!/bin/sh -eux

. ./env.sh




install -v -Dm755 "$EXECUTABLE_NAME.sh" "$PREFIX/bin/$EXECUTABLE_NAME"
install -v -dm755                       "$SYSCONFDIR/$EXECUTABLE_NAME.d"
install -v -Dm644 "default.conf"        "$SYSCONFDIR/$EXECUTABLE_NAME.d/default.conf"

# man:
install -v -Dm644 "$EXECUTABLE_NAME.1.gz" "$PREFIX/share/man/man1/$EXECUTABLE_NAME.1.gz"

case $1 in
	--service-manager=systemd)
		# TODO:! check if this will work
		# where (DESTDIR=/usr/local)/lib/systemd
		install -Dm644 "services/systemd/$EXECUTABLE_NAME.service" "$DESTDIR/lib/systemd/system/$EXECUTABLE_NAME.service"
		install -Dm644 "services/systemd/$EXECUTABLE_NAME.timer"   "$DESTDIR/lib/systemd/system/$EXECUTABLE_NAME.timer"
	;;
	--service-manager=openrc)
		echo 'TODO:!!!' install openrc
		exit 123
	;;
esac
