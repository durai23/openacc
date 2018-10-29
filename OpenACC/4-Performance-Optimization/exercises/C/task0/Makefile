all: run

spmv: spmv.c Makefile
	pgcc -fast -acc -ta=tesla -Minfo=accel spmv.c -o spmv

run: spmv
	./spmv

clean:
	rm -f spmv

