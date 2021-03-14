#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"                                                           
ROOT="$(realpath $DIR/../..)"
PROJ="$ROOT/Konclude/"

indent(){
    sed 's/^/    /'
}

echo "Taking a 'run' snapshot first (required for 'develop')"
"$DIR/../run/snap.sh" | indent

echo "Taking snapshot: 'develop'"

# If this is a build server, you might do something like this here:
##build the latest version, not the current version
# cd $PROJ
# git clean -df
# git reset --hard
# git pull origin master

cd "$DIR"

docker build . -t "koncludedev:latest"

echo "To explore 'develop' run:"
echo "docker run --rm -it koncludedev /bin/bash"
echo
