function[v]=MINFKA1(x);

global  VA1 KA1;
v=   (1 + exp(-(x-VA1)/KA1))^-1;
