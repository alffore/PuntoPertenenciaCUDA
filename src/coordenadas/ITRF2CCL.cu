//
// Created by alfonso on 6/12/22.
//

#include "ITRF2CCL.h"


/**
 * @brief Construct a new ITRF2CCL::ITRF2CCL object
 * 
 */
ITRF2CCL::ITRF2CCL() {


    phy1 = 0.30543262; //17.5 grados en rad
    phy2 = 0.51487213; //29.5 grados en rad

    phyf = 0.20943951; //12grados en rad
    lambdaf = -1.7802358; //102grados oeste en rad

    EF = 2.5E6; //este falso
    NF = 0; // norte falso

    a = 6378137.0; //radio terrestre
    f = 1.0 / 298.257222101; //factor
    e = 0.0818191910435; //excentricidad

    //calculo de m1
    m1 = sin(phy1);
    m1 *= e;
    m1 = pow(m1, 2);
    m1 = 1 - m1;
    m1 = sqrt(m1);
    m1 = 1 / m1;
    m1 *= cos(phy1);

    //calculo de m2
    m2 = 1 - pow(e * sin(phy2), 2);
    m2 = 1 / m2;
    m2 = sqrt(m2);
    m2 *= cos(phy2);

    //calculo de t1
    t1 = pow((1 - e * sin(phy1)) / (1 + e * sin(phy1)), e / 2);
    t1 = 1.0 / t1;
    t1 *= tan((M_PI / 4) - (phy1 / 2));

    //calculo de t2
    t2 = pow((1 - e * sin(phy2)) / (1 + e * sin(phy2)), e / 2);
    t2 = 1.0 / t2;
    t2 *= tan((M_PI / 4) - (phy2 / 2));

    //calculo de tf
    tf = pow((1 - e * sin(phyf)) / (1 + e * sin(phyf)), e / 2);
    tf = 1.0 / tf;
    tf *= tan((M_PI / 4) - (phyf / 2));

    //calculo de n
    n = (log(m1) - log(m2)) / (log(t1) - log(t2));

    //calculo de F
    F = m1 / (n * pow(t1, n));

    //calculo de rf
    rf = a * F * pow(tf, n);


}

/**
 * @brief 
 * 
 * @param latitud 
 * @param longitud 
 */
void ITRF2CCL::cDeg2PCCL(double latitud, double longitud) {

    this->cRad2PCCL(latitud * M_PI / 180.0, longitud * M_PI / 180);
}

/**
 * @brief 
 * 
 * @param latitud 
 * @param longitud 
 */
void ITRF2CCL::cRad2PCCL(double latitud, double longitud) {


    lambda = longitud;
    phy = latitud;

    //calculo de t
    t = pow((1 - e * sin(phy)) / (1 + e * sin(phy)), e / 2);
    t = 1.0 / t;
    t *= tan((M_PI / 4) - (phy / 2));

    //calculo de r
    r = a * F * pow(t, n);

    //calculo de theta
    theta = n * (lambda - lambdaf);

    //Calculo de las coordenadas de Lambert
    Este = EF + r * sin(theta);
    Norte = NF + rf - r * cos(theta);

}

double ITRF2CCL::obtenEste(){
    return Este;
}

double ITRF2CCL::obtenNorte(){
    return Norte;
}

ITRF2CCL::~ITRF2CCL() {
}

