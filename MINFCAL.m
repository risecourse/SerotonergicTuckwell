function[v]=MINFCAL(x);

global  VL1 KL1;
v=   (1 + exp(-(x-VL1)/KL1))^-1;
