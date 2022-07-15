#ifndef RECURSO_H
#define	RECURSO_H

#include <string>


struct Recurso{

    float x;
    float y;

    unsigned int id;

    std::string stipo;

        int e;
        int m;
        int l;

        int ne;
        int nm;
        int nl;

    int id_mnz;
    int id_ent;
    int id_mun;
};


typedef struct Recurso * PRecurso;

#endif