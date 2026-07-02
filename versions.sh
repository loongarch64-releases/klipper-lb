#!/usr/bin/bash

org='k3s-io'
proj='klipper-lb'
number=${1:-5}

versions(){
    curl -sL "https://api.github.com/repos/${org}/${proj}/releases" | jq -r ".[].tag_name" | \
        sort -rV | \
        head -n ${number} | \
        sed 's:v::g'
}

versions | \
    grep -v '0.4.15'
