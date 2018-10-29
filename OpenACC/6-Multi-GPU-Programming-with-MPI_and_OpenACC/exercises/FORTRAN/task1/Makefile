# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
COMPILER ?= PGI-tesla
FC = mpifort
ifeq ($(COMPILER),GCC)
FCFLAGS = -freal-4-real-8 -DMPI_REAL_TYPE=MPI_REAL8
else
FCFLAGS = -r8 -DMPI_REAL_TYPE=MPI_REAL8
endif
ifeq ($(COMPILER),GCC)
	FCFLAGS += -march=native -O3 -lm
else ifeq ($(COMPILER),PGI-tesla)
	FCFLAGS += -Minfo=accel -fast -acc -ta=tesla
else ifeq ($(COMPILER),PGI-multicore)
	FCFLAGS += -Minfo=accel -fast -acc -ta=multicore
endif

NP ?= 4
JSC_SUBMIT_CMD ?= srun --partition=develgpus --gres=gpu:4

all: run

poisson2d_serial.o: poisson2d_serial.F03 Makefile
	$(FC) -c $(FCFLAGS) poisson2d_serial.F03 -o poisson2d_serial.o

poisson2d: poisson2d.F03 poisson2d_serial.o Makefile
	$(FC) $(FCFLAGS) poisson2d.F03 poisson2d_serial.o -o poisson2d

poisson2d.solution: poisson2d.solution.F03 poisson2d_serial.o Makefile
	$(FC) $(FCFLAGS) poisson2d.solution.F03 poisson2d_serial.o -o poisson2d.solution

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
