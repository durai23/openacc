CUDA_PATH ?= $(CUDA_HOME)

# INCDIRS = -I$(CUDA_PATH)/include
# LIBDIRS = -L$(CUDA_PATH)/lib64
# Not needed for Fortran

COMPOPT = -Mcuda
ACCOPT = -acc -ta=tesla:cc30 -Minfo=accel

JSC_SUBMIT_CMD ?= srun --partition=gpus --gres=gpu:1 

.PHONY: all
all: vecAddRed.bin

vecAddRed.bin: vecAddRed.F03 Makefile
	pgfortran $(COMPOPT) $(ACCOPT) vecAddRed.F03 $(LIBDIRS) $(LIBS) -o vecAddRed.bin

.PHONY: debug
debug: vecAddRed.F03 Makefile
	pgfortran $(COMPOPT) -g $(ACCOPT) vecAddRed.F03 $(LIBDIRS) $(LIBS) -o vecAddRed.bin

.PHONY: run clean
run: vecAddRed.bin
	$(JSC_SUBMIT_CMD) ./vecAddRed.bin


clean:
	rm -f vecAddRed.bin *.o
