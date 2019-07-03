#!/usr/bin/env bash
ORIG=$(pwd)                                                                                                       
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"                                                           
ROOT="$(realpath $DIR/../..)"
PROJ="$ROOT/Konclude"

indent(){
    sed 's/^/    /'
}

echo "Taking 'build' snapshot (required for 'deploy')"
"$DIR/../build/snap.sh" | indent

printf "\nExtracting binaries from koncludebuild\n"
# start a container on the build image
build_container="$(docker run -d koncludebuild:latest /bin/bash)"



# clean up old binary
mkdir "$ROOT/Release"
rm -f "$ROOT/Release/Konclude"

# copy the binary from the container
docker cp "$build_container:/usr/local/src/konclude-static/Release/Konclude" "$ROOT/Release/"

chmod 777 "$ROOT/Release/Konclude"

# clean up the container
docker rm "$build_container" 1> /dev/null

printf "\n"


# copy the dockerfile to the project root so it can be a parent of the source
# (necessary because docker hashes children to see if rebuilding a layer is needed)
cp -p "$DIR/Dockerfile" "$ROOT"

cd "$ROOT"
docker build . -t "konclude" && printf "Done building 'build'\n\n"

rm "$ROOT/Dockerfile"



echo "Things to try:"
echo "docker run -v $PROJ/Tests:/data --rm konclude owllinkfile -i /data/galen-ALEHIF+-classify-request.xml -o /data/Test-response.xml"
echo "docker run -p 8080:8080 --rm konclude owllinkserver"
echo "docker run -p 8080:8080 --rm konclude sparqlserver"

cd "$ORIG"
