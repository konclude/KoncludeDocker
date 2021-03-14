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

# copy the dockerfile to the project root so it can be a parent of the source
# (necessary because docker hashes children to see if rebuilding a layer is needed)
cp -p "$DIR/Dockerfile" "$ROOT"
echo "KoncludeDocker/" >> "$ROOT/.dockerignore"

cd "$ROOT"

mkdir -p "$ROOT/Konclude/External/librdf/Linux/x64/lib/release"

cp "$ROOT/Konclude/revision-git.h" "$ROOT"
Konclude/UnixGitBuildScript.sh
echo "#!/bin/bash" > UnixGitBuildScript.sh
chmod a+x UnixGitBuildScript.sh

docker build . -t "koncludebuild:latest"

rm revision-git.h
rm UnixGitBuildScript.sh
rm "$ROOT/Dockerfile"
rm "$ROOT/.dockerignore"

echo "things to try:"
echo "docker run --rm -it koncludebuild /bin/bash"
echo "docker run --rm koncludebuild /usr/local/src/konclude-static/Release/Konclude owllinkfile -i /usr/local/src/konclude-static/Tests/galen-ALEHIF+-classify-request.xml -w 1"
echo

cd "$ORIG"
