# env
. ./env.sh

docker stop $(docker ps -q --filter name=$CONTAINER_NAME)
docker rm $(docker ps -a -q --filter name=$CONTAINER_NAME)
