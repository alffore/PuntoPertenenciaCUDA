#include "../PuntoPertenecia.h"

vector<Estado> vest;
vector<Municipio> vmun;
vector<Ageb> vageb;
vector<Manzana> vmnz;

vector<Recurso> vrec;

// carga
extern int cargaArchivoEstado(string sarchivo, string sep, vector<Estado> &vest);
extern int cargaArchivoMunicipio(string sarchivo, string sep, vector<Municipio> &vmun);
extern int cargaArchivoAgeb(string sarchivo, string sep, vector<Ageb> &vageb);
extern int cargaArchivoManzana(string sarchivo, string sep, vector<Manzana> &vmnz);

extern int cargaArchivoRecurso(string sarchivo, string sep, vector<Recurso> &vrec);

// manejo memoria host

void alojaMemoriaHost();


// Algortimo
extern void algoritmo();

/**
 * @brief
 *
 * @param argc
 * @param argv
 * @return int
 */
int main(int argc, char **argv)
{

    cargaArchivoEstado(argv[1], "|", vest);
    cout << "Total de poligonos de estado: " << vest.size() << endl;

    /*cargaArchivoMunicipio(argv[2], "|", vmun);
    cout << "Total de poligonos de municipio: " << vmun.size() << endl;

    cargaArchivoAgeb(argv[3], "|", vageb);
    cout << "Total de poligonos de AGEB: " << vageb.size() << endl;

    cargaArchivoManzana(argv[4], "|", vmnz);
    cout << "Total de poligonos de Manzana: " << vmnz.size() << endl;*/

    cargaArchivoRecurso(argv[5], "|", vrec);
    cout << "Total de recursos: " << vrec.size() << endl;


    
    algoritmo();





    return 0;
}

/**
 * @brief Función que alojala memoria del host
 *
 */
void alojaMemoriaHost()
{
}