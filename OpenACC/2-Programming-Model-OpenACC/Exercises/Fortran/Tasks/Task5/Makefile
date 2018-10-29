# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
COMPILER ?= PGI-manual
FC = pgfortran
CFLAGS = -DUSE_DOUBLE
ifeq ($(COMPILER),GCC)
	CFLAGS += -march=native -O3 -lm
else ifeq ($(COMPILER),PGI)
	CFLAGS += -fast
else ifeq ($(COMPILER),PGI-tesla)
	CFLAGS += -Minfo=accel -O3 -acc -ta=tesla:cc35,managed
else ifeq ($(COMPILER),PGI-manual)
	CFLAGS += -Minfo=accel -O3 -acc -ta=tesla:cc35
else ifeq ($(COMPILER),PGI-multicore)
	CFLAGS += -Minfo=accel -O3 -acc -ta=multicore
endif

JSC_SUBMIT_CMD ?= srun --partition=gpus --gres=gpu:1 

all: poisson2d

poisson2d: poisson2d.f90 poisson2d_reference.f90 Makefile
	$(FC) $(CFLAGS) poisson2d.f90 poisson2d_reference.f90 -o $@

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
task1: poisson2d.f90 poisson2d_reference.f90 Makefile
	$(FC) -Minfo=all,intensity -Minfo=ccff -Mprof=ccff poisson2d.f90 poisson2d_reference.f90 -o poisson2d

task1_profile:
	$(JSC_SUBMIT_CMD) pgprof --cpu-profiling on --cpu-profiling-scope instruction --cpu-profiling-mode flat ./poisson2d 10
