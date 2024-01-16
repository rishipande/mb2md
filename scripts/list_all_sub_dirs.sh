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

    if [ ! -d "$source_dir" ]; then
        echo "FATAL(list_sub_dirs()): $source_dir is not a directory.";
        exit 1;
    fi

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

    all_sub_dirs_collection=()
    immediate_sub_dirs=()
    dirs_not_visited_queue=()

    top_dir_fqdn=`readlink -f $top_dir`;
    dirs_not_visited_queue+=( $top_dir_fqdn )
    all_sub_dirs_collection+=( $top_dir_fqdn )

    # breadth first kinda algo
    # visit every dir in dirs_not_visited_queue, and collect immediate
    # sub_dirs under each of them into dirs_not_visited_queue, until
    # all sub_dirs are visited

    while [ ${#dirs_not_visited_queue[@]} -ne 0 ]; do
        immediate_sub_dirs=$(list_sub_dirs "${dirs_not_visited_queue[0]}");
        
        # pushing immediate_sub_dirs found into dirs_not_visited_queue array 
        dirs_not_visited_queue+=( ${immediate_sub_dirs[@]} );
        
        # adding all found immediate_sub_dirs into all_sub_dirs_collection because
        # dirs_not_visited_queue is well, a queue, that will be empty at some point
        all_sub_dirs_collection+=( ${immediate_sub_dirs[@]} );

        # popping the top of dirs_not_visited_queue (dirs_not_visited_queue[0]), 
        # since it was just visited above when list_sub_dirs was called
        dirs_not_visited_queue=( ${dirs_not_visited_queue[@]:1} );
    done

    for each_dir in "${all_sub_dirs_collection[@]}"; do
        echo $each_dir;
    done
}

main $1;
