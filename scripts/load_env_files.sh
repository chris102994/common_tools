#!/bin/bash

set -u # Unset Variables are an error
set -e # Exit on error

usage() {
	echo "usage: $(basename "$0") /path/to/env/file [/path/to/env/file...]"
	exit 1
}

if [ -z "$1" ]; then
	usage
fi

for FILE in "$@"
do
	if [ -f "$FILE" ]; then
		export $(egrep -v '^#' "$FILE" | xargs)
		echo "Exporting the following vars from $FILE:"
		cat $FILE
	else
		echo "$FILE isn't a file."
	fi
done