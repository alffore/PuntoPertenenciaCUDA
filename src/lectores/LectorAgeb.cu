#include "../PuntoPertenecia.h"

extern void split(vector<string> &theStringVector, const string &theString, const string &theDelimiter);

int cargaArchivoAgeb(string sarchivo, string sep, vector<Ageb> &vageb);
void parserAgeb(string scad, string sep, vector<Ageb> &vageb);

/**
 * @brief
 *
 * @param sarchivo
 * @param sep
 * @param vageb
 * @return int
 */
int cargaArchivoAgeb(string sarchivo, string sep, vector<Ageb> &vageb)
{

    string sline;

    ifstream miarch;

    miarch.open(sarchivo.c_str(), ifstream::in);

    while (getline(miarch, sline))
    {
        parserAgeb(sline, sep, vageb);
    }

    miarch.close();

    return 0;
}

/**
 * @brief
 *
 * @param scad
 * @param sep
 * @param vageb
 */
void parserAgeb(string scad, string sep, vector<Ageb> &vageb)
{
    Ageb ageb;

    vector<string> vc;

    split(vc, scad, sep);

    ageb.sid = vc[3];
    ageb.e = atoi(vc[4].c_str());
    ageb.m = atoi(vc[5].c_str());
    ageb.l = atoi(vc[6].c_str());

    vector<string> vsc;
    split(vsc, vc[2], ",");

    size_t num_2v = vsc.size() / 2;

    for (size_t j = 0; j < num_2v; j++)
    {
        Punto p;

        p.x = atof(vsc[2 * j].c_str()) / 10000;
        p.y = atof(vsc[2 * j + 1].c_str()) / 10000;

        ageb.vp.push_back(p);
    }

    vageb.push_back(ageb);
}