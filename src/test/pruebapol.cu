#include "../PuntoPertenecia.h"
#include "../PuntoPertenciaCUDA.h"


void debug_imprimeConPEstado(PEstado pestado){

    cout<<"id: "<<pestado->id<<" #vertices: "<<pestado->nvertices<<endl;

    for(auto i=0;i<pestado->nvertices;i++){
        auto px = pestado->x;
        auto py = pestado->y;
        cout <<"\tc "<<i<<": "<<*(px+i)<<", "<<*(py+i)<<endl;
    }

}


void debug_imprimeSegemntoPol(PDEstado h_pde,cuDoubleComplex *h_pol){

    cout <<h_pde->inicio<<" => "<<h_pde->fin << endl;

    for(auto i = h_pde->inicio;i<h_pde->fin;i++){
        cout<<"\tc "<<i<<": "<<(h_pol+i)->x<<" "<<(h_pol+i)->y<<endl;
    }
}
