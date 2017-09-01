#!/bin/bash
function shutdown()
{
    date
    echo "Shutting down Tomcat"
    $CATALINA_HOME/bin/catalina.sh stop
}

echo "Starting Tomcat"


. $CATALINA_HOME/bin/catalina.sh start


# Allow any signal which would kill a process to stop Tomcat
trap shutdown HUP INT QUIT ABRT KILL ALRM TERM TSTP

while [ ! -f $CATALINA_HOME/webapps/logs/geonetwork.log ]
do
  sleep 2
done
tail -f $CATALINA_HOME/webapps/logs/geonetwork.log


