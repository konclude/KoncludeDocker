#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT="$(realpath $DIR/..)"
PROJ="$ROOT/Konclude"



if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]; then

	revisionCount=`git log --oneline | wc -l`
	revisionTagName=`git describe --tags --match v*.*.* --abbrev=0`
	revisionHashName=`git log --pretty=format:%h -n 1`

	echo "Revision information from git: $revisionTagName-$revisionCount ($revisionHashName)"
	echo $revisionCount
	echo $revisionTagName
	echo $revisionHashName
else
	echo "No revision information from git"
	revisionCount="0"
	revisionTagName="v0.0.0"
	revisionHashName="000000000"
fi



FILE=$PROJ/revision-git.h
if test -f "$FILE"; then
	tmpRevisionCount=`grep -oP '(?<=define KONCLUDE_VERSION_GIT_REVISION_NUMBER ).*' $FILE`
	tmpRevisionTagName=`grep -oP '(?<=define KONCLUDE_VERSION_GIT_TAG_NAME_STRING ).*' $FILE | sed 's/"//g'`
	tmpRevisionHashName=`grep -oP '(?<=define KONCLUDE_VERSION_GIT_REVISION_HASH_STRING ).*' $FILE | sed 's/"//g'`
	echo "Revision information from file $FILE: $tmpRevisionTagName-$tmpRevisionCount ($tmpRevisionHashName)"
	if [ "$revisionCount" -lt "$tmpRevisionCount" ]; then
		revisionCount=$tmpRevisionCount
		revisionTagName=$tmpRevisionTagName
		revisionHashName=$tmpRevisionHashName
		echo "Using revision information from file $FILE: $revisionTagName-$revisionCount ($revisionHashName)"
	else
		echo "Revision information in file $FILE seems outdated, updating file"
		echo "#define KONCLUDE_VERSION_GIT_REVISION_NUMBER $revisionCount" > $FILE
		echo "#define KONCLUDE_VERSION_GIT_TAG_NAME_STRING \"$revisionTagName\"" >> $FILE
		echo "#define KONCLUDE_VERSION_GIT_REVISION_HASH_STRING \"$revisionHashName\"" >> $FILE
	fi
else
	echo "#define KONCLUDE_VERSION_GIT_REVISION_NUMBER $revisionCount" > $FILE
	echo "#define KONCLUDE_VERSION_GIT_TAG_NAME_STRING \"$revisionTagName\"" >> $FILE
	echo "#define KONCLUDE_VERSION_GIT_REVISION_HASH_STRING \"$revisionHashName\"" >> $FILE
	echo "File $FILE does not exist, creating it"
fi


$DIR/build_release_parameterized.sh $revisionCount $revisionTagName $revisionHashName

