#!/usr/bin/env bash
set -e

TIMEZONE=${TIMEZONE:=Europe/Paris}
DOCKER_TYPE=${DOCKER_TYPE:-$@}

#PHP Configuration
##rm /etc/localtime
##ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

##echo $TIMEZONE > /etc/timezone
##printf '[PHP]\ndate.timezone = "%s"\n', $TIMEZONE > /usr/local/etc/php/conf.d/tzone.ini
case "x-$DOCKER_TYPE" in
"x-")
	echo "noop"
	;;
"x-runner")
	echo "php fpm worker"
	php-fpm
	;;
"x-worker")
	echo "supervisor worker"
	supervisord -n -c /etc/supervisor/supervisord.conf
	;;
"x-shell")
	echo "Shell"
	/bin/bash
	;;
*)
    echo "not executing Custom command : [[[$DOCKER_TYPE]]]"
    exec $DOCKER_TYPE
    ;;
esac
