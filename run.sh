#!/bin/bash

iterations=${iterations:-3}
threads="1 2 4 8"
modes="read write"

for i in $(seq 1 $iterations) ; do
    for mode in $modes ; do
        for thread in $threads ; do
            sysbench --threads=$thread --time=30 memory --memory-oper=${mode} run | tee output-$i-$mode-$thread.txt
            cb-client sysbench_ram < output-$i-$mode-$thread.txt
        done
    done
done
