#include "../PuntoPertenecia.h"

#include "../coordenadas/CCG2CCL.h"


extern void split(vector<string> &theStringVector, const string &theString, const string &theDelimiter);


void parserRecursov2(string scad,string sep,PRecurso prec, CCG2CCL &mccg);


/**
 * @brief 
 * 
 * @param sarchivo 
 * @param sep 
 * @param prec 
 * @return int 
 */
int cargaArchivoRecurso(string sarchivo,string sep,PRecurso prec){
  
    string sline;

    ifstream miarch;

    //ITRF2CCL mtc;

    string sp1 = "EPSG:4326";
    string sp2 = "EPSG:6372";

    CCG2CCL c2c(sp1, sp2);

    miarch.open(sarchivo.c_str(), ifstream::in);

    unsigned int i=0;
    while (getline(miarch, sline)) {

        parserRecursov2(sline,sep,prec+i,c2c);
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
 * @param prec 
 * @param mccg 
 */
void parserRecursov2(string scad,string sep,PRecurso prec, CCG2CCL &mccg) {

    vector<string> vc;

    double este,norte;

    split(vc, scad, sep);

    mccg.convierte(atof(vc[0].c_str()),atof(vc[1].c_str()),este,norte);
        
    prec->x=este/10000;
    prec->y=norte/10000;

    prec->id = atoi(vc[2].c_str());
    prec->stipo=vc[3];

    prec->e=atoi(vc[4].c_str());
    prec->m=atoi(vc[5].c_str());
    prec->l=atoi(vc[6].c_str());

    prec->ne=0;
    prec->nm=0;
    prec->nl=0;

    prec->rescal =-1;

}