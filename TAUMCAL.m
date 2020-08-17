

function[v]=TAUMCAL(x);

global AL BL VL2 KL2;


v=AL + BL / cosh(    (x-VL2)/KL2) ; 