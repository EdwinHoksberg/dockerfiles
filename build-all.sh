#!/bin/sh

set -e

current_dir=$(pwd)
namespace=edwinhoksberg

# loop through each directory in current dir
for d in */; do
    cd "$d"

    # Get basename of directory and build docker image
    name=$(basename "$d")
    docker build -t "$namespace"/"$name" .

    # return to the base directory
    cd "$current_dir"
done
