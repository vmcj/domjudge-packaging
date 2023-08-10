#!/bin/sh
set -e

useradd -m domjudge || adduser -D domjudge
chown -R domjudge: /opt/domjudge

chmod 755 /scripts/start.sh
for script in /scripts/bin/*
do
	if [ -f "$script" ]
	then
		chmod 755 "$script"
		ln -s "$script" /usr/bin/
	fi
done
