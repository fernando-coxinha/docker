#!/bin/sh
set -e

echo "-------------------------------------------------"
echo "Stopping all running containers.."
echo "-------------------------------------------------"

docker stop $(docker ps -a -q)


echo "-------------------------------------------------"
echo "Removing all containers.."
echo "-------------------------------------------------"

docker rm $(docker ps -q -a)