#!/bin/bash
#set -ev

if [ "$1" = "--proxy" ]; then
    echo "-------------------------------------------------"
    echo "Docker Machine - Proxy environment.."
    echo "-------------------------------------------------"
    docker-machine ssh $2 "sudo chmod -R 777 /var/lib/boot2docker/profile"
    sleep 1
    docker-machine ssh $2 "sudo /etc/init.d/docker restart"
    sleep 1
    echo "-------------------------------------------------"
    echo "Create Regenerate Certificates.."
    echo "-------------------------------------------------"
    yes | docker-machine regenerate-certs $2
fi

if [ "$1" = "--env" ]; then
    docker-machine env ${2}
    sleep 1
    eval $("C:\Program Files\Docker Toolbox\docker-machine.exe" env ${2})
fi