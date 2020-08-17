

function[v]=TAUHKA1(x);

global  AA2 BA2 VA5 KA5;


v=AA2 + BA2 / cosh(    (x-VA5)/KA5) ; 