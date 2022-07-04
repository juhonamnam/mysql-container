# env
if [[ -f ./env.sh ]]; then
    echo "getting environment variables from env.sh..."
    . ./env.sh
fi

# Stop Running Containers
RUNNING_CONTAINERS=$(docker ps -q --filter name=$CONTAINER_NAME)

if [ ${#RUNNING_CONTAINERS} -ne 0 ]; then
    docker stop $(docker ps -q --filter name=$CONTAINER_NAME)
fi

# Delete Containers
ALL_CONTAINERS=$(docker ps -a -q --filter name=$CONTAINER_NAME)

if [ ${#ALL_CONTAINERS} -ne 0 ]; then
    docker rm $(docker ps -a -q --filter name=$CONTAINER_NAME)
fi
