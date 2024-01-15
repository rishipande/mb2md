#!/bin/bash

# Author: https://github.com/rishipande
# Purpose: Return all directories under a given path.
# License: https://unlicense.org/

function usage() {
    echo "Purpose: Return all directories under a given path.";
    echo "Usage: $0 DIR_NAME_TO_TRAVERSE";
    echo "   DIR_NAME_TO_TRAVERSE should be a directory.";
    echo "   This will return all the sub directories under";
    echo "   DIR_NAME_TO_TRAVERSE.";
}

# list_sub_dirs(source_dir)
# returns a directory tree (of dirs only)
function list_sub_dirs() { 
    dirs=();
    source_dir=$1;

    for each_file in `\ls $source_dir`; do
        if [ -d "$source_dir/$each_file" ]; then 
            dirs+=( "$source_dir/$each_file" ); 
        fi; 
    done

    echo ${dirs[@]};
}

function main() {
    # Expecting at least and only one parameter, a dir name
    top_dir=$1;

    if [ ! -d "$top_dir" ]; then
        echo "Error: $top_dir is not a directory.";
        usage;
        exit 1;
    fi

    all_sub_dirs=()
    immediate_sub_dirs=()
    dirs_not_visited=()

    top_dir_fqdn=`readlink -f $top_dir`;
    dirs_not_visited+=( $top_dir_fqdn )
    all_sub_dirs+=( $top_dir_fqdn )

    # depth first kinda algo
    # visit every dir in dirs_not_visited, and collect immediate
    # sub_dirs under each of them into dirs_not_visited, until
    # all sub_dirs are visited

    while [ ${#dirs_not_visited[@]} -ne 0 ]; do
        immediate_sub_dirs=$(list_sub_dirs "${dirs_not_visited[0]}");

        dirs_not_visited+=( ${immediate_sub_dirs[@]} );

        all_sub_dirs+=( ${immediate_sub_dirs[@]} );

        # popping the top of dirs_not_visited (dirs_not_visited[0]), 
        # since it was just visited above when list_sub_dirs was called
        dirs_not_visited=( ${dirs_not_visited[@]:1} );
    done

    for each_dir in "${all_sub_dirs[@]}"; do
        echo $each_dir;
    done
}

main $1;