# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
COMPILER ?= PGI-tesla
CC = mpicc
CFLAGS = -DUSE_DOUBLE
ifeq ($(COMPILER),GCC)
	CFLAGS += -std=c99 -march=native -O3 -lm
else ifeq ($(COMPILER),PGI-tesla)
	CFLAGS += -Minfo=accel -fast -acc -ta=tesla
else ifeq ($(COMPILER),PGI-multicore)
	CFLAGS += -Minfo=accel -fast -acc -ta=multicore
endif

NP ?= 4
JSC_SUBMIT_CMD ?= srun --partition=develgpus --gres=gpu:4

all: run

poisson2d_serial.o: poisson2d_serial.c common.h  Makefile
	$(CC) -c $(CFLAGS) poisson2d_serial.c -o poisson2d_serial.o

poisson2d: poisson2d.c common.h poisson2d_serial.o Makefile
	$(CC) $(CFLAGS) poisson2d.c poisson2d_serial.o -o poisson2d

poisson2d.solution: poisson2d.solution.c common.h poisson2d_serial.o Makefile
	$(CC) $(CFLAGS) poisson2d.solution.c poisson2d_serial.o -o poisson2d.solution

clean:
	rm -f poisson2d poisson2d.solution poisson2d*.o poisson2d.*.pgprof

run: poisson2d
	$(JSC_SUBMIT_CMD) -n $(NP) ./poisson2d

profile: poisson2d
	$(JSC_SUBMIT_CMD) -n $(NP) pgprof --cpu-profiling off --process-name "MPI %q{PMI_RANK}" --context-name "MPI %q{PMI_RANK}" -o poisson2d.%q{PMI_RANK}.pgprof ./poisson2d

solution: poisson2d.solution
	$(JSC_SUBMIT_CMD) -n $(NP) ./poisson2d.solution

profile.solution: poisson2d.solution
	$(JSC_SUBMIT_CMD) -n $(NP) pgprof --cpu-profiling off --process-name "MPI %q{PMI_RANK}" --context-name "MPI %q{PMI_RANK}" -o poisson2d.solution.%q{PMI_RANK}.pgprof ./poisson2d.solution
