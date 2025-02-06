#!/bin/bash

# checks if container name is supplied
if [ "$#" -eq 0 ]
then
    echo "Please specify a container name!"
    exit 1
fi

CONTAINER_NAME=$1

# checks if container exist
if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]
then
    echo "An existing container with the name $CONTAINER_NAME was found!"

    # checks if container is running and stop it if it is
    if [ "$(docker ps -aq -f status=running -f name=$CONTAINER_NAME)" ]
    then
        echo "Stopping container..."
        docker stop $CONTAINER_NAME
	echo "Container stopped."
    fi

    # removes stopped container
    echo "Removing stopped container..."
    docker rm -f $CONTAINER_NAME
    echo "Container removed."
fi

# pull the latest image
docker pull repo/image:master

# run new docker container
docker run -d --restart always --name $CONTAINER_NAME --env-file ./.env rogerboukar07/kainwang_bot:master