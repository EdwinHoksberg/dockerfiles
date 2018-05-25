#!/bin/sh

set -ex

start_dir=$(pwd)
namespace=edwinhoksberg

# loop through each directory in current dir
for d in */; do
    cd "$d"
    current_dir=$(pwd)

    # loop through each version of the image
    for dd in */; do
        cd "$dd"

        # Get basename of directory and build docker image
        name=$(basename "$d")
        tag=$(basename "$dd")
        docker build -t "$namespace"/"$name":"$tag" .

        cd "$current_dir"
    done

    # return to the base directory
    cd "$start_dir"
done
