#!/bin/bash
a_pol_edo="/fhome/alfonso/devel/CPV2020/MGM/INTS/00ent.int"
a_pol_mun="/fhome/alfonso/devel/CPV2020/MGM/INTS/00mun.int"
a_pol_ageb="/fhome/alfonso/devel/CPV2020/MGM/ageb/00a.int"
a_pol_mnz="/fhome/alfonso/devel/CPV2020/MGM/mnz/todos.int"

a_rec="/home/alfonso/devel/renic/renic.git/utiles/checa_iter_cg/ver2/origen/recursos_0.txt"

time ./puntopertencia_cuda.exe $a_pol_edo $a_pol_mun $a_pol_ageb $a_pol_mnz $a_rec
