#include <cuda.h>

#ifndef PUNTO_PERTENENCIA_CUDA_H
#define	PUNTO_PERTENENCIA_CUDA_H

// Recurso
struct DRec{
    long id_e,id_m,id_l;
    long id_ageb,id_mnz;
    float x;
    float y;
    float res;  //depuracion
};

typedef struct DRec* PDRec;

// Poligono entrada
struct __align__(8) DEP{
    float x;
    float y;
};

typedef struct DEP* PDEP;

// Referencia poligonos
struct DRefP{
    size_t ini;
    size_t fin;
};

typedef struct DRefP* PDRefP;

#endif