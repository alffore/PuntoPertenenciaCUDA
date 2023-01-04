#include "../PuntoPertenecia.h"
#include "../PuntoPertenciaCUDA.h"

long total_vertices_pest;

extern void split(vector<string> &theStringVector, const string &theString, const string &theDelimiter);

int cargaArchivoEstado(string sarchivo, string sep, PEstado pest);
void parserEstado(string scad, string sep, PEstado pest);

/*bool checacuCDC(cuDoubleComplex z1,cuDoubleComplex z2);
void parserEstado_v2(string scad,string sep,PEstado pest);*/

/**
 * @brief
 *
 * @param sarchivo
 * @param sep
 * @param pest
 * @return int
 */
int cargaArchivoEstado(string sarchivo, string sep, PEstado pest)
{

    string sline;

    ifstream miarch;

    miarch.open(sarchivo.c_str(), ifstream::in);

    unsigned int i = 0;
    while (getline(miarch, sline))
    {
        parserEstado(sline, sep, pest + i);
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
 */
void parserEstado(string scad, string sep, PEstado pest)
{

    vector<string> vc;

    split(vc, scad, sep);
    // std::cout<<vc[0]<<" "<<vc[1]<<std::endl;

    pest->nvertices = atoi(vc[1].c_str());
    total_vertices_pest += pest->nvertices;

    pest->x = (float *)malloc(sizeof(float) * pest->nvertices);
    pest->y = (float *)malloc(sizeof(float) * pest->nvertices);

    pest->id = atoi(vc[3].c_str());

    vector<string> vsc;
    split(vsc, vc[2], ",");

    cout << pest->nvertices << "::" << vsc.size() << endl;

    for (unsigned int j = 0; j < pest->nvertices; j++)
    {
        *(pest->x + j) = atof(vsc[2 * j].c_str()) / 10000;
        *(pest->y + j) = atof(vsc[2 * j + 1].c_str()) / 10000;
    }
}

/*
void parserEstado_v2(string scad,string sep,PEstado pest) {

    vector<string> vc;

    split(vc, scad, sep);

    unsigned int vertices = atoi(vc[1].c_str());

    pest->id=atoi(vc[3].c_str());

    vector<string> vsc;
    split(vsc, vc[2], ",");

    vector<cuDoubleComplex> v_c;


    for(unsigned int j =0; j<vertices; j++){

        v_c.push_back(make_cuDoubleComplex(atof(vsc[2*j].c_str())/1000,
        atof(vsc[2*j+1].c_str())/1000));

    }

    cout<<"e: " << pest->id<<" vector size: "<<v_c.size();

    v_c.erase(unique(v_c.begin(),v_c.end(),checacuCDC),v_c.end());

    cout<<" vector size unique erase: "<<v_c.size()<<endl;
}


bool checacuCDC(cuDoubleComplex z1,cuDoubleComplex z2){
    return (z1.x==z2.x && z1.y==z2.y);
}
*/