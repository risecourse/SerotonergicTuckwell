function[v]=TAUMNA(x);

global ANA1 BNA1 VNA2 KNA2

v=   ANA1 +    BNA1/  cosh (   (x - VNA2)/KNA2)   ;   

% if x < VNA2,
%      v=1;
%  end 

