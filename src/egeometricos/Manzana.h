#include <string>

#ifndef MANZANA_H
#define MANZANA_H

struct Manzana
{

    float *x;
    float *y;

    int nvertices;

    std::string sid;

    int e;
    int m;
    int l;
};

typedef struct Manzana *PManzana;

#endif