function[v]=HINFNA(x);

global VNA3  KNA3 

v=  (1 + exp( ( x -VNA3)/KNA3) )^-1; 



