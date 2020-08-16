function[v]=MINFCAT(x);

global  VT1 KT1;
v=   (1 + exp(-(x-VT1)/KT1))^-1;
