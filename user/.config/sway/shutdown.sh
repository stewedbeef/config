#/usr/bin/bash

notify-send --transient --expire-time=5000 --urgency=critical \
	System 'Shutting down in five seconds'

swaymsg exit &

# Flush everything now
sync

# The WiFi card is finicky, give nmcli some time to send its shutdown message
# through the driver to the card
nmcli networking off
bluetoothctl power off
systemctl --user stop wireplumber.service pipewire.service
sleep 1

swaymsg [tiling_window] kill
sleep 2

case "$1"
	'poweroff')
		# Tell systemd that we should poweroff now
		dbus-send --system --print-reply \
			--dest=org.freedesktop.login1 /org/freedesktop/login1 \
			org.freedesktop.login1.Manager.PowerOff boolean:true
		;;
	'restart')
		dbus-send --system --print-reply \
			--dest=org.freedesktop.login1 /org/freedesktop/login1 \
			org.freedesktop.login1.Manager.Reboot boolean:true
esac
