

function[v]=TAUMKAHM(x);


A=(x+ 35.8)/19.7;
B= (x+79.7)/12.7;


v=  .37 +   (    exp(A   )     +    exp(-B    )    )^-1;