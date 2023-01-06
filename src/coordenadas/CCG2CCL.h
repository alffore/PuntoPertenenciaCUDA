//
// Created by alfonso on 6/12/22.
//

#ifndef PUNTOPERTENENCIA_CCG2CCL_H
#define PUNTOPERTENENCIA_CCG2CCL_H

#include <iostream>
#include <string>
#include <proj.h>

using namespace std;

class CCG2CCL {

private:

    string sproyec1;
    string sproyec2;

    PJ_CONTEXT *C;
    PJ *P;
    PJ *norm;



public:
    CCG2CCL(string sproyec1, string sproyec2);

    virtual ~ CCG2CCL();

    void convierte(float lon, float lat, float&este, float& norte);
};


#endif 
