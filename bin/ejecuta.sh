#!/bin/bash
a_pol_edo="/fhome/alfonso/devel/CPV2020/MGM/INTS/00ent.int"
a_pol_mun="/fhome/alfonso/devel/CPV2020/MGM/INTS/00mun.int"
a_pol_mnz="/fhome/alfonso/devel/CPV2020/MGM/mnz/todos.int"

a_rec="/home/alfonso/devel/renic.git/renic.git/utiles/checa_iter_cg/ver2/origen/recursos_0.txt"

num_pol_edo=`cat $a_pol_edo |wc -l`
num_pol_mun=`cat $a_pol_mun |wc -l`
num_pol_mnz=`cat $a_pol_mnz |wc -l`
num_rec=`cat $a_rec |wc -l`

./puntopertencia_cuda.exe $num_pol_edo $a_pol_edo $num_pol_mun $a_pol_mun $num_pol_mnz $a_pol_mnz $num_rec $a_rec

