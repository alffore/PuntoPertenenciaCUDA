#include <string>

#ifndef AGEB_H
#define AGEB_H

struct Ageb
{
    float *x;
    float *y;

    int nvertices;

    std::string sid;

    int e;
    int m;
    int l;
};

typedef struct Ageb *PAgeb;

#endif
