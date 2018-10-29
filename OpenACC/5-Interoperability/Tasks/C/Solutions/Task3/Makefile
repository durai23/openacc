LIBDIRS = -L$(CUDA_HOME)/lib64
LIBS = -lcudart

COMPOPT = -fast
ACCOPT = -acc -ta=tesla:cc35 -Minfo=accel

JSC_SUBMIT_CMD ?= srun --partition=gpus --gres=gpu:1 

.PHONY: all
all: vecAddRed.bin

vecAddRed.bin: vecAddRed.c thrustWrapper.o Makefile
	pgc++ $(COMPOPT) $(ACCOPT) vecAddRed.c thrustWrapper.o $(LIBDIRS) $(LIBS) -o vecAddRed.bin

thrustWrapper.o: thrustWrapper.cu Makefile
	nvcc thrustWrapper.cu -c

.PHONY: run clean
run: vecAddRed.bin
	$(JSC_SUBMIT_CMD) ./vecAddRed.bin
	
clean:
	rm -f vecAddRed.bin *.o
