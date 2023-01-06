#include "../PuntoPertenecia.h"

extern void split(vector<string> &theStringVector, const string &theString, const string &theDelimiter);

int cargaArchivoMunicipio(string sarchivo, string sep, vector<Municipio> &vmun);
void parserMunicipio(string scad, string sep, vector<Municipio> &vmun);

/**
 * @brief
 *
 * @param sarchivo
 * @param sep
 * @param pmun
 * @return int
 */
int cargaArchivoMunicipio(string sarchivo, string sep, vector<Municipio> &vmun)
{

    string sline;

    ifstream miarch;

    miarch.open(sarchivo.c_str(), ifstream::in);

   
    while (getline(miarch, sline))
    {
        parserMunicipio(sline, sep, vmun);
        
    }

    miarch.close();

    return 0;
}

/**
 * @brief
 *
 * @param scad
 * @param sep
 * @param pmun
 */
void parserMunicipio(string scad, string sep, vector<Municipio> &vmun)
{
    Municipio mun;
    vector<string> vc;

    split(vc, scad, sep);

    mun.id = atoi(vc[3].c_str());

    vector<string> vsc;
    split(vsc, vc[2], ",");

    size_t num_2v = vsc.size() / 2;

    for (size_t j = 0; j < num_2v; j++)
    {
        Punto p;

        p.x = atof(vsc[2 * j].c_str()) / 10000;
        p.y = atof(vsc[2 * j + 1].c_str()) / 10000;

        mun.vp.push_back(p);
    }

    vmun.push_back(mun);
}
