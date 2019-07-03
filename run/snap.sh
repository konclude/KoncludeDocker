#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Taking snapshot 'run'"

docker build "$DIR" -t "koncluderun:latest"

echo "To explore 'run' use:"
echo "docker run --rm -it koncluderun /bin/bash"
echo
