function[v]=MBKWOMACK(x);
%first variable is Ca i  2nd is voltage


% first convert Cai to micro m 

x(1)= x(1)*1e3;
%boost Cai  by factor of 20
x(1)=x(1)*50;
c1=11 + 0.03*x(1);
c2=140*exp(-(x(1)-0.7)/3) -40;

v= (    1 + exp(   - (x(2) - c2)/c1)    )^-1; 

