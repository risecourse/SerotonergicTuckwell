

function[v]=TAUMKA1(x);

global  AA1 BA1 VA3  KA3;


v=AA1+ BA1 / cosh(    (x-VA3)/KA3) ; 