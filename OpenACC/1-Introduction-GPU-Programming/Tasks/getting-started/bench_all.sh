#!/usr/bin/env bash

[ -z "$JSC_MODULES_SOURCED" ] && "Please first \`source setup.sh\` to prepare the environment!" && exit 1;

[ -z "$CUDA_HOME" ] && echo "Please load CUDA before invoking the script!" && exit 1;

make

if [ -z "$SLURM_JOB_PARTITION" ]; then
	echo "! Please allocate GPU resources via"
	if [ -n "$JSC_SUBMIT_CMD" ]; then
		echo $JSC_SUBMIT_CMD
	else
		echo "! salloc --partition=gpus --gres=gpu:4 -n 1"
	fi
	exit
fi

if [[ "$SLURM_JOB_PARTITION" != "gpus" ]]; then
	echo "GPU Course Examples need GPUs! Please run inside of a GPU allocation."
else
	export OMP_NUM_THREADS=40
	SUBMIT="srun -c ${OMP_NUM_THREADS}"
	$SUBMIT ./dgemm_bench.sh
	$SUBMIT ./nbody_bench.sh
	$SUBMIT ./ddot_bench.sh
	$SUBMIT ./mandelbrot_bench.sh
fi

make display
