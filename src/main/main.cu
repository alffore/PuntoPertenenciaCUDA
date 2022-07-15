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


// carga
extern int cargaArchivoEstado(string sarchivo,string sep,PEstado pest);
extern int cargaArchivoMunicipio(string sarchivo,string sep,PMunicipio pmun);
extern int cargaArchivoManzana(string sarchivo,string sep,PManzana pmnz);
extern int cargaArchivoRecurso(string sarchivo,string sep,PRecurso prec);

// algoritmo
extern void algoritmo();

// salidas
extern void salidaRecurso(PRecurso prec, size_t num_prec, string snomarch);

// manejo de memoria 
extern void alojaMemoriaEstado(size_t num_pest, PEstado pest);
extern void liberaMemoriaEstado(size_t num_pest, PEstado pest);

extern void alojaMemoriaMunicipio(size_t num_pmun,PMunicipio pmun);
extern void liberaMemoriaMunicipio(size_t num_pmun,PMunicipio pmun);

extern void alojaMemoriaManzana(size_t num_pmnz,PManzana pmnz);
extern void liberaMemoriaManzana(size_t num_pmnz,PManzana pmnz);

extern void alojaMemoriaRecurso(size_t num_prec,PRecurso prec);
extern void liberaMemoriaRecurso(PRecurso prec);


string snomarch_edo="/home/alfonso/devel/renic.git/renic.git/utiles/checa_iter_cg/ver2/salida/problemas_ent_cuda.txt";

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

    alojaMemoriaEstado(num_pest,pest);
    //alojaMemoriaMunicipio();
    //alojaMemoriaManzana();
    alojaMemoriaRecurso(num_prec,prec);

    cargaArchivoEstado(argv[2],"|",pest);
    //cargaArchivoMunicipio(argv[4],"|",pmun);
    //cargaArchivoManzana(argv[6],"|",pmnz);
    cargaArchivoRecurso(argv[8],"|",prec);


    std::cout<<"Vertices pol estados: "<<total_vertices_pest<< std::endl;

    algoritmo();

    salidaRecurso(prec,num_prec,snomarch_edo);


    liberaMemoriaRecurso(prec);
    //liberaMemoriaManzana();
    //liberaMemoriaMunicipio();
    liberaMemoriaEstado(num_pest,pest);

    return 0;
}

