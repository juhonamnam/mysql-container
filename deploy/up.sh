# env
if [[ -f ./env.sh ]]; then
    echo "getting environment variables from env.sh..."
    . ./env.sh
fi

docker stop $(docker ps -q --filter name=$CONTAINER_NAME)
docker rm $(docker ps -a -q --filter name=$CONTAINER_NAME)

mkdir -p mysql
docker run \
    --name $CONTAINER_NAME \
    -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
    -e MYSQL_DATABASE=$MYSQL_DATABASE \
    -e MYSQL_USER=$MYSQL_USER \
    -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
    -e MYSQL_ALLOW_EMPTY_PASSWORD=$MYSQL_ALLOW_EMPTY_PASSWORD \
    -e MYSQL_RANDOM_ROOT_PASSWORD=$MYSQL_RANDOM_ROOT_PASSWORD \
    -e MYSQL_ONETIME_PASSWORD=$MYSQL_ONETIME_PASSWORD \
    -e MYSQL_INITDB_SKIP_TZINFO=$MYSQL_INITDB_SKIP_TZINFO \
    -v $(pwd)/conf.d/custom-config.cnf:/etc/mysql/conf.d/custom-config.cnf \
    -v $(pwd)/mysql:/var/lib/mysql \
    -p $MYSQL_PORT:3306 \
    -d mysql:8.0.29
