function[v]=HINFCAL(x);

global  VL3 KL3;
v=   (1 + exp(   (x-VL3)/KL3))^-1;
