#include <cuda.h>
#include <math.h>
#include <cuComplex.h>
#include <iostream>
#include <string>


int main(){

cuDoubleComplex test,otro,res;

    test.x =0;
    test.y=1;

    otro.x=4;
    otro.y=M_PI;

    res=cuCmul(test,otro);

    std::cout<<res.x << " "<<res.y<<std::endl;

    std::cout<< sizeof(cuDoubleComplex) << " "<<sizeof(double)<< std::endl;

    double t=0.001;

    std::cout<< cuCmul(make_cuDoubleComplex(t,0),otro).x <<" "<< cuCmul(make_cuDoubleComplex(t,0),otro).y << std::endl;

    return 0;
}