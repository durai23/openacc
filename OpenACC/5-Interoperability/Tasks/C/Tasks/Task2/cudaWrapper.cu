#include <cuda.h>

__global__ void cudaVecAdd(
	double * __restrict__ a, 
	double * __restrict__ b, 
	double * __restrict__ c, 
	int n
) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;

    if (i < n) {
        // TODO: Calculate c = a + b for element i
        //
        // Hint: This is as easy as it sounds
    }
}

extern "C" void cudaVecAddWrapper(
	double * __restrict__ a, 
	double * __restrict__ b, 
	double * __restrict__ c, 
	int n,
	int nThreads,
	int nBlocks
) {
	// TODO: Call cudaVecAdd with nBlocks blocks and nThreads threads
}
