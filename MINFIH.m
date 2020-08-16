function[v]=MINFIH(x);

global  VH1 KH1;
v=   (1 + exp((x-VH1)/KH1))^-1;
