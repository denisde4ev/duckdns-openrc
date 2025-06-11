#!/bin/sh -eux

. ./env.sh


rm -v -f "$PREFIX/local/bin/$EXECUTABLE_NAME"
rm -v -f "$SYSCONFDIR/$EXECUTABLE_NAME.d/default.conf"

case $1 in
	--service-manager=systemd)

		# TODO:! check if this will work
		rm -v -f "$PREFIX/lib/systemd/system/$EXECUTABLE_NAME.service"
		rm -v -f "$PREFIX/lib/systemd/system/$EXECUTABLE_NAME.timer"

	;;
	--service-manager=openrc)
		;
	;;
esac




case $1 in --full)
	rm -v -rf "/etc/$EXECUTABLE_NAME.d/"
esac
