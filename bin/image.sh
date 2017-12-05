#!/bin/bash
export BRANCH=${4}
if [ ! "$(docker ps -q -f name=$1)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=$1)" ]; then
        ./bin/container.sh --stop $1
        docker rm $1
    fi
fi

echo "-------------------------------------------------"
echo "Create image.."
echo "-------------------------------------------------"
docker-compose build --force-rm --build-arg ARG_HTTP_PROXY=$2 --build-arg ARG_HTTPS_PROXY=$3 $1
sleep 2
docker rmi $(docker images -f "dangling=true" -q) -f
docker images
docker-compose up -d --remove-orphans $1
sleep 1
if [ "$1" = "hybris" ]; then
./bin/container.sh --stop $1
./bin/container.sh --upgrade-hybris $1
fi

if [ "$1" = "frontend" ]; then
./bin/container.sh --stop $1
./bin/container.sh --upgrade-front $1
fi

if [ "$1" = "wiremock" ]; then
./bin/container.sh --stop $1
./bin/container.sh --upgrade-mock $1
fi
docker rmi $(docker images -f "dangling=true" -q) -f
docker ps -a
