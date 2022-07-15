
#include <cuda.h>
#include <cuComplex.h>


#ifndef PUNTO_PERTENENCIA_CUDA_H
#define	PUNTO_PERTENENCIA_CUDA_H


//recurso en dispositivo
struct DRec{
    int e,m,l;
    cuDoubleComplex p;
};

typedef struct DRec* PDRec;

//poligono de estado en dispositivo
struct DEstado{
    int e;
    unsigned int inicio;
    unsigned int fin;

    cuDoubleComplex p_max;
    cuDoubleComplex p_min;
};

typedef struct DEstado* PDEstado;


#endif