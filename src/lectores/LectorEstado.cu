#include "../PuntoPertenecia.h"

extern void split(vector<string> &theStringVector, const string &theString, const string &theDelimiter);

int cargaArchivoEstado(string sarchivo, string sep, vector<Estado> &vest);
void parserEstado(string scad, string sep, vector<Estado> &vest);

/**
 * @brief
 *
 * @param sarchivo
 * @param sep
 * @param vest
 * @return int
 */
int cargaArchivoEstado(string sarchivo, string sep, vector<Estado> &vest)
{

    string sline;

    ifstream miarch;

    miarch.open(sarchivo.c_str(), ifstream::in);


    while (getline(miarch, sline))
    {
        parserEstado(sline, sep, vest);

    }

    miarch.close();
    return 0;
}

/**
 * @brief
 *
 * @param scad
 * @param sep
 * @param vest
 */
void parserEstado(string scad, string sep, vector<Estado> &vest)
{
    Estado est;

    vector<string> vc;
    split(vc, scad, sep);

    est.id = atoi(vc[3].c_str());

    vector<string> vsc;
    split(vsc, vc[2], ",");

    size_t num_2v = vsc.size() / 2;

    for (size_t j = 0; j < num_2v; j++)
    {
        Punto p;

        p.x = atof(vsc[2 * j].c_str()) / 10000;
        p.y = atof(vsc[2 * j + 1].c_str()) / 10000;

        est.vp.push_back(p);
    }

    vest.push_back(est);
}