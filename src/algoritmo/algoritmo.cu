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
extern void alojaMemoriaPolEstado(unsigned int num_e,long num_v, cuDoubleComplex *pol,PDEstado pdest,cuDoubleComplex *d_pol,PDEstado d_pdest);
extern void liberaMemoriaPolEstado(cuDoubleComplex *pol,PDEstado pdest,cuDoubleComplex *d_pol,PDEstado d_pdest);

//manejo de la memoria de los recursos 
extern void alojaMemoriaRecurso(unsigned int num_r, PDRec h_pdrec,PDRec d_pdrec);
extern void liberaMemoriaRecurso(PDRec h_pdrec,PDRec d_pdrec);

//kernel CUDA

extern __global__ void kernel_pertencia_Estado(PDRec d_pdrec,PDEstado d_pestado,cuDoubleComplex *d_pol_edo, size_t num_r,size_t num_e);

//Poligonos

cuDoubleComplex *h_pol_edo;
cuDoubleComplex *d_pol_edo;

PDEstado h_pestado;
PDEstado d_pestado;

PDRec h_pdrec;
PDRec d_pdrec;


void copiaInfoEstado2Pol_CPU2DEV();
void copiaInfoRecurso2DRec_CPU2DEV();

/**
 * Funcion principal del algoritmo, recibe 
 * 
 * 
 */
void algoritmo(){

    int canti_hilos = 1024;
    int canti_bloques = (int) ceil((double) num_prec / canti_hilos) + 1;
    
    alojaMemoriaPolEstado(num_pest,total_vertices_pest,h_pol_edo,h_pestado,d_pol_edo,d_pestado);
    
    alojaMemoriaRecurso(num_prec,h_pdrec,d_pdrec);


    copiaInfoEstado2Pol_CPU2DEV();
    copiaInfoRecurso2DRec_CPU2DEV();

    kernel_pertencia_Estado<<<canti_bloques,canti_hilos>>>(d_pdrec,d_pestado,d_pol_edo,num_prec,num_pest);

    cudaMemcpy(h_pdrec,d_pdrec,num_prec*sizeof(DRec),cudaMemcpyDeviceToHost);

    for(size_t i=0;i<num_prec;i++){
        PRecurso pr = prec+i;
        PDRec pdr = h_pdrec+i;

        pr->ne=pdr->e;
        pr->nm=pdr->m;
        pr->nl=pdr->l;
    }

    liberaMemoriaRecurso(h_pdrec,d_pdrec);

    liberaMemoriaPolEstado(h_pol_edo,h_pestado,d_pol_edo,d_pestado);

}


/**
 * @brief 
 * 
 */
void copiaInfoEstado2Pol_CPU2DEV(){
    
    unsigned int ini=0;

    double x_max,y_max;
    double x_min,y_min;

    for(size_t i=0;i<num_pest;i++){
        PEstado p = (pest +i);
        PDEstado h_pde = (h_pestado+i);

        h_pde->e=p->id;
        h_pde->inicio = ini;
        h_pde->fin=ini+p->nvertices-1;

        ini=h_pde->fin+1;

        x_max=*(p->x);
        x_min=x_max;
        y_max=*(p->y);
        y_min=y_max;

        for(size_t j=0;j<p->nvertices;j++){
            (h_pol_edo+h_pde->inicio+j)->x=*(p->x+j);
            (h_pol_edo+h_pde->inicio+j)->y=*(p->y+j);

            x_max=(x_max<*(p->x+j))?*(p->x+j):x_max;
            x_min=(x_min>*(p->x+j))?*(p->x+j):x_min;

            y_max=(y_max<*(p->y+j))?*(p->y+j):y_max;
            y_min=(y_min>*(p->y+j))?*(p->y+j):y_min;
        }

        //cuadrangulo que inscribe el poligono con margen de seguridad
        h_pde->p_max.x=x_max*1.03;
        h_pde->p_max.y=y_max*1.03;

        h_pde->p_min.x=x_min*1.03;
        h_pde->p_min.y=y_min*1.03;

    }

    cudaMemcpy(d_pestado,h_pestado,num_pest*sizeof(DEstado),cudaMemcpyHostToDevice);
    cudaMemcpy(d_pol_edo,h_pol_edo,total_vertices_pest*sizeof(cuDoubleComplex),cudaMemcpyHostToDevice);

}

/**
 * @brief 
 * 
 */
void copiaInfoRecurso2DRec_CPU2DEV(){

    for(size_t i=0; i< num_prec ; i++){
        PRecurso pr =prec+i;
        PDRec h_pdr = h_pdrec+i;

        h_pdr->e=pr->e;
        h_pdr->m=pr->m;
        h_pdr->l=pr->l;

        h_pdr->p.x=pr->x;
        h_pdr->p.y=pr->y;
    }

    cudaMemcpy(d_pdrec,h_pdrec,num_prec*sizeof(DRec),cudaMemcpyHostToDevice);
}