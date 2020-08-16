function[v]= MINFDR(x);

global VDR1 KDR1;

v=    (1 + exp( - ( x - VDR1)/KDR1)  )^-1;



