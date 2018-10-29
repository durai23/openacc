LIBS = -lcufft

COMPOPT = -Mcuda
ACCOPT = -acc -ta=tesla:cc30 -Minfo=accel

JSC_SUBMIT_CMD ?= srun --partition=gpus --gres=gpu:1 

.PHONY: all
all: poisson.bin

poisson.bin: poisson.F90 Makefile
	pgfortran $(COMPOPT) $(ACCOPT) poisson.F90 $(LIBDIRS) $(LIBS) -o poisson.bin

.PHONY: debug
debug: poisson.F90 Makefile
	pgfortran $(COMPOPT) -g $(ACCOPT) poisson.F90 $(LIBDIRS) $(LIBS) -o poisson.bin

.PHONY: run clean
run: poisson.bin
	$(JSC_SUBMIT_CMD) ./poisson.bin

clean:
	rm -f poisson.bin *.o
