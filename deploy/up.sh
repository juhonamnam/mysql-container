# env
if [[ -f ./.env ]]; then
    echo "getting environment variables from .env..."
    . ./.env
fi

# Stop Running Containers
RUNNING_CONTAINERS=$(docker ps -q --filter name=$CONTAINER_NAME)

if [ ${#RUNNING_CONTAINERS} -ne 0 ]; then
    echo "Stopping currently running containers..."
    docker stop $RUNNING_CONTAINERS
fi

# Delete Containers
ALL_CONTAINERS=$(docker ps -a -q --filter name=$CONTAINER_NAME)

if [ ${#ALL_CONTAINERS} -ne 0 ]; then
    echo "Deleting containers..."
    docker rm $ALL_CONTAINERS
fi

# Set arguments
ARGS=""

if [ ${#MYSQL_ROOT_PASSWORD} -ne 0 ]; then
    echo "ENV MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD "
    ARGS=${ARGS}"-e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD "
fi

if [ ${#MYSQL_DATABASE} -ne 0 ]; then
    echo "ENV MYSQL_DATABASE=$MYSQL_DATABASE "
    ARGS=${ARGS}"-e MYSQL_DATABASE=$MYSQL_DATABASE "
fi

if [ ${#MYSQL_USER} -ne 0 ]; then
    echo "ENV MYSQL_USER=$MYSQL_USER "
    ARGS=${ARGS}"-e MYSQL_USER=$MYSQL_USER "
fi

if [ ${#MYSQL_PASSWORD} -ne 0 ]; then
    echo "ENV MYSQL_PASSWORD=$MYSQL_PASSWORD "
    ARGS=${ARGS}"-e MYSQL_PASSWORD=$MYSQL_PASSWORD "
fi

if [ ${#MYSQL_ALLOW_EMPTY_PASSWORD} -ne 0 ]; then
    echo "ENV MYSQL_ALLOW_EMPTY_PASSWORD=$MYSQL_ALLOW_EMPTY_PASSWORD "
    ARGS=${ARGS}"-e MYSQL_ALLOW_EMPTY_PASSWORD=$MYSQL_ALLOW_EMPTY_PASSWORD "
fi

if [ ${#MYSQL_RANDOM_ROOT_PASSWORD} -ne 0 ]; then
    echo "ENV MYSQL_RANDOM_ROOT_PASSWORD=$MYSQL_RANDOM_ROOT_PASSWORD "
    ARGS=${ARGS}"-e MYSQL_RANDOM_ROOT_PASSWORD=$MYSQL_RANDOM_ROOT_PASSWORD "
fi

if [ ${#MYSQL_ONETIME_PASSWORD} -ne 0 ]; then
    echo "ENV MYSQL_ONETIME_PASSWORD=$MYSQL_ONETIME_PASSWORD "
    ARGS=${ARGS}"-e MYSQL_ONETIME_PASSWORD=$MYSQL_ONETIME_PASSWORD "
fi

if [ ${#MYSQL_INITDB_SKIP_TZINFO} -ne 0 ]; then
    echo "ENV MYSQL_INITDB_SKIP_TZINFO=$MYSQL_INITDB_SKIP_TZINFO "
    ARGS=${ARGS}"-e MYSQL_INITDB_SKIP_TZINFO=$MYSQL_INITDB_SKIP_TZINFO "
fi

if [ ${#CONTAINER_NAME} -ne 0 ]; then
    echo "NAME $CONTAINER_NAME "
    ARGS=${ARGS}"--name $CONTAINER_NAME "
fi

if [ ${#EXTERNAL_PORT} -ne 0 ]; then
    echo "PORT $EXTERNAL_PORT:3306 "
    ARGS=${ARGS}"-p $EXTERNAL_PORT:3306 "
fi

if [ ${#NERWORK_NAME} -ne 0 ]; then
    echo "NETWORK $NERWORK_NAME "
    ARGS=${ARGS}"--network $NERWORK_NAME "
fi

if [ ${#PLATFORM} -ne 0 ]; then
    echo "PLATFORM $PLATFORM "
    ARGS=${ARGS}"--platform $PLATFORM "
fi

if [ ${#MYSQL_VERSION} -ne 0 ]; then
    echo "VERSION $MYSQL_VERSION "
    MYSQL_VERSION=:$MYSQL_VERSION
fi

mkdir -p mysql
docker run \
    ${ARGS} \
    -v $(pwd)/conf.d/custom-config.cnf:/etc/mysql/conf.d/custom-config.cnf \
    -v $(pwd)/mysql:/var/lib/mysql \
    -d mysql$MYSQL_VERSION
