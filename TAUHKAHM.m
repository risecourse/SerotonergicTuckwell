

function[v]=TAUHKAHM(x);


A=(x+ 46)/5;
B= -(x+238)/37.5;




if x < -63
    v=(exp(A) + exp(B))^-1; 
else
    v= 19;
end 
