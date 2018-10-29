CUDA_PATH ?= $(CUDA_HOME)

# INCDIRS = -I$(CUDA_PATH)/include
LIBDIRS = -L$(CUDA_PATH)/lib64
LIBS = -lcudart -lstdc++ -lgcc_s

COMPOPT = -Mcuda
ACCOPT = -acc -ta=tesla:cc30 -Minfo=accel

JSC_SUBMIT_CMD ?= srun --partition=gpus --gres=gpu:1 

.PHONY: all
all: vecAddRed.bin

vecAddRed.bin: vecAddRed.F03 fortranthrust.F03 thrustWrapper.o Makefile
	pgfortran $(COMPOPT) $(ACCOPT) fortranthrust.F03 vecAddRed.F03 $(LIBDIRS) $(LIBS) thrustWrapper.o -o vecAddRed.bin

thrustWrapper.o: thrustWrapper.cu Makefile
	nvcc thrustWrapper.cu -c

.PHONY: run clean
run: vecAddRed.bin
	$(JSC_SUBMIT_CMD) ./vecAddRed.bin

clean:
	rm -f vecAddRed.bin *.o
