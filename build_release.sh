#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"                                                           
ROOT="$(realpath $DIR/..)"
PROJ="$ROOT/Konclude"


rm -rf "$ROOT/Release"
mkdir "$ROOT/Release"

"$DIR/deploy/snap.sh"

cd "$DIR"


revisionCount="842"
revisionTagName="v0.6.2"
revisionHashName="ec7264db"


# binary linux release
RELEA="$ROOT/Release/Konclude-$revisionTagName-$revisionCount-Linux-x64-GCC4.8.4-Static-Qt-5.13"
mkdir "$RELEA"
mkdir "$RELEA/Configs"
mkdir "$RELEA/Tests"
mkdir "$RELEA/Binaries"


cp "$ROOT/Release/Konclude" "$RELEA/Binaries"

cp "$PROJ/LGPL-3.0.txt" "$RELEA"
cp "$PROJ/GPL.txt" "$RELEA"
cp "$PROJ/Readme.txt" "$RELEA"

cp "$PROJ/Tests/1b-satisfiability-request.xml" "$RELEA/Tests"
cp "$PROJ/Tests/galen.owl.xml" "$RELEA/Tests"
cp "$PROJ/Tests/galen-classify-request.xml" "$RELEA/Tests"
cp "$PROJ/Tests/roberts-family-full-D.owl.xml" "$RELEA/Tests"
cp "$PROJ/Tests/roberts-family-full-D-classify-realize-request.xml" "$RELEA/Tests"
cp "$PROJ/Tests/test-request.xml" "$RELEA/Tests"

cp "$PROJ/Scripts/Konclude" "$RELEA"
cp "$PROJ/Scripts/Konclude.sh" "$RELEA"


cp "$PROJ/Configs/default-config.xml" "$RELEA/Configs"
cp "$PROJ/Configs/querying-config.xml" "$RELEA/Configs"


releaseZipName="Konclude-$revisionTagName-$revisionCount-Linux-x64-GCC4.8.4-Static-Qt-5.13"


# source code release
SOURCER="$ROOT/Release/Konclude-$revisionTagName-$revisionCount-Sources"
mkdir "$SOURCER"
mkdir "$SOURCER/Konclude"
mkdir "$SOURCER/Konclude/Configs"
mkdir "$SOURCER/Konclude/Tests"


cp -r "$ROOT/Konclude/Scripts" "$SOURCER/Konclude"
cp -r "$ROOT/Konclude/External" "$SOURCER/Konclude"
cp -r "$ROOT/Konclude/Source" "$SOURCER/Konclude"
cp "$ROOT/Konclude/Konclude.pro" "$SOURCER/Konclude"
cp "$ROOT/Konclude/Konclude.pri" "$SOURCER/Konclude"
cp "$ROOT/Konclude/Konclude-VS15.sln" "$SOURCER/Konclude"
cp "$ROOT/Konclude/Konclude-VS15.vcproj" "$SOURCER/Konclude"
cp "$ROOT/Konclude/KoncludeWithoutRedland.pro" "$SOURCER/Konclude"

cp "$ROOT/Konclude/UnixGitBuildScript.sh" "$SOURCER/Konclude"
cp "$ROOT/Konclude/WinGitBuildScript.bat" "$SOURCER/Konclude"

echo "#define KONCLUDE_VERSION_GIT_REVISION_NUMBER $revisionCount" > "$SOURCER/Konclude/revision-git.h"
echo "#define KONCLUDE_VERSION_GIT_TAG_NAME_STRING \"$revisionTagName\"" >> "$SOURCER/Konclude/revision-git.h"
echo "#define KONCLUDE_VERSION_GIT_REVISION_HASH_STRING \"$revisionHashName\"" >> "$SOURCER/Konclude/revision-git.h"

echo "#!/usr/bin/env bash" > "$SOURCER/Konclude/UnixGitBuildScript.sh"
echo " " > "$SOURCER/Konclude/WinGitBuildScript.bat"


cp -r "$ROOT/KoncludeDocker" "$SOURCER"


sourceZipName="Konclude-$revisionTagName-$revisionCount-Sources"

revisionCount="\"$revisionCount\""
revisionTagName="\"$revisionTagName\""
revisionHashName="\"$revisionHashName\""
sed -i -e '0,/`git log --oneline | wc -l`/s//'"$revisionCount"'/' "$SOURCER/KoncludeDocker/build_release.sh"
sed -i -e '0,/`git describe --tags --match v*.*.* --abbrev=0`/s//'"$revisionTagName"'/' "$SOURCER/KoncludeDocker/build_release.sh"
sed -i -e '0,/`git log --pretty=format:%h -n 1`/s//'"$revisionHashName"'/' "$SOURCER/KoncludeDocker/build_release.sh"




cp "$PROJ/LGPL-3.0.txt" "$SOURCER/Konclude"
cp "$PROJ/GPL.txt" "$SOURCER/Konclude"
cp "$PROJ/Readme.txt" "$SOURCER/Konclude"

cp "$PROJ/Tests/1b-satisfiability-request.xml" "$SOURCER/Konclude/Tests"
cp "$PROJ/Tests/galen.owl.xml" "$SOURCER/Konclude/Tests"
cp "$PROJ/Tests/galen-classify-request.xml" "$SOURCER/Konclude/Tests"
cp "$PROJ/Tests/galen-ALEHIF+-classify-request.xml" "$SOURCER/Konclude/Tests"
cp "$PROJ/Tests/roberts-family-full-D.owl.xml" "$SOURCER/Konclude/Tests"
cp "$PROJ/Tests/roberts-family-full-D-classify-realize-request.xml" "$SOURCER/Konclude/Tests"
cp "$PROJ/Tests/test-request.xml" "$SOURCER/Konclude/Tests"

cp "$PROJ/Scripts/Konclude" "$SOURCER/Konclude"
cp "$PROJ/Scripts/Konclude.sh" "$SOURCER/Konclude"


cp "$PROJ/Configs/default-config.xml" "$SOURCER/Konclude/Configs"
cp "$PROJ/Configs/querying-config.xml" "$SOURCER/Konclude/Configs"

cd "$ROOT/Release/"
zip -r -q "${sourceZipName}.zip" "${sourceZipName}" 
zip -r -q "${releaseZipName}.zip" "${releaseZipName}" 


