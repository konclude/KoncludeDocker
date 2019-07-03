#!/usr/bin/env bash
ORIG=$(pwd)                                                                                                       
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"                                                           
ROOT="$(realpath $DIR/../..)"
PROJ="$ROOT/Konclude/"
STAGE="$ROOT/stage/"

indent(){
    sed 's/^/    /'
}

echo "Taking a 'develop' snapshot first (required for 'build')"
"$DIR/../develop/snap.sh" | indent

cd "$DIR"
docker build . -t "koncludebuild:latest"

echo "things to try:"
echo "docker run --rm -it koncludebuild /bin/bash"
echo "docker run --rm koncludebuild /usr/local/src/konclude-static/Release/Konclude owllinkfile -i /usr/local/src/konclude-static/Tests/galen-ALEHIF+-classify-request.xml -w 1"
echo

cd "$ORIG"
