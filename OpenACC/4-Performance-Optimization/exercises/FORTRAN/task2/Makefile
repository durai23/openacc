all: run

spmv: spmv.F03 Makefile
	pgfortran -mp -r8 -fast -acc -ta=tesla:gv32mode -Minfo=accel spmv.F03 -o spmv

run: spmv
	./spmv

clean:
	rm -f spmv

