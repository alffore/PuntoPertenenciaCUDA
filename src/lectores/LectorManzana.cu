#include "../PuntoPertenecia.h"

extern void split(vector<string> &theStringVector, const string &theString, const string &theDelimiter);

int cargaArchivoManzana(string sarchivo,string sep,PManzana pmnz);
void parserManzana(string scad,string sep,PManzana pmnz);


/**
 * @brief 
 * 
 * @param sarchivo 
 * @param sep 
 * @param pmnz 
 * @return int 
 */
int cargaArchivoManzana(string sarchivo,string sep, PManzana pmnz){

    string sline;

    ifstream miarch;

    miarch.open(sarchivo.c_str(), ifstream::in);

    unsigned int i=0;
    while (getline(miarch, sline)) {
        parserManzana(sline,sep,pmnz+i);
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
void parserManzana(string scad,string sep,PManzana pmnz) {

    vector<string> vc;

    split(vc, scad, sep);
 
    pmnz->nvertices=atoi(vc[1].c_str());
    pmnz->x=(float*)malloc(sizeof(float)*pmnz->nvertices);
    pmnz->y=(float*)malloc(sizeof(float)*pmnz->nvertices);

    pmnz->sid=vc[3];

    pmnz->e=atoi(vc[4].c_str());
    pmnz->m=atoi(vc[5].c_str());
    pmnz->l=atoi(vc[6].c_str());

    vector<string> vsc;
    split(vsc, vc[2], ",");


    for(unsigned int i=0;i<pmnz->nvertices;i+=2){
        *(pmnz->x+i)=atof(vsc[i].c_str());
        *(pmnz->y+i)=atof(vsc[i+1].c_str());
    }
}
