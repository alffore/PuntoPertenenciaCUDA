#include "../PuntoPertenecia.h"

extern void split(vector<string> &theStringVector, const string &theString, const string &theDelimiter);

int cargaArchivoMunicipio(string sarchivo,string sep,PMunicipio pmun);
void parserMunicipio(string scad,string sep,PMunicipio pmun);


/**
 * @brief 
 * 
 * @param sarchivo 
 * @param sep 
 * @param pmun 
 * @return int 
 */
int cargaArchivoMunicipio(string sarchivo,string sep, PMunicipio pmun){

    string sline;

    ifstream miarch;

    miarch.open(sarchivo.c_str(), ifstream::in);

    unsigned int i=0;
    while (getline(miarch, sline)) {
        parserMunicipio(sline,sep,pmun+i);
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
 * @param pmun 
 */
void parserMunicipio(string scad,string sep,PMunicipio pmun) {

    vector<string> vc;

    split(vc, scad, sep);


    pmun->nvertices=atoi(vc[1].c_str());
    pmun->x=(float*)malloc(sizeof(float)*pmun->nvertices);
    pmun->y=(float*)malloc(sizeof(float)*pmun->nvertices);

    pmun->id=atoi(vc[3].c_str());

    vector<string> vsc;
    split(vsc, vc[2], ",");


    for(unsigned int i=0;i<pmun->nvertices;i+=2){
        *(pmun->x+i)=atof(vsc[i].c_str());
        *(pmun->y+i)=atof(vsc[i+1].c_str());
    }
}
