#include "../PuntoPertenecia.h"
#include "../PuntoPertenciaCUDA.h"




/**
 * @brief Función auxiliar que calcula la integral de linea el plano complejo
 * 
 * 
 * @param punto 
 * @param ini 
 * @param fin 
 * @param d_pol 
 * @return 
 */
__device__ cuDoubleComplex calculaIL(cuDoubleComplex punto,size_t ini,size_t fin, cuDoubleComplex *d_pol){

    cuDoubleComplex res;    
    
    double tmax = 100;
    double delta = 1 / tmax;

    res.x=0;
    res.y=0;

    for(size_t i=ini;i<fin;i++){
        cuDoubleComplex z1=*(d_pol+i);
        cuDoubleComplex z_z=cuCsub(*(d_pol+i+1),z1);
        cuDoubleComplex aux_num=cuCmul(z_z,make_cuDoubleComplex(delta,0));

        for (double t = 0; t < 1; t += delta) {
            cuDoubleComplex aux_den=cuCmul(z_z,make_cuDoubleComplex(t,0));
            aux_den=cuCadd(aux_den,z1);
            aux_den=cuCsub(aux_den,punto);
            
            res=cuCadd(res,cuCdiv(aux_num,aux_den));
        }
    }



    return res;
}




/**
 * @brief Kernel que determina si un punto pertenece o no a un poligono
 * 
 * @param d_pdrec Puntero a puntos para checar pertenecia
 * @param d_pestado Puntero a indice de estados
 * @param d_pol_edo Puntero a coordenadas de poligonos
 * @param num_r Cantidad de recursos
 * @param num_e Cantidad de poligonos de estado
 * @return 
 */
__global__ void kernel_pertencia_Estado(PDRec d_pdrec,PDEstado d_pestado,cuDoubleComplex *d_pol_edo, size_t num_r,size_t num_e){
    unsigned int gtid = threadIdx.x + blockIdx.x * blockDim.x;
    
    if(gtid<num_r){
        PDRec pr=(d_pdrec+gtid);
        for(size_t i=0;i<num_e;i++){
            PDEstado pe=(d_pestado+i);
            if(pe->p_max.x >= pr->p.x && pe->p_max.y >= pr->p.y &&
               pe->p_min.x <= pr->p.x && pe->p_min.y <= pr->p.y){
               
                if(cuCabs(calculaIL(pr->p,pe->inicio,pe->fin,d_pol_edo))>0){
                    pr->e=pe->e;
                }
            }
        }
    }
}

