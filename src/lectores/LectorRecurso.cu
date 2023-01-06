#include "../PuntoPertenecia.h"

#include "../coordenadas/CCG2CCL.h"


extern void split(vector<string> &theStringVector, const string &theString, const string &theDelimiter);


void parserRecurso(string scad,string sep,vector<Recurso> &vrec, CCG2CCL &mccg);


/**
 * @brief 
 * 
 * @param sarchivo 
 * @param sep 
 * @param prec 
 * @return int 
 */
int cargaArchivoRecurso(string sarchivo,string sep,vector<Recurso> &vrec){
  
    string sline;

    ifstream miarch;

    string sp1 = "EPSG:4326";
    string sp2 = "EPSG:6372";

    CCG2CCL c2c(sp1, sp2);

    miarch.open(sarchivo.c_str(), ifstream::in);


    while (getline(miarch, sline)) {
        parserRecurso(sline,sep,vrec,c2c);
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
void parserRecurso(string scad,string sep,vector<Recurso> &vrec, CCG2CCL &mccg) {

    Recurso rec;
    vector<string> vc;

    float este,norte;

    split(vc, scad, sep);

    mccg.convierte(atof(vc[0].c_str()),atof(vc[1].c_str()),este,norte);
        
    rec.p.x=este/10000;
    rec.p.y=norte/10000;

    rec.id = atoi(vc[2].c_str());
    rec.stipo=vc[3];

    rec.e=atoi(vc[4].c_str());
    rec.m=atoi(vc[5].c_str());
    rec.l=atoi(vc[6].c_str());

    rec.ne=0;
    rec.nm=0;
    rec.nl=0;

    vrec.push_back(rec);
}
