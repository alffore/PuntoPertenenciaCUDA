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

// kernel
extern __global__ void kernel_polpertenciaEstado(PDEP device_dep, PDRefP device_drefp, PDRec device_pdrec, size_t num_rec, size_t num_pol);

/**
 * @brief
 *
 */
void algoritmo()
{

    size_t tam_rec = vrec.size();

    int canti_hilos = 1024;
    int canti_bloques = (int)ceil((float)tam_rec / canti_hilos) + 1;

    alojaMemRecurso(vrec, host_pdrec, device_pdrec);

    alojaMemEstado(vest, host_dep, device_dep, host_drefp, device_drefp);

    // kernel estado
    kernel_polpertenciaEstado<<<canti_bloques, canti_hilos>>>(device_dep, device_drefp, device_pdrec, tam_rec, vest.size());

    liberaMemEstado(host_dep, device_dep, host_drefp, device_drefp);

    // kernel municipio

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
        if (id_e > 0)
        {
            vrec[i].ne = vest[id_e].id;
            vrec[i].res = (host_pdrec + i)->res;
        }
    }

    for (auto &r : vrec)
    {
        cout << "(" << r.stipo << "," << r.id << ") " << r.e << " " << r.ne << " " << r.res << endl;
    }
}