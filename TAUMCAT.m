

function[v]=TAUMCAT(x);

global  AT BT VT2 KT2;


v=AT + BT / cosh(    (x-VT2)/KT2   ) ; 