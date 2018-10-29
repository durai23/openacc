#include <cuda.h>

__global__ void cudaVecAdd(
	double * __restrict__ a, 
	double * __restrict__ b, 
	double * __restrict__ c, 
	int n
) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;

    if (i < n) {
        c[i] = a[i] + b[i];
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
	cudaVecAdd<<<nBlocks, nThreads>>>(a, b, c, n);
}
