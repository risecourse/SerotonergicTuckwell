function[v]=MINFNA(x);

global VNA1 KNA1 

v= (      1+ exp(-   (x-VNA1)/KNA1)    )^-1;


