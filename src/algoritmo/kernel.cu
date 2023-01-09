#include "../PuntoPertenciaCUDA.h"

/**
 * @brief
 *
 * @param d_dep
 * @param d_prec
 * @param ini
 * @param fin
 * @return __device__
 */
__device__ float sumaAngulos(PDEP d_dep, PDRec d_prec, size_t ini, size_t fin)
{
    float angulo = 0.0;

    float x1 = (d_dep + ini)->x - d_prec->x;
    float y1 = (d_dep + ini)->y - d_prec->y;

    float x0 = (d_dep + fin - 1)->x - d_prec->x;
    float y0 = (d_dep + fin - 1)->y - d_prec->y;

    float mag = sqrt(x0 * x0 + y0 * y0) * sqrt(x1 * x1 + y1 * y1);

    float aux = (x0 * y1 - x1 * y0) / mag;

    if (aux > 1.0)
        aux = 1.0;
    if (aux < -1.0)
        aux = -1.0;

    angulo += asinf(aux);

    for (size_t i = ini + 1; i < fin; i++)
    {
        x1 = (d_dep + i)->x - d_prec->x;
        y1 = (d_dep + i)->y - d_prec->y;

        x0 = (d_dep + i - 1)->x - d_prec->x;
        y0 = (d_dep + i - 1)->y - d_prec->y;

        mag = sqrt(x0 * x0 + y0 * y0) * sqrt(x1 * x1 + y1 * y1);

        /*if (mag == 0.0)
        {
            aux = 0.0;
        }
        else
        {*/
            aux = (x0 * y1 - x1 * y0) / mag;
       // }

        if (aux > 1.0)
            aux = 1.0;
        if (aux < -1.0)
            aux = -1.0;

        angulo += asinf(aux);
    }

    return angulo;
}

/**
 * @brief
 *
 * @param device_dep
 * @param device_drefp
 * @param device_pdrec
 * @param num_rec
 * @param num_pol
 * @return __global__
 */
__global__ void kernel_polpertenciaEstado(PDEP device_dep, PDRefP device_drefp, PDRec device_pdrec, size_t num_rec, size_t num_pol)
{
    unsigned int gtid = threadIdx.x + blockIdx.x * blockDim.x;

    if (gtid < num_rec)
    {
        for (size_t i = 0; i < num_pol; i++)
        {
            float angulo = fabsf(sumaAngulos(device_dep, (device_pdrec + gtid), (device_drefp + i)->ini, (device_drefp + i)->fin));
            if (angulo >= 6.28)
            {
                (device_pdrec + gtid)->id_e = i;
                (device_pdrec + gtid)->res = angulo;
            }
        }
    }
}

/**
 * @brief
 *
 * @param device_dep
 * @param device_drefp
 * @param device_pdrec
 * @param num_rec
 * @param num_pol
 * @return __global__
 */
__global__ void kernel_polpertenciaMunicipio(PDEP device_dep, PDRefP device_drefp, PDRec device_pdrec, size_t num_rec, size_t num_pol)
{
    unsigned int gtid = threadIdx.x + blockIdx.x * blockDim.x;

    if (gtid < num_rec)
    {
        for (size_t i = 0; i < num_pol; i++)
        {
            float angulo = fabsf(sumaAngulos(device_dep, (device_pdrec + gtid), (device_drefp + i)->ini, (device_drefp + i)->fin));
            if (angulo >= 6.28)
            {
                (device_pdrec + gtid)->id_m = i;
                (device_pdrec + gtid)->res = angulo;
            }
        }
    }
}

/**
 * @brief 
 * 
 * @param device_dep 
 * @param device_drefp 
 * @param device_pdrec 
 * @param num_rec 
 * @param ini_pol 
 * @param fin_pol 
 * @return __global__ 
 */
__global__ void kernel_polpertenciaAGEB(PDEP device_dep, PDRefP device_drefp, PDRec device_pdrec, size_t num_rec, size_t ini_pol, size_t fin_pol)
{
    unsigned int gtid = threadIdx.x + blockIdx.x * blockDim.x;

    if (gtid < num_rec)
    {
        //(device_pdrec + gtid)->res = 0;
        for (size_t i = ini_pol; i < fin_pol; i++)
        {
            float angulo = fabsf(sumaAngulos(device_dep, (device_pdrec + gtid), (device_drefp + i)->ini, (device_drefp + i)->fin));
            if (angulo >= 6.28)
            {
                (device_pdrec + gtid)->id_ageb = i;
                (device_pdrec + gtid)->res = angulo;
            }
        }
    }
}

__global__ void kernel_polpertenciaMNZ(PDEP device_dep, PDRefP device_drefp, PDRec device_pdrec, size_t num_rec, size_t ini_pol, size_t fin_pol)
{
    unsigned int gtid = threadIdx.x + blockIdx.x * blockDim.x;

    if (gtid < num_rec)
    {
        if((device_pdrec+gtid)->id_ageb<0){
            return;
        }
        //(device_pdrec + gtid)->res = 0;
        for (size_t i = ini_pol; i < fin_pol; i++)
        {
            float angulo = fabsf(sumaAngulos(device_dep, (device_pdrec + gtid), (device_drefp + i)->ini, (device_drefp + i)->fin));
            if (angulo >= 6.28)
            {
                (device_pdrec + gtid)->id_mnz= i;
                (device_pdrec + gtid)->res = angulo;
            }
        }
    }
}