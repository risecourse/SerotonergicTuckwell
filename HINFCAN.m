function[v]=HINFCAN(x);

global  VN3 KN3;
v=   (1 + exp(   (x-VN3)/KN3))^-1;
