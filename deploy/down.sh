# env
if [[ -f ./env.sh ]]; then
    echo "getting environment variables from env.sh..."
    . ./env.sh
fi

docker stop $(docker ps -q --filter name=$CONTAINER_NAME)
docker rm $(docker ps -a -q --filter name=$CONTAINER_NAME)
