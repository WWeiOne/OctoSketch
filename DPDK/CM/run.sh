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



timeout 60s perf record -g ./build/OctoSketch -l $core_list -n 4 -a 0000:17:00.1

rm -rf ~/perf/host_sketch_$1.perf

perf script > ~/perf/host_sketch_$1.perf

stackcollapse-perf.pl ~/perf/host_sketch_$1.perf  > ~/perf/host_sketch_$1.folded

flamegraph.pl ~/perf/host_sketch_$1.folded > ~/perf/flamegraph_host_sketch_$1.svg

echo "sudo perf record -g ./build/OctoSketch -l $core_list -n 4 -a 0000:17:00.1"

echo "perf script > ~/perf/host_sketch_$1.perf"
