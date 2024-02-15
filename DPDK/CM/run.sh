#!/bin/bash

make clean
make

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <number_of_pairs>"
    exit 1
fi

core_list="0,2"

for (( i=1; i<=$1; i++ )); do
    core_list="$core_list,$((i * 2 + 2))"
done

echo "Core list: $core_list"

sleep 2

./build/OctoSketch -l $core_list -n 4 -a 0000:17:00.1
