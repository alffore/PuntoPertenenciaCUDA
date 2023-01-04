//
// Created by alfonso on 6/12/22.
//

#include "CCG2CCL.h"

/**
 *
 * @param sproyec1
 * @param sproyec2
 */
CCG2CCL::CCG2CCL(string sproyec1, string sproyec2):sproyec1(sproyec1),sproyec2(sproyec2) {
    C = proj_context_create();

    P = proj_create_crs_to_crs(C,sproyec1.c_str(),sproyec2.c_str(),NULL);

    if(P==0){
        cerr<<" Error en la creacion del objeto para la transformacion"<<endl;
    }

    norm = proj_normalize_for_visualization(C,P);

    if(norm == 0){
        cerr<<" Error no se puede normalizar el objeto transformación"<<endl;
    }

    proj_destroy(P);
    P = norm;
}

/**
 *
 */
CCG2CCL::~CCG2CCL() {

    proj_destroy(P);
    proj_context_destroy(C);

}

void CCG2CCL::convierte(double lon , double lat, double& este, double& norte) {
   PJ_COORD a = proj_coord(lon, lat, 0,0);
   PJ_COORD b = proj_trans(P,PJ_FWD,a);

   este = b.enu.e;
   norte= b.enu.n;
}
