#include "../PuntoPertenecia.h"



vector<Estado> vest;

vector<Recurso> vrec;

size_t num_pest;
size_t num_pmun;
size_t num_pageb;
size_t num_pmnz;

size_t num_prec;

// carga
extern int cargaArchivoEstado(string sarchivo, string sep, vector<Estado> &vest);

extern int cargaArchivoRecurso(string sarchivo, string sep, vector<Recurso> &vrec);

// manejo memoria host

void alojaMemoriaHost();

/**
 * @brief
 *
 * @param argc
 * @param argv
 * @return int
 */
int main(int argc, char **argv)
{

    //cout << argv[1] << endl;
    cargaArchivoEstado(argv[1], "|", vest);
    cout << "Total de poligonos de estado: " << vest.size() << endl;

    cargaArchivoRecurso(argv[5],"|",vrec);
    cout << "Total de recursos: " << vrec.size() << endl;
    return 0;
}

/**
 * @brief Función que alojala memoria del host
 *
 */
void alojaMemoriaHost()
{
}