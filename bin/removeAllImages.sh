#!/bin/sh
set -e

echo "-------------------------------------------------"
echo "Removing all images.."
echo "-------------------------------------------------"

docker rmi $(docker images -q)