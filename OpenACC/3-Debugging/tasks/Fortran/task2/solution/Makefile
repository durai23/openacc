COMPOPT = -mp -r8 -fast
ACCOPT = -acc -ta=tesla:cc35 -Minfo=accel

JSC_SUBMIT_CMD ?= srun --partition=gpus --gres=gpu:1

.PHONY: all
all: spmv.bin

spmv.bin: spmv.F03 Makefile
	pgfortran $(COMPOPT) $(ACCOPT) spmv.F03 -o spmv.bin

.PHONY: debug
debug: spmv.F03 Makefile
	pgfortran $(COMPOPT) -g $(ACCOPT) spmv.F03 -o spmv.bin

.PHONY: run clean
run: spmv.bin
	$(JSC_SUBMIT_CMD) ./spmv.bin

clean:
	rm -f spmv.bin

