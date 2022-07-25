#include "../PuntoPertenecia.h"
#include "../PuntoPertenciaCUDA.h"


double sx_max, sy_max;
double sx_min, sy_min;


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

//debug
extern void debug_imprimeSegemntoPol(PDEstado h_pde,cuDoubleComplex *h_pol);

//memoria
void alojaMemoriaPolEstado();
void liberaMemoriaPolEstado();

//manejo de la memoria de los recursos 
void alojaMemoriaRecursoCUDA();
void liberaMemoriaRecursoCUDA();

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
    
    cout<<"Hilos: "<<canti_hilos<<" Bloques: "<<canti_bloques<<endl;

    sx_max =-1E10;
    sy_max =-1E10;

    sx_min = 1E10;
    sy_min = 1E10;


    alojaMemoriaPolEstado();
    
    alojaMemoriaRecursoCUDA();


    copiaInfoEstado2Pol_CPU2DEV();
    copiaInfoRecurso2DRec_CPU2DEV();


    cout << " coordendas globales sx_min: "<<sx_min<<" sy_min: "<<sy_min<<" sx_max: "<<sx_max<<" sy_max: "<<sy_max<<endl;


    kernel_pertencia_Estado<<<canti_bloques,canti_hilos>>>(d_pdrec,d_pestado,d_pol_edo,num_prec,num_pest);

    cudaMemcpy(h_pdrec,d_pdrec,num_prec*sizeof(DRec),cudaMemcpyDeviceToHost);

    for(size_t i=0;i<num_prec;i++){
        PRecurso pr = prec+i;
        PDRec pdr = h_pdrec+i;

        pr->ne=pdr->e;
        pr->nm=pdr->m;
        pr->nl=pdr->l;
        pr->rescal = pdr->res;

        cout<<"rec i:"<<i<<" rescal:"<<pr->rescal<<endl;
    }

    liberaMemoriaRecursoCUDA(); 

    liberaMemoriaPolEstado();

}


void alojaMemoriaPolEstado(){
    h_pol_edo = (cuDoubleComplex *)malloc(sizeof(cuDoubleComplex)*total_vertices_pest);
    h_pestado = (PDEstado) malloc(sizeof(DEstado)*num_pest);
    cudaMalloc((void **) &d_pol_edo, total_vertices_pest*sizeof(cuDoubleComplex));
    cudaMalloc((void **) &d_pestado,num_pest*sizeof(DEstado));
}

void liberaMemoriaPolEstado(){
    cudaFree(d_pestado);
    cudaFree(d_pol_edo);
    free(h_pestado);
    free(h_pol_edo);
}

void alojaMemoriaRecursoCUDA(){
    h_pdrec =(PDRec) malloc (sizeof(DRec)*num_prec);
    cudaMalloc((void **)&d_pdrec,num_prec*sizeof(DRec));
}

void liberaMemoriaRecursoCUDA(){
    cudaFree(d_pdrec);
    free(h_pdrec);
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
        //cout << "Poligono: "<< i<<endl;
        PEstado p = (pest +i);
        PDEstado h_pde = (h_pestado+i);

        if(p->nvertices<3){
            cout <<"Poligono incorrecto (2 o menos vertices): "<<p->id<<endl;
        }


        h_pde->e=p->id;
        h_pde->inicio = ini;
        h_pde->fin=ini+p->nvertices-1;

        if(h_pde->fin>total_vertices_pest){
            std::cerr<<"Asignación superior a lo dimensionado: "<<h_pde->fin<<", max:"<< total_vertices_pest<<endl;
            exit(1);
        }

        //cout <<"\t"<<h_pde->inicio<<" "<<h_pde->fin<<" "<<ini<<" TV: "<<total_vertices_pest<<endl;

        ini=h_pde->fin+1;

        x_max=*(p->x);
        x_min=x_max;
        y_max=*(p->y);
        y_min=y_max;

    
        for(size_t j=0;j<p->nvertices;j++){

            if(h_pde->inicio+j > total_vertices_pest){
                std::cerr<<"Asignación superior a lo dimensionado: "<<h_pde->inicio+j <<", max:"<< total_vertices_pest<<endl;
                exit(1);
            }

            cuDoubleComplex * auxh_pe = h_pol_edo+j+h_pde->inicio;
        
            double x=*(p->x+j);
            double y=*(p->y+j);

            auxh_pe->x=x;
            auxh_pe->y=y;

            x_max=(x_max<x)?x:x_max;
            x_min=(x_min>x)?x:x_min;

            y_max=(y_max<y)?y:y_max;
            y_min=(y_min>y)?y:y_min;


            sx_max=(sx_max<x_max)?x_max:sx_max;
            sy_max=(sy_max<y_max)?y_max:sy_max;
            sx_min=(sx_min>x_min)?x_min:sx_min;
            sy_min=(sy_min>y_min)?y_min:sy_min;
        }

        //cuadrangulo que inscribe el poligono con margen de seguridad
        h_pde->p_max.x=x_max*1.03;
        h_pde->p_max.y=y_max*1.03;

        h_pde->p_min.x=x_min*1.03;
        h_pde->p_min.y=y_min*1.03;
    

    }

    
    //debug_imprimeSegemntoPol(h_pestado+100,h_pol_edo);


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

        h_pdr->e=0;
        h_pdr->m=0;
        h_pdr->l=0;

        h_pdr->p.x=pr->x;
        h_pdr->p.y=pr->y;

        if(pr->x > sx_max || pr->x < sx_min || pr->y > sy_max || pr->y < sy_min){
            cout<<"Rec fuera de la region: "<<i <<" id: "<<pr->id<<" tipo: "<<pr->stipo<<" x:"<<pr->x<<" y:"<<pr->y<<endl;
        }
    }

    cudaMemcpy(d_pdrec,h_pdrec,num_prec*sizeof(DRec),cudaMemcpyHostToDevice);
}