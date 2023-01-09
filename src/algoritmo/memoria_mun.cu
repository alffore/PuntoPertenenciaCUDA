#include "../PuntoPertenecia.h"
#include "../PuntoPertenciaCUDA.h"

void alojaMemMunicipio(vector<Municipio> &vmun, PDEP &host_dep, PDEP &device_dep, PDRefP &host_drefp, PDRefP &device_drefp);
void liberaMemMunicipio(PDEP &host_dep, PDEP &device_dep, PDRefP &host_drefp, PDRefP &device_drefp);

/**
 * @brief
 *
 * @param vmun
 * @param host_dep
 * @param device_dep
 * @param host_drefp
 * @param device_drefp
 */
void alojaMemMunicipio(vector<Municipio> &vmun, PDEP &host_dep, PDEP &device_dep, PDRefP &host_drefp, PDRefP &device_drefp)
{
    size_t tam_pol = vmun.size();
    size_t tam_coord = 0;

    host_drefp = (PDRefP)malloc(tam_pol * sizeof(DRefP));

    for (auto &e : vmun)
    {
        tam_coord += e.vp.size();
    }

    host_dep = (PDEP)malloc(tam_coord * sizeof(DEP));

    size_t pos = 0;
    for (size_t i = 0; i < tam_pol; i++)
    {
        (host_drefp + i)->ini = pos;

        size_t tam_vp = vmun[i].vp.size();
        for (size_t j = 0; j < tam_vp; j++)
        {
            (host_dep + pos + j)->x = vmun[i].vp[j].x;
            (host_dep + pos + j)->y = vmun[i].vp[j].y;
        }

        pos += vmun[i].vp.size();
        (host_drefp + i)->fin = pos;
    }

    cudaMalloc((void **)&device_dep, tam_coord * sizeof(DEP));
    cudaMemcpy(device_dep, host_dep, tam_coord * sizeof(DEP), cudaMemcpyHostToDevice);

    cudaMalloc((void **)&device_drefp, tam_pol * sizeof(DRefP));
    cudaMemcpy(device_drefp, host_drefp, tam_pol * sizeof(DRefP), cudaMemcpyHostToDevice);
}

/**
 * @brief
 *
 * @param host_dep
 * @param device_dep
 * @param host_drefp
 * @param device_drefp
 */
void liberaMemMunicipio(PDEP &host_dep, PDEP &device_dep, PDRefP &host_drefp, PDRefP &device_drefp)
{
    cudaFree(device_dep);
    cudaFree(device_drefp);

    free(host_dep);
    free(host_drefp);
}