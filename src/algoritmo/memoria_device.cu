#include "../PuntoPertenecia.h"
#include "../PuntoPertenciaCUDA.h"


/**
 * @brief 
 * 
 * @param num_e Cantidad de elementos (poligonos)
 * @param num_v Cantidad de vertices 
 * @param h_pol Poligonos (array corrido de poligonos)
 * @param h_pdest  Punteros de referencia de los estados
 * @param d_pol 
 * @param d_pdest 
 */
void alojaMemoriaPolEstado(unsigned int num_e,long num_v, cuDoubleComplex *h_pol,PDEstado h_pdest, cuDoubleComplex *d_pol,PDEstado d_pdest){
    h_pol = (cuDoubleComplex *)malloc(sizeof(cuDoubleComplex)*num_v);
    h_pdest = (PDEstado) malloc(sizeof(DEstado)*num_e);
    cudaMalloc((void **) &d_pol, num_v*sizeof(cuDoubleComplex));
    cudaMalloc((void **) &d_pdest,num_e*sizeof(DEstado));
}

/**
 * @brief 
 * 
 * @param h_pol 
 * @param h_pdest 
 * @param d_pol 
 * @param d_pdest 
 */
void liberaMemoriaPolEstado(cuDoubleComplex *h_pol,PDEstado h_pdest,cuDoubleComplex *d_pol,PDEstado d_pdest){
    cudaFree(d_pdest);
    cudaFree(d_pol);
    free(h_pdest);
    free(h_pol);
}


/**
 * @brief Función que aloja la memoria de los puntos tanto HOST como DEVICE
 * 
 * @param num_r 
 * @param h_pdrec 
 * @param d_pdrec 
 */
void alojaMemoriaRecurso(unsigned int num_r, PDRec h_pdrec,PDRec d_pdrec){
    h_pdrec =(PDRec) malloc (sizeof(DRec)*num_r);
    cudaMalloc((void **)&d_pdrec,num_r*sizeof(DRec));
}

/**
 * @brief Función que libera la memoria de los recursos tanto de HOST como de DEVICE 
 * 
 * @param h_pdrec 
 * @param d_pdrec 
 */
void liberaMemoriaRecurso(PDRec h_pdrec,PDRec d_pdrec){
    cudaFree(d_pdrec);
    free(h_pdrec);
}