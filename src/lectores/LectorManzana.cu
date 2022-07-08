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
    //std::cout<<vc[0]<<" "<<vc[1]<<std::endl;

    pmnz->nvertices=atoi(vc[1].c_str());
    pmnz->x=(float*)malloc(sizeof(float)*pmnz->nvertices);
    pmnz->y=(float*)malloc(sizeof(float)*pmnz->nvertices);

    pmnz->id=atoll(vc[3].c_str());

    vector<string> vsc;
    split(vsc, vc[2], ",");

    //std::cout<<pest->nvertices<<"::"<<vsc.size()<<std::endl;

    for(unsigned int i=0;i<pmnz->nvertices;i+=2){
        *(pmnz->x+i)=atof(vsc[i].c_str());
        *(pmnz->y+i)=atof(vsc[i+1].c_str());
    }
}
