#!/bin/sh
### BEGIN INIT INFO
# Provides:          isso
# Required-Start:    $local_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Description:       lightweight Disqus alternative
### END INIT INFO

EXEC=/usr/local/bin/isso
EXEC_OPTS="-c ./isso.cfg run"

RUNAS=root
PIDFILE=/var/run/isso.pid

start() {
    echo $EXEC
    echo $EXEC_OPTS
    echo 'Starting service…' >&2
    start-stop-daemon --start --background --make-pidfile --pidfile $PIDFILE \
		      --exec $EXEC -- $EXEC_OPTS
    echo $?
}

stop() {
    echo 'Stopping service…' >&2
    start-stop-daemon --stop --user "$RUNAS" --pidfile $PIDFILE --exec $EXEC
}

case "$1" in
    start)
	start
	;;
    stop)
	stop
	;;
    restart)
	stop
	start
	;;
    *)
	echo "Usage: $0 {start|stop|restart}"
	esac
