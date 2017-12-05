#!/bin/bash
if [ "$1" = "--create" ]; then
    echo "-------------------------------------------------"
    echo "Create machine.."
    echo "-------------------------------------------------"

    docker-machine create -d virtualbox \
            --virtualbox-disk-size 25000 \
            --virtualbox-memory 8048 \
            --virtualbox-cpu-count "5" $2

    echo "-------------------------------------------------"
    echo "Create Regenerate Certificates.."
    echo "-------------------------------------------------"
    yes | docker-machine regenerate-certs $2

    echo "-------------------------------------------------"
    echo "List of all machines.."
    echo "-------------------------------------------------"
    docker-machine ls

    docker-machine env $2

fi

if [ "$1" = "--start" ]; then
    echo "-------------------------------------------------"
    echo "Start machine.."
    echo "-------------------------------------------------"
    docker-machine start $2

    echo "-------------------------------------------------"
    echo "Create Regenerate Certificates.."
    echo "-------------------------------------------------"
    yes | docker-machine regenerate-certs $2

    echo "-------------------------------------------------"
    echo "List of all machines.."
    echo "-------------------------------------------------"
    docker-machine ls

    docker-machine env $2

fi

if [ "$1" = "--stop" ]; then
    echo "-------------------------------------------------"
    echo "Stop machine.."
    echo "-------------------------------------------------"
    docker-machine stop $2
fi