#include "../PuntoPertenecia.h"


long total_vertices_pest;


extern void split(vector<string> &theStringVector, const string &theString, const string &theDelimiter);


int cargaArchivoEstado(string sarchivo,string sep,PEstado pest);
void parserEstado(string scad,string sep,PEstado pest);


/**
 * @brief 
 * 
 * @param sarchivo 
 * @param sep 
 * @param pest 
 * @return int 
 */
int cargaArchivoEstado(string sarchivo,string sep, PEstado pest){

    string sline;

    ifstream miarch;

    miarch.open(sarchivo.c_str(), ifstream::in);

    unsigned int i=0;
    while (getline(miarch, sline)) {
        parserEstado(sline,sep,pest+i);
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
void parserEstado(string scad,string sep,PEstado pest) {

    vector<string> vc;

    split(vc, scad, sep);
    //std::cout<<vc[0]<<" "<<vc[1]<<std::endl;

    pest->nvertices=atoi(vc[1].c_str());
    total_vertices_pest+=pest->nvertices;

    pest->x=(float*)malloc(sizeof(float)*pest->nvertices);
    pest->y=(float*)malloc(sizeof(float)*pest->nvertices);

    pest->id=atoi(vc[3].c_str());

    vector<string> vsc;
    split(vsc, vc[2], ",");

    cout<<pest->nvertices<<"::"<<vsc.size()<<std::endl;

    /*for(unsigned int i=0;i<pest->nvertices;i+=2){
        unsigned int j= (unsigned int)i/2;
        *(pest->x+j)=atof(vsc[i].c_str());
        *(pest->y+j)=atof(vsc[i+1].c_str());
    }*/

    for(unsigned int j=0;j<pest->nvertices;j++){
        
        *(pest->x+j)=atof(vsc[2*j].c_str());
        *(pest->y+j)=atof(vsc[2*j+1].c_str());
    }
}
