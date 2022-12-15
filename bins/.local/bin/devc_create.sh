#! /bin/bash

# check that 2 arguments have been provided
if [ $# -ne 2 ]; then
    echo "Usage: devc_create.sh <container_name> <image_name>"
    exit 1
fi

docker run --label no-prune -it --name dc_"$1" --hostname dc_"$1" --volume $HOME:/host_home $2

