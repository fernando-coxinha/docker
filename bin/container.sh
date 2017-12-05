#!/bin/bash
if [ "$1" = "--start" ]; then
    echo "-------------------------------------------------"
    echo "Start Container.."
    echo "-------------------------------------------------"
    docker container start $2
    docker ps -a
fi

if [ "$1" = "--stop" ]; then
    echo "-------------------------------------------------"
    echo "Stop Container.."
    echo "-------------------------------------------------"
    docker container stop $2
    docker ps -a
fi

if [ "$1" = "--new" ]; then
    echo "-------------------------------------------------"
    echo "New Branch.. Container.."
    echo "-------------------------------------------------"
    docker container exec \
    -e hyNewBranch="y" \
    -e hysAntCleanAll="y" -it $2 sh hybris-wrapper.sh
fi

if [ "$1" = "--properties" ]; then
    echo "-------------------------------------------------"
    echo "Copy Files Properties and Extensions.. Container.."
    echo "-------------------------------------------------"
    docker container exec \
    -e hyCopyLocal="y" -it $2 sh hybris-wrapper.sh
fi

if [ "$1" = "--init" ]; then
    echo "-------------------------------------------------"
    echo "Init.. Container.."
    echo "-------------------------------------------------"
    docker container exec \
    -e hyInit="y" -it $2 sh hybris-wrapper.sh
fi

if [ "$1" = "--init-system" ]; then
    echo "-------------------------------------------------"
    echo "Init System.. Container.."
    echo "-------------------------------------------------"
    docker container exec \
    -e hyInitSystem="y" -it $2 sh hybris-wrapper.sh
fi

if [ "$1" = "--clear" ]; then
    echo "-------------------------------------------------"
    echo "Ant Clear All.. Container.."
    echo "-------------------------------------------------"
    docker container exec \
    -e hysAntCleanAll="y" -it $2 sh hybris-wrapper.sh
fi

if [ "$1" = "--server-debug" ]; then
    echo "-------------------------------------------------"
    echo "Server Debug.. Container.."
    echo "-------------------------------------------------"
    docker container exec \
    -e hysServerDebug="y" -it $2 sh hybris-wrapper.sh
fi

if [ "$1" = "--server" ]; then
    echo "-------------------------------------------------"
    echo "Server.. Container.."
    echo "-------------------------------------------------"
    docker container exec \
    -e hysServer="y" -it $2 sh hybris-wrapper.sh
fi

if [ "$1" = "--run" ]; then
    echo "-------------------------------------------------"
    echo "Front-end Run Commands.. Container.."
    echo "-------------------------------------------------"
    docker container exec -it $2 $3
fi

if [ "$1" = "--upgrade-hybris" ]; then
    echo "-------------------------------------------------"
    echo "Upgrade Resources ..${2}.. Container.."
    echo "-------------------------------------------------"
    docker container update --cpus="4" --kernel-memory=2g --memory=5g --memory-swap=5g $2
    docker container restart $2
fi

if [ "$1" = "--upgrade-front" ]; then
    echo "-------------------------------------------------"
    echo "Upgrade Resources ..${2}.. Container.."
    echo "-------------------------------------------------"
    docker container update --cpus="1" --memory=512m --memory-swap=512m $2
    docker container restart $2
fi

if [ "$1" = "--upgrade-mock" ]; then
    echo "-------------------------------------------------"
    echo "Upgrade Resources ..${2}.. Container.."
    echo "-------------------------------------------------"
    docker container update --memory=512m --memory-swap=512m $2
    docker container restart $2
fi

if [ "$1" = "--proxy" ]; then
    echo "-------------------------------------------------"
    echo "Configuration Proxy ..${2}.. Container.."
    echo "-------------------------------------------------"
    docker container exec -it $2 'printenv'

    docker container exec -it $2 sh -c echo 'export HTTP_PROXY=${4}'
    #docker container exec -it $2 'export HTTP_PROXY=${4}'

    if [ "$1" = "--proxy" ]; then
        echo "...Configuration Proxy in NODE.JS ..${2}"
        #docker container exec -it $2 'npm config set proxy ${3}'
        #docker container exec -it $2 'npm config set https-proxy ${4}'
    fi
fi

