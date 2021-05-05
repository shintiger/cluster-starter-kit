#!/bin/bash

declare -a nodes=($(docker node ls | grep "Down" | sed 's/ .*//'))

for i in "${nodes[@]}"
do
        docker node rm "$i"
done