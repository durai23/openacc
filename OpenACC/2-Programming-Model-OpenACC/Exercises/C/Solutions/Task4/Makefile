# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
COMPILER ?= PGI-manual
CC = pgcc
CFLAGS = -DUSE_DOUBLE
ifeq ($(COMPILER),GCC)
	CFLAGS += -std=c99 -march=native -O3 -lm
else ifeq ($(COMPILER),PGI)
	CFLAGS += -fast
else ifeq ($(COMPILER),PGI-tesla)
	CFLAGS += -Minfo=accel -fast -acc -ta=tesla:cc35,managed
else ifeq ($(COMPILER),PGI-manual)
	CFLAGS += -Minfo=accel -fast -acc -ta=tesla:cc35
else ifeq ($(COMPILER),PGI-multicore)
	CFLAGS += -Minfo=accel -fast -acc -ta=multicore
endif

JSC_SUBMIT_CMD ?= srun --partition=gpus --gres=gpu:1 

all: poisson2d

poisson2d_reference.o: poisson2d_reference.c common.h  Makefile
	$(CC) -c $(CFLAGS) poisson2d_reference.c -o $@

poisson2d: poisson2d.c common.h poisson2d_reference.o Makefile
	$(CC) $(CFLAGS) poisson2d.c poisson2d_reference.o -o $@

.PHONY: clean run profile
clean:
	rm -f poisson2d poisson2d*.o

run: poisson2d
	$(JSC_SUBMIT_CMD) ./poisson2d

#Disable CPU Profiling to minimize size of profiles
profile: poisson2d
	$(JSC_SUBMIT_CMD) pgprof --cpu-profiling off ./poisson2d 10
profile_tofile: poisson2d
	$(JSC_SUBMIT_CMD) pgprof --cpu-profiling off -o poisson2d.pgprof ./poisson2d 10

.PHONY: task1 task1_profile task4
task1: poisson2d_reference.o poisson2d.c common.h Makefile
	$(CC) -DUSE_DOUBLE -Minfo=all,intensity -fast -Minfo=ccff -Mprof=ccff poisson2d_reference.o poisson2d.c -o poisson2d

task1_profile:
	$(JSC_SUBMIT_CMD) pgprof --cpu-profiling on --cpu-profiling-scope instruction --cpu-profiling-mode flat ./poisson2d 10
