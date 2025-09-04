#include "../PuntoPertenciaCUDA.h"
#include "../PuntoPertenecia.h"

extern vector<Recurso> vrec;

extern vector<Estado> vest;
extern vector<Municipio> vmun;
extern vector<Ageb> vageb;
extern vector<Manzana> vmnz;

PDRec host_pdrec = nullptr;
PDRec device_pdrec = nullptr;

PDEP host_dep = nullptr;
PDEP device_dep = nullptr;

PDRefP host_drefp = nullptr;
PDRefP device_drefp = nullptr;

void algoritmo();
void marcaRecursos();

// Aloja memoria
extern void alojaMemRecurso(vector<Recurso> &vrec, PDRec &host_pdrec, PDRec &device_pdrec);
extern void liberaMemRecurso(PDRec &host_pdrec, PDRec &device_pdrec);

extern void alojaMemEstado(vector<Estado> &vest, PDEP &host_dep, PDEP &device_dep, PDRefP &host_drefp, PDRefP &device_drefp);
extern void liberaMemEstado(PDEP &host_dep, PDEP &device_dep, PDRefP &host_drefp, PDRefP &device_drefp);

extern void alojaMemMunicipio(vector<Municipio> &vmun, PDEP &host_dep, PDEP &device_dep, PDRefP &host_drefp, PDRefP &device_drefp);
extern void liberaMemMunicipio(PDEP &host_dep, PDEP &device_dep, PDRefP &host_drefp, PDRefP &device_drefp);

extern void alojaMemAGEB(vector<Ageb> &vageb, PDEP &host_dep, PDEP &device_dep, PDRefP &host_drefp, PDRefP &device_drefp);
extern void liberaMemAGEB(PDEP &host_dep, PDEP &device_dep, PDRefP &host_drefp, PDRefP &device_drefp);

extern void alojaMemMNZ(vector<Manzana> &vmnz, PDEP &host_dep, PDEP &device_dep, PDRefP &host_drefp, PDRefP &device_drefp);
extern void liberaMemMNZ(PDEP &host_dep, PDEP &device_dep, PDRefP &host_drefp, PDRefP &device_drefp);

// kernel
extern __global__ void kernel_polpertenciaEstado(PDEP device_dep, PDRefP device_drefp, PDRec device_pdrec, size_t num_rec, size_t num_pol);
extern __global__ void kernel_polpertenciaMunicipio(PDEP device_dep, PDRefP device_drefp, PDRec device_pdrec, size_t num_rec, size_t num_pol);
extern __global__ void kernel_polpertenciaAGEB(PDEP device_dep, PDRefP device_drefp, PDRec device_pdrec, size_t num_rec, size_t ini_pol, size_t fin_pol);
extern __global__ void kernel_polpertenciaMNZ(PDEP device_dep, PDRefP device_drefp, PDRec device_pdrec, size_t num_rec, size_t ini_pol, size_t fin_pol);

/**
 * @brief
 *
 */
void algoritmo()
{
    cudaSetDevice(1);
    size_t tam_rec = vrec.size();

    int canti_hilos = 1024;
    int canti_bloques = (int)ceil((float)tam_rec / canti_hilos) + 1;

    alojaMemRecurso(vrec, host_pdrec, device_pdrec);

    // kernel estado
    alojaMemEstado(vest, host_dep, device_dep, host_drefp, device_drefp);
    kernel_polpertenciaEstado<<<canti_bloques, canti_hilos>>>(device_dep, device_drefp, device_pdrec, tam_rec, vest.size());
    liberaMemEstado(host_dep, device_dep, host_drefp, device_drefp);

    // kernel municipio
    alojaMemMunicipio(vmun, host_dep, device_dep, host_drefp, device_drefp);
    kernel_polpertenciaMunicipio<<<canti_bloques, canti_hilos>>>(device_dep, device_drefp, device_pdrec, tam_rec, vmun.size());
    liberaMemMunicipio(host_dep, device_dep, host_drefp, device_drefp);

    //kernel ageb
    size_t corte=(size_t)vageb.size()/2;
    alojaMemAGEB(vageb, host_dep,device_dep, host_drefp, device_drefp);
    kernel_polpertenciaAGEB<<<canti_bloques, canti_hilos>>>(device_dep, device_drefp, device_pdrec, tam_rec, 0,corte);
    liberaMemAGEB(host_dep, device_dep, host_drefp, device_drefp);
   
    alojaMemAGEB(vageb, host_dep,device_dep, host_drefp, device_drefp);
    kernel_polpertenciaAGEB<<<canti_bloques, canti_hilos>>>(device_dep, device_drefp, device_pdrec, tam_rec, corte,vageb.size());
    liberaMemAGEB(host_dep, device_dep, host_drefp, device_drefp);

    //kernel Manzanas
    alojaMemMNZ(vmnz, host_dep,device_dep, host_drefp, device_drefp);
    kernel_polpertenciaMNZ<<<canti_bloques, canti_hilos>>>(device_dep, device_drefp, device_pdrec, tam_rec, 0,/*50000*/vmnz.size());
    liberaMemMNZ(host_dep, device_dep, host_drefp, device_drefp);

    // recuperamos la memoria de los recursos
    cudaMemcpy(host_pdrec, device_pdrec, tam_rec * sizeof(DRec), cudaMemcpyDeviceToHost);

    marcaRecursos();

    liberaMemRecurso(host_pdrec, device_pdrec);
}

/**
 * @brief
 *
 */
void marcaRecursos()
{

    size_t tam = vrec.size();

    for (size_t i = 0; i < tam; i++)
    {
        long id_e = (host_pdrec + i)->id_e;
        if (id_e >= 0)
        {
            vrec[i].ne = vest[id_e].id;
            vrec[i].res = (host_pdrec + i)->res;
        }

        long id_m = (host_pdrec + i)->id_m;
        if (id_m >= 0)
        {
            vrec[i].nm = vmun[id_m].id -vrec[i].ne*1000;
            vrec[i].res = (host_pdrec + i)->res;
        }

        long id_ageb = (host_pdrec + i)->id_ageb;
        if(id_ageb >=0){
            vrec[i].ne= vageb[id_ageb].e;
            vrec[i].nm= vageb[id_ageb].m;
            vrec[i].nl= vageb[id_ageb].l;
            vrec[i].sid_ageb = vageb[id_ageb].sid;
            vrec[i].res = (host_pdrec + i)->res;
        }

        long id_mnz =(host_pdrec + i)->id_mnz;
        if(id_mnz>=0){
            vrec[i].ne= vmnz[id_mnz].e;
            vrec[i].nm= vmnz[id_mnz].m;
            vrec[i].nl= vmnz[id_mnz].l;
            vrec[i].sid_mnz = vmnz[id_mnz].sid;
            vrec[i].res = (host_pdrec + i)->res;
        }
    }

    // Guardamos resultados
    ofstream ofs("resultados.csv");
    ofs << "tipo,id,e,m,l,ne,nm,nl,ageb_sid,mnz_sid,res" << endl;
    for (auto &r : vrec)
    {
        ofs  << "" << r.stipo << "," << r.id << ","
             << r.e << "," << r.m << ","<<r.l<<","
             << r.ne << "," << r.nm << ","<<r.nl<< ","<<r.sid_ageb<<","<<r.sid_mnz<<","
             << r.res << endl;
    }
    ofs.close();
}