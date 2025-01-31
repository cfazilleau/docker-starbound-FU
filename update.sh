#!/usr/bin/env bash


if [ -z "$1" ]; then
	echo "Please provide your steam login name as the first argument."
	exit
fi

if [ -z "$2" ]; then
	FRACKINUNIVERSE_VERSION=latest
else
	FRACKINUNIVERSE_VERSION=$2
fi

touch /.update


# Hack to remove cached auth details that stops the password prompt from appearing
if [ -f /root/Steam/config/config.vdf ]; then
	sed -i '/"ConnectCache"/,/}/d' /root/Steam/config/config.vdf
fi

PID=$(pidof "/starbound/linux/starbound_server")

if [ -n "$PID" ]; then
	kill "$PID"
fi

/steamcmd/steamcmd.sh \
	+login "$1" \
	+force_install_dir /starbound/ \
	+app_update 211820 validate \
	+quit \
	&& rm /.update

curl -L https://github.com/sayterdarkwynd/FrackinUniverse/releases/download/${FRACKINUNIVERSE_VERSION}/FrackinUniverse.pak -o /starbound/mods/FrackinUniverse.pak

exit

