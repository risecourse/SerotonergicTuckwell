function[v]=TAUHCAT(x);

global  CT    DTT   VT4   KT4 ;


v=CT + DTT*   exp   (  -   (( x - VT4)/KT4)^2      );
