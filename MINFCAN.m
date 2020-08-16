function[v]=MINFCAN(x);

global  VN1 KN1;
v=   (1 + exp(-(x-VN1)/KN1))^-1;
