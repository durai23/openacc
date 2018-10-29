# Task 6: More Parallelism

We found out that the inner loop of the core double loop was never parallelized. Add the `vector` clause to indicate we want to use this level of parallelism on this loop.

Compile the program with `make`, submit it to the batch system with `make run`.
