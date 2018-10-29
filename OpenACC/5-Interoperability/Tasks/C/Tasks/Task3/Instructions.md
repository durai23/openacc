# Interoperability: Task 3

This task uses the Thrust library to sum the elements of a vector which has been computed before by means of OpenACC

# Tasks

Check for the TODOs throughout the code in `vecAddRed.c` and `thrustWrapper.cu`.

The GPU-enabled call to `thrust::reduce()` should be implemented in `thrustWrapper.cu`. The wrapper function is defined as *extern* to prevent name mangling. Its call is to be implemented into `vecAddRed.c`.


Compile with `make`, run with `make run`.
