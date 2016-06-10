#!/bin/bash
#
# Little helper for the installation of Red Hat JBoss Fuse in a Docker container
#
# tdeborge:
# Changing the sript to handle 2 situations in order to avoid the 5 minute wait:
# 1. Find out when the Fuse instance is running (so we can start the client session)
# 2. Implement time-outs and re-tries on the client session creation (until fuse is accepting sesssions)

# echo "Building deployables"
# mvn clean install

echo "Start Fuse and wait for start procedure to end"
$HOME/$FUSE_LOCATION/bin/start

while [ "`$HOME/$FUSE_LOCATION/bin/status`" != "Running ..." ]
do
echo 'Fuse not available ... waiting 5 seconds'
sleep 5
done

echo "Now let's deploy some prereq bundles"
echo "commons-dbcp"
$HOME/$FUSE_LOCATION/bin/client -h 127.0.0.1 -r 60 -d 10 "osgi:install -s wrap:mvn:commons-dbcp/commons-dbcp/1.4"
echo "camel-mqtt"
$HOME/$FUSE_LOCATION/bin/client -h 127.0.0.1 -r 60 -d 10 "features:install camel-mqtt"

echo "Installation Finished"


#$HOME/$FUSE_LOCATION/bin/status
#while [ "$?" != "0" ]
#do
#   echo "."
#   sleep 10
#   $HOME/$FUSE_LOCATION/bin/status
#done

#echo "waiting for 5 minutes, until I found a more clever way to check if Fuse is running"

#sleep 300

#echo "Now let's deploy some prereq bundles"
#echo "commons-dbcp"
#$HOME/$FUSE_LOCATION/bin/client -h 127.0.0.1 "osgi:install -s wrap:mvn:commons-dbcp/commons-dbcp/1.4"
#echo "camel-mqtt"
#$HOME/$FUSE_LOCATION/bin/client -h 127.0.0.1 "features:install camel-mqtt"
