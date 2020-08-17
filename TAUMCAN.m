

function[v]=TAUMCAN(x);

global  AN BN VN2 KN2;


v=AN + BN / cosh(    (x-VN2)/KN2) ; 