#!/bin/bash
a_pol_edo="/fhome/alfonso/devel/CPV2020/MGM/INTS/00ent.int"
a_pol_mun="/fhome/alfonso/devel/CPV2020/MGM/INTS/00mun.int"
a_pol_mnz="/fhome/alfonso/devel/CPV2020/MGM/mnz/todos.int"

num_pol_edo=`cat $a_pol_edo |wc -l`
num_pol_mun=`cat $a_pol_mun |wc -l`
num_pol_mnz=`cat $a_pol_mnz |wc -l`

./puntopertencia_cuda.exe $num_pol_edo $a_pol_edo $num_pol_mun $a_pol_mun $num_pol_mnz $a_pol_mnz
