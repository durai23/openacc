#include <cuda.h>

#include <thrust/device_ptr.h>
#include <thrust/reduce.h>

extern "C" void thrustReduceWrapper(
	double * __restrict__ c,
	int n,
	float * sum
) {
	thrust::device_ptr<double> c_ptr = thrust::device_pointer_cast(c);
	// TODO: Call thrust::reduce using c_ptr (the length is n) and give thrust's output to the calling function by means of sum
	// Hint: thrust::reduce can use device_ptr address as InputIterators
	// Documentation: https://thrust.github.io/doc/group__reductions.html#ga69434d74f2e6117040fb38d1a28016c2
}
