#!/bin/bash

# --- functions ---
clone(){
    #remove https://
    repo=git+ssh://git@${1#"https://"}.git

    #clone repo
    hg clone $repo
    if [ $? -ne 0 ]; then
        echo "Error cloning"
        exit 13
    fi

    #goto repo and set master branch correctly
    cd $(basename ${repo%.git})
    hg bookmark -r default master
    cd ..
}

addupstream(){
    #remove https://
    repo=git+ssh://git@${1#"https://"}.git

    #edit .hg/hgrc
    cd $(basename ${repo%.git})
    if [ $? -ne 0 ]; then
        echo "$(basename ${repo%.git}) does not exist"
        exit 13
    fi
    awk '/default/ { print; print "upstream = '$repo'"; next }1' .hg/hgrc > /tmp/new.txt
    mv /tmp/new.txt .hg/hgrc
    hg paths
    cd ..
}

# --- script ---

if [ $# -eq 1 ];then
    #one parameter => clone only
    clone $1
elif [ $# -eq 2 ]; then
    #two parameters => clone and set remote
    clone $1
    addupstream $2
else
    #error check
    echo "usage: $0 https://github.com/path/to/git [https://github.com/path/to/upstream/repo]"
    exit 0
fi

