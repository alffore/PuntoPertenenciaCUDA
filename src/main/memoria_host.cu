#include "../PuntoPertenecia.h"


/**
 * @brief 
 * 
 */
void alojaMemoriaEstado(size_t num_pest, PEstado pest){
    pest = (PEstado) malloc(sizeof(struct Estado)*num_pest);
    for(unsigned int i=0;i<num_pest;i++){
        (pest+i)->nvertices=0;
        (pest+i)->x=NULL;
        (pest+i)->y=NULL;
    }
}


/**
 * @brief 
 * 
 */
void liberaMemoriaEstado(size_t num_pest, PEstado pest){

    for(unsigned int i=0;i<num_pest;i++){
        if((pest+i)->nvertices>0){
            //std::cout << "libera: "<<i<<std::endl;
            free((pest+i)->x);
            free((pest+i)->y);
        }
    }

    free(pest);
}

/**
 * @brief 
 * 
 */
void alojaMemoriaMunicipio(size_t num_pmun,PMunicipio pmun){
    pmun = (PMunicipio) malloc(sizeof(struct Municipio)*num_pmun);
    for(unsigned int i=0;i<num_pmun;i++){
        (pmun+i)->nvertices=0;
        (pmun+i)->x=NULL;
        (pmun+i)->y=NULL;
    }
}

/**
 * @brief 
 * 
 */
void liberaMemoriaMunicipio(size_t num_pmun,PMunicipio pmun){

    for(unsigned int i=0;i<num_pmun;i++){
        if((pmun+i)->nvertices>0){
            //std::cout << "libera: "<<i<<std::endl;
            free((pmun+i)->x);
            free((pmun+i)->y);
        }
    }

    free(pmun);
}

/**
 * @brief 
 * 
 */
void alojaMemoriaManzana(size_t num_pmnz,PManzana pmnz){
    pmnz = (PManzana) malloc(sizeof(struct Manzana)*num_pmnz);
    for(unsigned int i=0;i<num_pmnz;i++){
        (pmnz+i)->nvertices=0;
        (pmnz+i)->x=NULL;
        (pmnz+i)->y=NULL;
    }
}

/**
 * @brief 
 * 
 */
void liberaMemoriaManzana(size_t num_pmnz,PManzana pmnz){

    for(unsigned int i=0;i<num_pmnz;i++){
        if((pmnz+i)->nvertices>0){
            //std::cout << "libera: "<<i<<std::endl;
            free((pmnz+i)->x);
            free((pmnz+i)->y);
        }
    }

    free(pmnz);
}

/**
 * @brief 
 * 
 */
void alojaMemoriaRecurso(size_t num_prec,PRecurso prec){

    prec = (PRecurso) malloc(sizeof(struct Recurso)*num_prec);

}

/**
 * @brief 
 * 
 */
void liberaMemoriaRecurso(PRecurso prec){
    free(prec);
}