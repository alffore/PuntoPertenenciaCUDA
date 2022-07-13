#include "../PuntoPertenecia.h"


PRecurso prec;

PEstado pest;
PMunicipio pmun;
PManzana pmnz;


unsigned int num_pest;
unsigned int num_pmun;
unsigned int num_pmnz;
unsigned int num_prec;

extern long total_vertices_pest;

extern int cargaArchivoEstado(string sarchivo,string sep,PEstado pest);
extern int cargaArchivoMunicipio(string sarchivo,string sep,PMunicipio pmun);
extern int cargaArchivoManzana(string sarchivo,string sep,PManzana pmnz);
extern int cargaArchivoRecurso(string sarchivo,string sep,PRecurso prec);


void alojaMemoriaEstado(void);
void liberaMemoriaEstado(void);

void alojaMemoriaMunicipio(void);
void liberaMemoriaMunicipio(void);

void alojaMemoriaManzana(void);
void liberaMemoriaManzana(void);

void alojaMemoriaRecurso(void);
void liberaMemoriaRecurso(void);

/**
 * @brief 
 * 
 * @param argc 
 * @param argv 
 * @return int 
 */
int main(int argc, char **argv){

    num_pest = atoi((const char *)argv[1]);

    std::cout << "Pol. Estados: "<<num_pest<<std::endl;

    num_pmun = atoi((const char *)argv[3]);

    std::cout << "Pol. Municipios: "<<num_pmun<<std::endl;

    num_pmnz = atoi((const char *)argv[5]);

    std::cout << "Pol. Manzanas: "<<num_pmnz<<std::endl;

    num_prec = atoi((const char *)argv[7]); 

    std::cout << "Puntos Recursos: "<<num_prec<<std::endl;

    alojaMemoriaEstado();
    //alojaMemoriaMunicipio();
    //alojaMemoriaManzana();
    alojaMemoriaRecurso();

    cargaArchivoEstado(argv[2],"|",pest);
    //cargaArchivoMunicipio(argv[4],"|",pmun);
    //cargaArchivoManzana(argv[6],"|",pmnz);
    cargaArchivoRecurso(argv[8],"|",prec);


    std::cout<<"Vertices pol estados: "<<total_vertices_pest<< std::endl;




    liberaMemoriaRecurso();
    //liberaMemoriaManzana();
    //liberaMemoriaMunicipio();
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

/**
 * @brief 
 * 
 */
void alojaMemoriaRecurso(void){

    prec = (PRecurso) malloc(sizeof(struct Recurso)*num_prec);

}

/**
 * @brief 
 * 
 */
void liberaMemoriaRecurso(void){
    free(prec);
}