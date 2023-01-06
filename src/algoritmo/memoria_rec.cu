#include "../PuntoPertenecia.h"
#include "../PuntoPertenciaCUDA.h"

void alojaMemRecurso(vector<Recurso> &vrec, PDRec &host_pdrec, PDRec &device_pdrec);
void liberaMemRecurso(PDRec &host_pdrec, PDRec &device_pdrec);

/**
 * @brief
 *
 * @param vrec
 * @param host_pdrec
 * @param device_pdrec
 */
void alojaMemRecurso(vector<Recurso> &vrec, PDRec &host_pdrec, PDRec &device_pdrec)
{
    size_t tam = vrec.size();

    host_pdrec = (PDRec)malloc(tam * sizeof(DRec));

    for (size_t i = 0; i < tam; i++)
    {
        (host_pdrec + i)->id_e = -1;
        (host_pdrec + i)->id_m = -1;
        (host_pdrec + i)->id_l = -1;

        (host_pdrec + i)->id_ageb = -1;
        (host_pdrec + i)->id_mnz = -1;

        (host_pdrec + i)->x = vrec[i].p.x;
        (host_pdrec + i)->y = vrec[i].p.y;
    }

    cudaMalloc((void **)&device_pdrec, tam * sizeof(DRec));
    cudaMemcpy(device_pdrec, host_pdrec, tam * sizeof(DRec), cudaMemcpyHostToDevice);
}

/**
 * @brief
 *
 * @param host_pdrec
 * @param device_pdrec
 */
void liberaMemRecurso(PDRec &host_pdrec, PDRec &device_pdrec)
{
    cudaFree(device_pdrec);
    free(host_pdrec);
}