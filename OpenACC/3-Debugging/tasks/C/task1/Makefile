COMPOPT = -fast 
ACCOPT = -acc -ta=tesla:cc35 -Minfo=accel

.PHONY: all
all: vecAddRed.bin

JSC_SUBMIT_CMD ?= srun --partition=gpus --gres=gpu:1

vecAddRed.bin: vecAddRed.c Makefile
	pgcc $(COMPOPT) $(ACCOPT) vecAddRed.c -o vecAddRed.bin

.PHONY: debug
debug: vecAddRed.c Makefile
	pgcc $(COMPOPT) -g $(ACCOPT) vecAddRed.c -o vecAddRed.bin

.PHONY: run clean
run: vecAddRed.bin
	$(JSC_SUBMIT_CMD) ./vecAddRed.bin

clean:
	rm -f vecAddRed.bin
