#include "../PuntoPertenecia.h"

extern void split(vector<string> &theStringVector, const string &theString, const string &theDelimiter);

int cargaArchivoManzana(string sarchivo, string sep, vector<Manzana> &vmnz);
void parserManzana(string scad, string sep, vector<Manzana> &vmnz);

/**
 * @brief
 *
 * @param sarchivo
 * @param sep
 * @param pmnz
 * @return int
 */
int cargaArchivoManzana(string sarchivo, string sep, vector<Manzana> &vmnz)
{

    string sline;

    ifstream miarch;

    miarch.open(sarchivo.c_str(), ifstream::in);

    unsigned int i = 0;
    while (getline(miarch, sline))
    {
        parserManzana(sline, sep, vmnz);
        i++;
    }

    miarch.close();

    return 0;
}

/**
 * @brief
 *
 * @param scad
 * @param sep
 * @param pmnz
 */
void parserManzana(string scad, string sep, vector<Manzana> &vmnz)
{
    Manzana mnz;

    vector<string> vc;

    split(vc, scad, sep);

    mnz.sid = vc[3];

    mnz.e = atoi(vc[4].c_str());
    mnz.m = atoi(vc[5].c_str());
    mnz.l = atoi(vc[6].c_str());

    vector<string> vsc;
    split(vsc, vc[2], ",");

    size_t num_2v = vsc.size() / 2;

    for (size_t j = 0; j < num_2v; j++)
    {
        Punto p;

        p.x = atof(vsc[2 * j].c_str()) / 10000;
        p.y = atof(vsc[2 * j + 1].c_str()) / 10000;

        mnz.vp.push_back(p);
    }

    vmnz.push_back(mnz);
}
