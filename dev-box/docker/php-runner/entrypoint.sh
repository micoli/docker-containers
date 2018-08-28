#!/usr/bin/env bash
set -e

TIMEZONE=${TIMEZONE:=Europe/Paris}
DOCKER_TYPE=${DOCKER_TYPE:=runner}

#PHP Configuration
rm /etc/localtime
ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

echo $TIMEZONE > /etc/timezone
printf '[PHP]\ndate.timezone = "%s"\n', $TIMEZONE > /usr/local/etc/php/conf.d/tzone.ini

if [ "x$DOCKER_TYPE" = "xrunner" ] ; then
	php-fpm
fi
if [ "x$DOCKER_TYPE" = "xworker" ] ; then
	supervisord -n -c /etc/supervisor/supervisord.conf
fi
