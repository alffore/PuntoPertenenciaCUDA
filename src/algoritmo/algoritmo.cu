#include "../PuntoPertenecia.h"
#include "../PuntoPertenciaCUDA.h"

//datos objetos
extern PRecurso prec;

extern PEstado pest;
extern PMunicipio pmun;
extern PManzana pmnz;

extern unsigned int num_pest;
extern unsigned int num_pmun;
extern unsigned int num_pmnz;
extern unsigned int num_prec;


extern long total_vertices_pest;

//memoria
extern void alojaMemoriaPolEstado_CPU(unsigned int num_e,long num_v, cuDoubleComplex *pol,PDEstado pdest);
extern void liberaMemoriaPolEstado_CPU(cuDoubleComplex *pol,PDEstado pdest);
extern void alojaMemoriaPolEstado_DEV(unsigned int num_e,long num_v, cuDoubleComplex *d_pol,PDEstado d_pdest);
extern void liberaMemoriaPolEstado_DEV(cuDoubleComplex *d_pol,PDEstado d_pdest);

//Poligonos

cuDoubleComplex *h_pol_edo;
cuDoubleComplex *d_pol_edo;

PDEstado h_pestado;
PDEstado d_pestado;


void copiaInfoEstadoaPol_CPU2DEV();


/**
 * Funcion principal del algoritmo, recibe 
 * 
 * 
 */
void algoritmo(){
    
    alojaMemoriaPolEstado_CPU(num_pest,total_vertices_pest,h_pol_edo,h_pestado);
    alojaMemoriaPolEstado_DEV(num_pest,total_vertices_pest,d_pol_edo,d_pestado);

    copiaInfoEstadoaPol_CPU2DEV();


    liberaMemoriaPolEstado_DEV(d_pol_edo,d_pestado);
    liberaMemoriaPolEstado_CPU(h_pol_edo,h_pestado);

}


/**
 * @brief 
 * 
 */
void copiaInfoEstadoaPol_CPU2DEV(){
    
    unsigned int ini=0;

    for(size_t i=0;i<num_pest;i++){
        PEstado p = (pest +i);
        PDEstado hp = (h_pestado+i);

        hp->e=p->id;
        hp->inicio = ini;
        hp->fin=ini+p->nvertices-1;

        ini=hp->fin+1;

        for(size_t j=0;j<p->nvertices;j++){
            (h_pol_edo+hp->inicio+j)->x=*(p->x+j);
            (h_pol_edo+hp->inicio+j)->y=*(p->y+j);
        }

    }

    cudaMemcpy(d_pestado,h_pestado,num_pest*sizeof(DEstado),cudaMemcpyHostToDevice);
    cudaMemcpy(d_pol_edo,h_pol_edo,total_vertices_pest*sizeof(cuDoubleComplex),cudaMemcpyHostToDevice);

}
