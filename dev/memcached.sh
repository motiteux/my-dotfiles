#!/bin/bash
#
# Init file for memcached
#
# Written by Dag Wieërs <dag@wieers.com>
#
# chkconfig: - 80 12
# description: Distributed memory caching daemon
#
# processname: memcached
# config: /etc/sysconfig/memcached
# config: /etc/memcached.conf

source /etc/rc.d/init.d/functions

### Default variables
PORT="11211"
USER="nobody"
MAXCONN="1024"
CACHESIZE="64"
OPTIONS=""

#SYSCONFIG="/etc/sysconfig/memcached"
### Read configuration
#[ -r "$SYSCONFIG" ] && source "$SYSCONFIG"

# multiple instances mode
# each instance need dedicated
# /etc/sysconfig/memcached_PID config file
FILES=(/etc/sysconfig/memcached_*);
# check for alternative config schema
if [ -r "${FILES[0]}" ]; then
    CONFIGS=();
    for FILE in "${FILES[@]}";
    do
        # remove prefix
        #echo "${FILE} ==> file"
        NAME=${FILE#/etc/sysconfig/};
        # check optional second param
        if [ $# -ne 2 ];
        then
          # add to config array
          CONFIGS+=($NAME);
        elif [ "$2" == "$NAME" ];
        then
          # use only one memcached
          CONFIGS=($NAME);
          break;
        fi;
    done;
  if [ ${#CONFIGS[@]} == 0 ];
  then
    echo "Config not exist for: $2" >&2;
    exit 1;
  fi;
else
  CONFIGS=(memcached);
fi;

CONFIG_NUM=${#CONFIGS[@]};
for ((i=0; i < $CONFIG_NUM; i++)); do
  NAME=${CONFIGS[${i}]};
  PIDFILE="/var/run/memcached/${NAME}.pid";
  #echo "LOOP \"$CONFIG_NUM\""
  #echo "config ==> ${NAME}"
  #echo "$PIDFILE ==> PID"

##

RETVAL=0
#prog="memcached"
#prog_path="/usr/local/bin/$prog"
prog="${NAME}"
source "/etc/sysconfig/${NAME}"
desc="Distributed memory caching"

start() {
	echo -n $"Starting $desc ($prog) - $NAMED: "
	daemon --pidfile $PIDFILE memcached -P $PIDFILE -d -p $PORT -u $USER -c $MAXCONN -m $CACHESIZE $OPTIONS
    #daemon $prog -d -p $PORT -u $USER -c $MAXCONN -m $CACHESIZE $OPTIONS
	RETVAL=$?
	echo
	[ $RETVAL -eq 0 ] && touch /var/lock/subsys/$prog
	return $RETVAL;
}

stop() {
	echo -n $"Shutting down $desc ($prog) - $NAMED: "
	killproc -p $PIDFILE memcached
	RETVAL=$?
	echo
	[ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/$prog
	return $RETVAL
}

restart() {
	stop
	start
}

reload() {
	echo -n $"Reloading $desc ($prog) - $NAMED: "
	killproc $prog -HUP
	RETVAL=$?
	echo
	return $RETVAL
}

case "$1" in
  start)
	start
	;;
  stop)
	stop
	;;
  restart)
	restart
	;;
  condrestart)
	[ -e /var/lock/subsys/$prog ] && restart
	RETVAL=$?
	;;
  reload)
	reload
	;;
  status)
	status -p $PIDFILE $prog
	RETVAL=$?
	;;
   *)
	echo $"Usage: $0 {start|stop|restart|condrestart|status} $prog  > For $NAMED"
	RETVAL=1
esac

#exit $RETVAL
done
