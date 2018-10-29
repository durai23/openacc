all: run

spmv: spmv.F03 Makefile
	pgfortran -mp -r8 -fast -acc -ta=tesla -Minfo=accel spmv.F03 -o spmv

run: spmv
	./spmv

clean:
	rm -f spmv

