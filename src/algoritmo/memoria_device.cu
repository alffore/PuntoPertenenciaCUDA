#include "../PuntoPertenecia.h"
#include "../PuntoPertenciaCUDA.h"


/**
 * @brief 
 * 
 * @param num_e Cantidad de elementos (poligonos)
 * @param num_v Cantidad de vertices 
 * @param pol Poligonos (array corrido de poligonos)
 * @param pdest  Punteros de referencia de los estados
 */
void alojaMemoriaPolEstado_CPU(unsigned int num_e,long num_v, cuDoubleComplex *pol,PDEstado pdest){
    pol = (cuDoubleComplex *)malloc(sizeof(cuDoubleComplex)*num_v);
    pdest = (PDEstado) malloc(sizeof(DEstado)*num_e);
}

/**
 * @brief 
 * 
 * @param pol 
 * @param pdest 
 */
void liberaMemoriaPolEstado_CPU(cuDoubleComplex *pol,PDEstado pdest){
    free(pdest);
    free(pol);
}

/**
 * @brief 
 * 
 * @param num_e 
 * @param num_v 
 * @param d_pol 
 * @param d_pdest 
 */
void alojaMemoriaPolEstado_DEV(unsigned int num_e,long num_v, cuDoubleComplex *d_pol,PDEstado d_pdest){
   cudaMalloc((void **)&d_pol, num_v*sizeof(cuDoubleComplex));
   cudaMalloc((void **)&d_pdest,num_e*sizeof(DEstado));
}

/**
 * @brief 
 * 
 * @param d_pol 
 * @param d_pdest 
 */
void liberaMemoriaPolEstado_DEV(cuDoubleComplex *d_pol,PDEstado d_pdest){
    cudaFree(d_pdest);
    cudaFree(d_pol);
}