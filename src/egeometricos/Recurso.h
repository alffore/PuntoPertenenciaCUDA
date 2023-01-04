#ifndef RECURSO_H
#define RECURSO_H

#include <string>
#include "Punto.h"

struct Recurso
{

    Punto p;

    unsigned int id;

    std::string stipo;

    int e;
    int m;
    int l;

    int ne;
    int nm;
    int nl;

    std::string sid_mnz;
    std::string sid_ageb;


};



#endif