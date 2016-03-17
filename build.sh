#!/bin/bash

echo "-Building deployables"

export BUILD_LOGFILE="../build.log"

echo "-- Building Rules_CEP deployable"
pushd . > /dev/null
cd Rules_CEP
mvn clean install >>  $BUILD_LOGFILE
popd > /dev/null

echo "-- Builing Smart_Gateway deployable"
pushd . > /dev/null
cd Smart_Gateway
mvn clean install >>  $BUILD_LOGFILE
popd > /dev/null

echo "-Building all images for the Smart_Gateway"
echo "-- Building Base Image"
pushd .
cd Base
docker build --rm -t psteiner/base .
popd

echo "-- Building Fuse Image"
pushd .
cd Fuse
docker build --rm -t psteiner/fuse .
popd

echo "-- Building docker-compose based images"
docker-compose build
