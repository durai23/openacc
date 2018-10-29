COMPOPT = -fast 
ACCOPT = -acc -ta=tesla:cc30 -Minfo=accel

JSC_SUBMIT_CMD ?= srun --partition=gpus --gres=gpu:1

.PHONY: all
all: spmv.bin

spmv.bin: spmv.c Makefile
	pgcc $(COMPOPT) $(ACCOPT) spmv.c -o spmv.bin

.PHONY: debug
debug: spmv.c Makefile
	pgcc $(COMPOPT) -g $(ACCOPT) spmv.c -o spmv.bin

.PHONY: run clean
run: spmv.bin
	$(JSC_SUBMIT_CMD) ./spmv.bin

clean:
	rm -f spmv.bin
