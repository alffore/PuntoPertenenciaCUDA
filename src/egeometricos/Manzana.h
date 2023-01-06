#ifndef MANZANA_H
#define MANZANA_H

#include <string>
#include <vector>
#include "Punto.h"

struct Manzana
{
    std::vector<Punto> vp;

    std::string sid;

    int e;
    int m;
    int l;
};

#endif