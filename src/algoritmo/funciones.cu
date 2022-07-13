#include "../PuntoPertenecia.h"
#include "../PuntoPertenciaCUDA.h"



__global__ void kernel(){
    unsigned int tid = threadIdx.x;
    //unsigned int gtid = tid + blockIdx.x * blockSize;
    //const unsigned int gsize = blockSize * gridDim.x;
}



/**
 * @brief 
 * 
 * @return __device__ 
 */
__device__ cuDoubleComplex calculaIL(){

    cuDoubleComplex res;



    return res;
}

