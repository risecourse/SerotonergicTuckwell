function[v]=HINFKA1(x);

global  VA4 KA4;
v=   (1 + exp(   (x-VA4)/KA4))^-1;
