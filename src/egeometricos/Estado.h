#ifndef ESTADO_H
#define ESTADO_H

struct Estado
{

    float *x;
    float *y;

    int nvertices;
    int id;
};

typedef struct Estado *PEstado;

#endif