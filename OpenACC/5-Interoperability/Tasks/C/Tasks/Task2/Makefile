CUDA_PATH ?= $(CUDA_HOME)

LIBDIRS = -L$(CUDA_PATH)/lib64
LIBS = -lcudart

COMPOPT = -fast
ACCOPT = -acc -ta=tesla:cc35 -Minfo=accel

JSC_SUBMIT_CMD ?= srun --partition=gpus --gres=gpu:1 

.PHONY: all
all: vecAddRed.bin

vecAddRed.bin: vecAddRed.c cudaWrapper.o Makefile
	pgc++ $(COMPOPT) $(ACCOPT) vecAddRed.c cudaWrapper.o $(LIBDIRS) $(LIBS) -o vecAddRed.bin

cudaWrapper.o: cudaWrapper.cu Makefile
	nvcc cudaWrapper.cu -c

.PHONY: run clean
run: vecAddRed.bin
	$(JSC_SUBMIT_CMD) ./vecAddRed.bin
	
clean:
	rm -f vecAddRed.bin *.o
