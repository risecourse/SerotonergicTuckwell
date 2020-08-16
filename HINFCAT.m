function[v]=HINFCAT(x);

global  VT3 KT3;
v=   (1 + exp(   (x-VT3)/KT3))^-1;
