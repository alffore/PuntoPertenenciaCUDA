#include "../PuntoPertenecia.h"


PPunto ppuntos;

PEstado pest;
PMunicipio pmun;
PManzana pmnz;


unsigned int num_pest;
unsigned int num_pmun;
unsigned int num_pmnz;
unsigned int num_puntos;


extern int cargaArchivoEstado(string sarchivo,string sep,PEstado pest);
extern int cargaArchivoMunicipio(string sarchivo,string sep,PMunicipio pmun);
extern int cargaArchivoManzana(string sarchivo,string sep,PManzana pmnz);


void alojaMemoriaEstado(void);
void liberaMemoriaEstado(void);

void alojaMemoriaMunicipio(void);
void liberaMemoriaMunicipio(void);

void alojaMemoriaManzana(void);
void liberaMemoriaManzana(void);



/**
 * @brief 
 * 
 * @param argc 
 * @param argv 
 * @return int 
 */
int main(int argc, char **argv){

    num_pest = atoi((const char *)argv[1]);

    std::cout << "P. Estados "<<num_pest<<std::endl;

    num_pmun = atoi((const char *)argv[3]);

    std::cout << "P. Municipios "<<num_pmun<<std::endl;

    num_pmnz = atoi((const char *)argv[5]);

    std::cout << "P. Manzanas "<<num_pmnz<<std::endl;


    alojaMemoriaEstado();
    alojaMemoriaMunicipio();
    alojaMemoriaManzana();

    cargaArchivoEstado(argv[2],"|",pest);
    cargaArchivoMunicipio(argv[4],"|",pmun);
    cargaArchivoManzana(argv[6],"|",pmnz);

    

    liberaMemoriaManzana();
    liberaMemoriaMunicipio();
    liberaMemoriaEstado();

    return 0;
}


/**
 * @brief 
 * 
 */
void alojaMemoriaEstado(void){
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
void liberaMemoriaEstado(void){

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
void alojaMemoriaMunicipio(void){
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
void liberaMemoriaMunicipio(void){

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
void alojaMemoriaManzana(void){
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
void liberaMemoriaManzana(void){

    for(unsigned int i=0;i<num_pmnz;i++){
        if((pmnz+i)->nvertices>0){
            //std::cout << "libera: "<<i<<std::endl;
            free((pmnz+i)->x);
            free((pmnz+i)->y);
        }
    }

    free(pmnz);
}