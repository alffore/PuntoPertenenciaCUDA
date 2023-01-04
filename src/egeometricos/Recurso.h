#ifndef RECURSO_H
#define RECURSO_H

#include <string>

struct Recurso
{

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
    std::string sid_mnz;
    std::string sid_ageb;

    double rescal;
};

typedef struct Recurso *PRecurso;

#endif