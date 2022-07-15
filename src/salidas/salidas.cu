#include "../PuntoPertenecia.h"

/**
 * @brief 
 * 
 * @param prec 
 * @param num_prec 
 * @param snomarch 
 */
void salidaRecurso(PRecurso prec, size_t num_prec, string snomarch){

    std::ofstream miar(snomarch.c_str());

    if (miar.is_open()) {
        for(size_t i=0; i<num_prec; i++){
            PRecurso p = prec+i;
            miar << p->id<<"|"<<p->stipo<<"|"<<p->e<<"|"<<p->m<<"|"<<p->l<<"|"<<p->ne<<"|"<<p->nm<<"|"<<p->nl<<std::endl;
        }
    }

    miar.close();
}