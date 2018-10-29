#!/usr/bin/env bash
for n in 1024 2048 4096 8192 16384 32768 65536 131072; do ./nbody -hostmem -benchmark -numbodies=$n -numdevices=1 | grep GFLOP; ./nbody -numdevices=2 -benchmark -numbodies=$n | grep GFLOP; ./nbody -numdevices=4 -benchmark -numbodies=$n | grep GFLOP; ./nbody -fp64 -benchmark -numbodies=$n -numdevices=1 |grep GFLOP; ./nbody -fp64 -benchmark -numbodies=$n -numdevices=2 |grep GFLOP; ./nbody -fp64 -numdevices=4 -benchmark -numbodies=$n | grep GFLOP; done | tee nbody_bench.dat
python3 nbody_bench.py &
