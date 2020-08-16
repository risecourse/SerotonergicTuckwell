% SSPONT4APL.doc

% 1st SPONT WITH MINOR CHANGES TO NEWSTANDARD....  
tic
close all; 
clear
% % %parameters etc   
%nb  vr may be used for ikca reversal as not in orig

%  clampfrom=-65;
vta=0.95*(-57);
vti=-81;
vaa=-60*0.95;
vai=-78;

  TOTALTIME=100;

 DT=.008;

 nstep=TOTALTIME/DT;
 repeats =9;     
 countup=0;
 countdown=0;
  kountup=0;
  kountdown=0; 
 kountup=0;
 
 % SE TEXT PARAMETERS - ALL THAT ARE IN MS 
 % GMAX AS IN STANDARD SET OF 24-4-12
 
 
 
CASOURCEFACTOR =0.7;
%ACTIVATION AND INACT PARAMETERS

 %SODIUM activation
 global VNA1 KNA1; VNA1=1.05*(-33.1); KNA1=1.0*10*1.05; 
 global ANA1 BNA1 VNA2 KNA2 ; 
 ANA1= 0.05; BNA1=.15 ; VNA2=-40; KNA2=7.85;  
TAUMNAC=0.2;

 %sodium inactivation 
 global VNA3  KNA3 ; VNA3=-50.3; KNA3=1.0*6.5;
 TAUHNAC=1;  
 global ANA2 BNA2 VNA4  KNA4 
 ANA2=.25*.5; BNA2=7.5 ; VNA4=-43; KNA4=6.84;
 
 %potassium DR
 global VDR1 KDR1;
 VDR1=-15;  nk=1; 
%  VDR1=-53.7; 
 KDR1=7;
 global ADR BDR VDR2 KDR2 KDR3
 ADR=0.5*1; BDR=0.5*14; VDR2=-20 ; KDR2=7; 
 TAUKDRC=3.5; 
%  KDR3=13; 



 %CALCIUM T activn now HM 
 global VT1 KT1;  VT1=vta; KT1=6.2; 
 global AT BT VT2 KT2 ; 
 AT=0.7; BT=13.5; VT2=-76; KT2=18;  
 
 
 
  %CALCIUM T inactivn now HM
 global VT3 KT3; VT3=vti; KT3=4.0; 
 global CT  DTT   VT4   KT4;  
 %CHANGED CT DTT 
 CT=28; DTT=300; VT4=-81; KT4=12;  
 
 


 
%Calcium L activn
global VL1 KL1 AL BL VL2 KL2 ; 
VL1=-20; KL1=8.4; 
AL = 0.5 ; BL = 1.5; VL2=-20; KL2=15; 

%calcium L inactivation
global VL3 KL3 ; 
VL3 =-45; KL3=13.8;
TAUHCAL=200; 

%CALCIUM N  ACTIVATION TEXT
% global VN1 KN1 AN BN VN2 KN2; 
% VN1=-8  ; KN1=7;
% AN=1; BN=1.5; VN2=-15; KN2=15; 


% %CALCIUM N  ACTIVATION REGULAR VALUES
global VN1 KN1 AN BN VN2 KN2; 
VN1=-15; KN1=7;
AN=2.5*1; BN=2.5*1.5; VN2=-15; KN2=15

% %CALCIUM N  ACTIVATION  VALUES FROM 20 3 10 9 
% global VN1 KN1 AN BN VN2 KN2; 
% VN1=-13.5 ; KN1=9;
% AN=.305; BN=2.285; VN2=-20; KN2=20


% 
% %CALCIUM N INACTIVATION  
global VN3 KN3; VN3=-45; KN3=10;  
TAUHCAN=1000; 

 

%KA1 ACTIVATION NOW AS IN TEXT 
global VA1 KA1 AA1  BA1 VA3 KA3; 
VA1=vaa ; KA1=8.5; AA1=.37; BA1=2; 
VA3=-55; KA3=15 ; 

%KA1 INACTIVATION NOW AGHA
global VA4 KA4 AA2 BA2 VA5 KA5; 
VA4=vai ; KA4=6 ; 
AA2=19; BA2=45; VA5=-80; KA5=7; 


%IKCA activation  HALF ACT 250 nM ; TIME CONST INDEP OF CA
global  AKCA;
AKCA= (250e-6)^4;  TAUMKCA=5; 


% IH  ACTIVATION ONLY
global VH1 VH2 KH1 KH2 AH;
VH1=-80;KH1=5;
AH=900;  KH2=13; VH2=-80; 

% 
% %TABAK BK
% global VBK KBK 
% VBK=-20; KBK=2; 
% TAUBK=2; 

%WOMACK BK
TAUMBK=0.25; 


%OTHER PARAMETERS  

%buffering
BTOT=0.030; KB=0.001; 
%PUMP  KPUMP IN mM/MS    KDPUMP IN mM  
%KPUMP HAS BIG INFLUENCE ON ISI: AT 0.1e-4 1500 at .3e-4  379
% .15e-4 close to 1 second
KPUMP=1.25*.25*1.25e-6; KDPUMP=.0001; 


%CELL DATA  KIRBY./BECK DATA    
%sodium and pot and rest POTENTIALS IN VOLTS
VNA=0.045; VK=-0.093; VCAREV=.060; VR = -0.06; VIHREV=-0.045;
%time constant in seconds and input resistance in ohms
%cell macro data time c r in and VR i secs ohms volts
%  TAU=.025; 
RIN=241.5e6; 

% 
%   C=.088613;
% % C=0.04; 
%  TAU=RIN*C*1e-9
% %AREA IN MICRONS SQUARED
% A=8861.3;

% C in nF 
C=.04;  TAU=RIN*C*1e-9
%AREA IN MICRONS SQUARED
A=4000;




%CALCULATE POTASSIUM AND SODIUM LEAK CONDUCTANCES IN S
GKL=   (1/RIN)*(VR-VNA)/(VK-VNA);
GNAL=RIN^-1-GKL;
%THIS ENDS "CELL DATA" AND CALCS

%FARADY   TEMP FACTOR FOR VCA = 12.85 AT ROOM T(25) 13.27 AT BODY
TEMPFAC=13.27; 
  F=96500; 
%calcium out/in in mM
 CAO=2   ; CAIR=0.00005 ; 
 % shell thickness ij microns
 d=0.1; 
 %shell volume in microns3 AND THEN NANOLITERS
 VOL=A*d; 
 VOL=VOL*1e-6;
 %potentials in mV
 VNA=VNA*1000; VK=VK*1000; VR=VR*1000; 
 VIHREV=1000*VIHREV; VCAREV=1000*VCAREV;  
 %maximal conductances in mS/cm^2; then actual in micro S; 

 
 %USING GNAMAX = 13.5nS per pF
% GNAMAX=0*1; %WAS 2

% GNAMAX=2; 
% 
% GNAMAX=C*1000*0.0135; 

GNAMAX=1.1*0.54;

% GKDRMAX=0.2*GKDRMAX;
% GKDRMAX=0.15
GKDRMAX=1.1*1.5*0.0256; 
% % GKDRMAX=0.5; 
% GKDRMAX=0.1; 

 GCATMAX=.85*0.265; 
 GCALMAX=.1*.0462; 
 GCANMAX=1.5*1.5*.9*.0462;
 
 %100% RELIABLE DO NOT CHANGE 
 GKA1MAX=0.75;
 %REDUCE DUE TO NE INPUT
%  GKA1MAX=0.1

 GIHMAX=3*.006;
 GKCAMAX=0.012; %WAS =.003
 
% GBK=2*GKDRMAX/3; 
GKBKMAX=.075/2;

 GKL=1E6*GKL; GNAL=1E6*GNAL; 
%  
%  mu=-.01; 

mu=0; 

CSF=CASOURCEFACTOR; 





%END PARAMETERS ETC





xp1=[VNA1 KNA1 VNA3 KNA3 VT1 KT1 VT3 KT3 VDR1 nk KDR1 VA1 KA1 VA4 KA4 GNAMAX GCATMAX GKDRMAX GKA1MAX]; 

  xp2a=[TAUMNAC TAUHNAC  ADR BDR VDR2 KDR2 AT BT VT2 KT2 CT  DTT   VT4   KT4  VL1 KL1 AL BL VL2 KL2];
  
 xp3=[VL3 KL3 TAUHCAL VN1 KN1 AN BN VN2 KN2 VN3 KN3 TAUHCAN AA1 BA1 VA3 KA3 AA2 BA2 VA5 KA5]; 

 xp4=[AKCA TAUMKCA VH1 KH1 AH KH2 VH2 BTOT KB KPUMP KDPUMP VNA VK VCAREV VR VIHREV RIN C A TEMPFAC];

xp5=[F CAO CAIR d GCALMAX GCANMAX GIHMAX GKCAMAX mu DT CSF];  
 
gmax=[GNAMAX GKDRMAX GCATMAX GCALMAX GCANMAX GKA1MAX GIHMAX GKCAMAX GKBKMAX mu];



  %  INITIAL VALUES
    
  t(1)=0; 
%  
    x(1,1)=VR;
    x(2,1)=MINFNA(VR);
    x(3,1)=HINFNA(VR);
    
    x(4,1)=MINFDR(VR);
    
    x(5,1)=MINFCAT(VR) ;
    x(6,1)=HINFCAT(VR) ;
    
    x(7,1)=MINFCAL(VR) ;
    x(8,1)=HINFCAL(VR) ;
    
    x(9,1)= MINFCAN(VR) ;
    x(12,1) = HINFCAN(VR); 
    
    x(10,1)=MINFKA1(VR);
    x(11,1)=HINFKA1(VR);

    
    x(14,1)=MINFIH(VR);
    
    x(15,1)= MINFKCA(CAIR);
    x(16,1)=CAIR; 
%     x(13,1)= MINFBK(VR); 
     x(17,1)=MBKWOMACK([CAIR VR]);
        mna3(1)= x(2,1)^3;
% %     
%     %temp 
    

% %     
    
 
    
for k=1: nstep
    
    t(k+1)=k*DT; 
%     
 VCA(k)= TEMPFAC*log(CAO/x(16,k));  
%  VCA(k)=60; 
% 
% if   t(k) <= 50
%      mu=0; 
%  end
%  
%  if t(k) > 50 & t(k) < 300
%      mu=-0.015;
%  end
% %      e
%   end
% % %  
%       if t(k) >50  & t(k) <=250
%          mu=-0.15;  
%       end 
% 
% if t(k) >250
%     mu=0;
% end 
      
%       
%       
% VCAREV=VCA(k); 
 x(1,k+1)=  x(1,k)   -DT* (1/C) *(mu + GNAMAX*x(2,k)^3*x(3,k)*(x(1,k)-VNA)... 
 + GKDRMAX*x(4,k)^nk*(x(1,k)-VK) + GCATMAX*x(5,k)^2*x(6,k)*(x(1,k)-VCAREV)...
 +GCALMAX*x(7,k)^2*x(8,k)*(x(1,k)-VCAREV) + ...
 GCANMAX*x(9,k)^2*x(12,k)* (x(1,k)-VCAREV)  ...  
 + GKA1MAX*x(10,k)^4*x(11,k)*(x(1,k)-VK)... 
 +GIHMAX*x(14,k)*(x(1,k)-VIHREV)... 
  +GKBKMAX*x(17,k)*(x(1,k)-VK)...
 +GKCAMAX*x(15,k)*(x(1,k)-VK)...  
+ GKL*(x(1,k) - VK) + GNAL*(x(1,k)-VNA) ); 

if k==1
    deriv= (x(1,k+1) - x(1,k))/DT
end
if deriv <0 & k==1
critmu=deriv*C
end 

%HERE IS THE SPIKE CLAMP


% 
% % 
% if t(k) >0 & t(k) < 50
%       x(1,k)=clampfrom;
%   end
% % %  
%       if t(k) > 50 & t(k) < 350
%           x(1,k)=-56; 
%       end 
% 
%       if t(k) > 350
%           x(1,k)=clampfrom; 
%       end
%       
x(2,k+1)= x(2,k) + DT* (MINFNA(x(1,k)) - x(2,k) )/ TAUMNA(x(1,k));
x(3,k+1)=x(3,k) + DT* (  HINFNA(x(1,k)) - x(3,k) )/ TAUHNA(x(1,k));
% x(2,k+1)= x(2,k) + DT* (MINFNA(x(1,k)) - x(2,k) )/TAUMNAC;
% 
% x(3,k+1)=x(3,k) + DT* (  HINFNA(x(1,k)) - x(3,k) )/ TAUHNAC;
x(4,k+1)= x(4,k) + DT* (MINFDR(x(1,k)) - x(4,k) )/ TAUMDR(x(1,k)   );
% x(4,k+1)= x(4,k) + DT* (MINFDR(x(1,k)) - x(4,k) )/ TAUKDRC;


x(5, k+1)=x(5,k) + DT*(MINFCAT(x(1,k)) - x(5,k))/ TAUMCAT(x(1,k)); 
% x(5, k+1)=x(5,k) + DT*(MINFCAT(x(1,k)) - x(5,k))/ 1; 
% x(5, k+1)=x(5,k) + DT*(MINFCAT(x(1,k)) - x(5,k))/ TAUMCATHM(x(1,k)); 

x(6,k+1)=x(6,k) +DT*(HINFCAT(x(1,k))-x(6,k))/TAUHCAT(x(1,k));  
% % x(6,k+1)=x(6,k) +DT*(HINFCAT(x(1,k))-x(6,k))/20;  
% x(6,k+1)=x(6,k) +DT*(HINFCAT(x(1,k))-x(6,k))/TAUHCATHM(x(1,k));  


x(7,k+1)=x(7,k) +DT*(  MINFCAL(x(1,k))    -x(7,k))/TAUMCAL(x(1,k));  
x(8,k+1)=x(8,k) + DT*(HINFCAL(x(1,k))-x(8,k))/TAUHCAL;  

x(9,k+1)=x(9,k) + DT*(MINFCAN(x(1,k))-x(9,k))/ TAUMCAN(x(1,k)); 
x(12,k+1) = x(12,k) + DT*(HINFCAN(x(1,k)) - x(12,k))/TAUHCAN; 

% x(10,k+1)=x(10,k) + DT*(MINFKA1(x(1,k))-x(10,k))/TAUMKA1(x(1,k)); 
% x(10,k+1)=x(10,k) + DT*(MINFKA1(x(1,k))-x(10,k))/1; 
x(10,k+1)=x(10,k) + DT*(MINFKA1(x(1,k))-x(10,k))/TAUMKAHM(x(1,k)); 



% x(11,k+1)=x(11,k) + DT*(HINFKA1(x(1,k))-x(11,k))/TAUHKA1(x(1,k)); 
% x(11,k+1)=x(11,k) + DT*(HINFKA1(x(1,k))-x(11,k))/10; 
x(11,k+1)=x(11,k) + DT*(HINFKA1(x(1,k))-x(11,k))/TAUHKAHM(x(1,k)); 

% x(13,k+1)=x(13,k) + DT*(MINFBK(x(1,k))-x(13,k))/TAUBK; 

x(14,k+1)=x(14,k) + DT*(MINFIH(x(1,k))-x(14,k))/TAUMIH(x(1,k)); 

x(15,k+1)=x(15,k) + DT*(MINFKCA(x(16,k))-x(15,k))/TAUMKCA;


%CALCIUM DYNAMICS 

   PB(k)=BTOT/(x(16,k) + BTOT + KB);
   SOURCE(k)= -(GCALMAX*x(7,k)^2*x(8,k)*(x(1,k)-VCAREV) ...
   +GCANMAX*x(9,k)^2*x(12,k)*(x(1,k)  -VCAREV))*(1-PB(k))/(2*F*VOL); 
   PUMP(k) = KPUMP*x(16,k)/ ( x(16,k) + KDPUMP); 
x(16,k+1)=x(16,k) + DT* (CASOURCEFACTOR*SOURCE(k)   - PUMP(k) );   
x(17, k+1)= x(17,k) + DT*(MBKWOMACK([x(16,k) x(1,k)]) - x(17,k))/TAUMBK; 
mna3(k+1)= x(2,k+1)^3;


%GET UPSLOPE
if x(1,k)<-30 & x(1,k+1) >-30
    kountdown=kountdown+1;
       T1(kountdown)=(k+1)*DT;
         V1(kountdown)=x(1,k+1);
   end
       if x(1,k)<-1 & x(1,k+1)>-1
           kountup=kountup+1;
           T2(kountup)=(k+1)*DT;
             V2(kountup)=x(1,k+1);
       end
       if kountup >0 &  kountdown>0
             UPSLOPE(kountdown)= (V2(kountup)-V1(kountdown))/(T2(kountup)-T1(kountdown)); 
         end

if k >1 & x(1,k-1) < -40 & x(1,k) > -40
    countup=countup +1;
     TV(countup) = t(k);
 end 

 if k> 1 & x(1,k-1) > -40 & x(1,k) <-40
        countdown = countdown + 1
        DY(countdown)=t(k);
    end 

end 

VCA(nstep+1)=13.27*log(CAO/x(16,nstep+1));

for k=1:nstep+1
%     VCAREV=VCA(k);
    INA(k)=-GNAMAX*x(2,k)^3*x(3,k)*(x(1,k)-VNA);
    IKDR(k)=-GKDRMAX*x(4,k)^nk*(x(1,k)-VK) ;
    ILEAK(k)=  -GKL*(x(1,k) - VK) -GNAL*(x(1,k)-VNA) ;
    ICAT(k)=-GCATMAX*x(5,k)^2*x(6,k)*(x(1,k)-VCAREV); 
    ICAL(k)=-GCALMAX*x(7,k)^2*x(8,k)*(x(1,k)-VCAREV);  
    ICAN(k)=-GCANMAX*x(9,k)^2*x(12,k)*(x(1,k)-VCAREV); 
    IKA1(k)=-GKA1MAX*x(10,k)^4*x(11,k)*(x(1,k)-VK); 
    IBK(k)=-GKBKMAX*x(17,k)*(x(1,k)-VK); 

    IH(k)=-GIHMAX*x(14,k)*(x(1,k)-VIHREV); 
    IKCA(k)=-GKCAMAX*x(15,k)*(x(1,k)-VK);
    
     PB(k)=BTOT/(x(16,k) + BTOT + KB);
    SOURCE(k)= -(GCALMAX*x(7,k)^2*x(8,k)*(x(1,k)-VCAREV) +...
    GCANMAX*x(9,k)^2*x(12,k)*(x(1,k)...
    -VCAREV))*(1-PB(k))/(2*F*VOL); 
   PUMP(k) = KPUMP*x(16,k)/ ( x(16,k) + KDPUMP); 
    ITOT(k)= INA(k) + IKDR(k) +ICAT(k) + ICAL(k) + ICAN(k)+...
    IKA1(k) + IH(k) +  IKCA(k) + IBK(k) + ILEAK(k); 
ICA(k)=ICAT(k) + ICAL(k) + ICAN(k);
end  


% figure(16); subplot(3,1,1); plot(t, -IKA1); 
% figure(16); subplot(3,1,2); plot(t, ICAT); 
% figure(16); subplot(3,1,3); plot(t, -IKA1-ICAT); 


figure(16)
plot(t, x(1,:));
hold on

figure(8)
plot(t, x(1,:));
hold on
plot(t, -40*IBK -60, 'r')
plot(t, -40*IKA1 -60, 'm')
plot(t, -40*IKDR-60,'k')
plot(t, -40*IKCA-60,'g')
 set(findobj('Type', 'line'), 'Linewidth',2); 
  title('blue V red BK mauve IA black KDR green IKCA')

  
  figure(10)
plot(t, x(1,:));
hold on
plot(t, 10*INA -60, 'r')
plot(t, 100*ICAN -60, 'm')
plot(t, 100*ICAT -60, 'k')
plot(t, 100*ICAL-60, 'g')
 set(findobj('Type', 'line'), 'Linewidth',2); 
  title('blue V red INA mauve ICAN black ICAT green ICAL')
  

  figure(13)
  plot(t, x(1,:))
  hold on
  plot(t, -40*(IKDR +IKA1 + IKCA + IBK) -60, 'r')
   set(findobj('Type', 'line'), 'Linewidth',2); 
  title('blue V  red sum dr a kca bk')
  
  
    figure(14)
  plot(t, x(1,:))
  hold on
  plot(t, 10*(INA + ICAN + ICAT + ICAL) -60, 'r')
  plot(t, -10*(IKDR +IKA1 + IKCA + IBK) -60, 'k')
   set(findobj('Type', 'line'), 'Linewidth',2); 
  title('blue V  red sum pos  black sum neg')
  
  figure(15)
  plot(t, x(1,:))
  hold on 
  plot(t, 15*(INA + ICAN + ICAT + ICAL + IKDR + IKCA + IBK + IKA1)-70, 'r')
     set(findobj('Type', 'line'), 'Linewidth',2); 
  title('blue V  red all sauf IH')
  
  
figure(1); 
subplot(2,2,1)
plot(t, x(1,:))
hold on
% ylabel('V')
subplot(2,2,2)
plot(t, x(16,:)); hold on;
% ylabel('Ca_i') 
subplot(2,4,5)
plot(t, INA); hold on
subplot(2,4,6)
plot(t, ICAN); hold on 
 set(findobj('Type', 'line'), 'Linewidth',2); 
 subplot(2,4,7)
 plot(t, IKDR); hold on
 subplot(2,4,8)
 plot(t, IKCA); hold on
  set(findobj('Type', 'line'), 'Linewidth',2); 
  
  figure(2)
subplot(2,2,1)
plot(t, INA); hold on;
ylabel('INA')
subplot(2,2,2)
plot(t, IKDR); hold on; 
ylabel('IKDR')
subplot(2,2,3)
plot(t, ICAT); hold on;
ylabel('ICAT')
subplot(2,2,4)
plot(t, ICAL); hold on
ylabel('ICAL')
 set(findobj('Type', 'line'), 'Linewidth',2); 
      
 figure(3)
subplot(2,2,1)
plot(t, ICAN); hold on; 
ylabel('ICAN')
subplot(2,2,2)
plot(t, IKA1,'r'); hold on 
plot(t, IBK,'m')
ylabel('IKA, IBK')
subplot(2,2,3)
plot(t, IKCA); hold on
ylabel('IKCA')
subplot(2,2,4)
plot(t, IH);  hold on 
ylabel('IH')
 set(findobj('Type', 'line'), 'Linewidth',2); 
    
figure(6)
subplot(2,1,1)
plot(t, ICAT); hold on;
 set(findobj('Type', 'line'), 'Linewidth',2); 
 ylabel('ICAT')
subplot(2,1,2)
plot(t, IKA1,'r'); hold on;
 set(findobj('Type', 'line'), 'Linewidth',2); 
 ylabel('IA')
 
figure(12) 
plot(t, -(ICAT + IKA1)); hold on 
 set(findobj('Type', 'line'), 'Linewidth',2); 
 ylabel('SUM IA IT') 
  
  
  
  figure(7)

  plot(t, INA) ; hold on

  plot(t, ICAT,'r'); hold on
  plot(t, ICAN, 'g')
  
    set(findobj('Type', 'line'), 'Linewidth',2); 
  
  
      
 figure(9)

 plot(t, x(1,:)); hold on
 plot(t, -60+60* ICAT,'r'); hold on
 plot (t, -60+60*ICAN,'r--'); hold on
 plot(t, -60-60*IKA1, 'g'); hold on
 plot(t, -60-60*IKCA, 'g--'); hold on
 plot(t, -60-60*IBK, 'm'); hold on
 plot(t, -60-60*IKDR,'m--'); hold on 
 title('v blue, T red, N red --, A green, IKCA gr--, BK m, KDR, m--')
  set(findobj('Type', 'line'), 'Linewidth',2); 
 
 
    

figure(18)



subplot(4,1,1); plot(t, INA); hold on
title('INA,m and m^3,h, V-VNA')
subplot(4,1,2); plot(t, x(2,:)); hold on
plot(t, mna3, 'r')
subplot(4,1,3); plot(t, x(3,:)); hold on
subplot(4,1,4); plot(t,-(x(1,:)-VNA)); hold on



set(findobj('Type', 'line'), 'Linewidth',2); 



  figure(19)
 plot(t, (60+x(1,:))/8); hold on
 plot (t, INA,'r') ; hold on 
 plot(t, ICAN,'g')
 plot(t, IKDR, 'k')
 plot(t, IBK, 'm')
 plot(t, IKA1, 'b--')
 plot(t, IH, 'r--')
 plot(t, IKCA, 'k--')
 plot(t, ICAL, 'm--')
 plot(t,ICAT, 'g--')
 plot(t, ILEAK, 'c')
 
 
 
 
 
set(findobj('Type', 'line'), 'Linewidth',2); 
title('blue, V; red, INA; green, ICAN, black, IKDR; mauve, IBK, green dash ICAT')
ylabel('blue dash, IA; red dash, IH; black dash, KCA; mauve dash ICAL')
 xlabel('cyan, LEAK')
 




figure(20)
plot(t, x(1,:))
title('voltage')   
hold on 
set(findobj('Type', 'line'), 'Linewidth',2); 


 figure(27)
 plot(t, (60+x(1,:))/8)
 hold on
 plot(t, 5e4*x(16,:), 'r')
  plot(t, 50*ICAN, 'g')

 set(findobj('Type', 'line'), 'Linewidth',2); 

 title('V, blue; Cai, Red; ICAN, green')
 

% axis([0 100 -80 -30])







for ktt=1:repeats
     ktt

     
       %  INITIAL VALUES
    
  t(1)=0; 
    % % %     %SECOND OF SEQUENCE DON'T CLEAR 
% 
     for j=1:17
     x(j,1)=x(j,nstep+1); end 
     
         
for k=1: nstep
    
    t(k+1)=k*DT; 
%     
 VCA(k)= TEMPFAC*log(CAO/x(16,k));  
%  VCAREV=VCA(k);
  x(1,k+1)=  x(1,k)   -DT* (1/C) *(mu + GNAMAX*x(2,k)^3*x(3,k)*(x(1,k)-VNA)... 
 + GKDRMAX*x(4,k)^nk*(x(1,k)-VK) + GCATMAX*x(5,k)^2*x(6,k)*(x(1,k)-VCAREV)...
 +GCALMAX*x(7,k)^2*x(8,k)*(x(1,k)-VCAREV) + ...
 GCANMAX*x(9,k)^2*x(12,k)*(x(1,k)-VCAREV)  ...  
 + GKA1MAX*x(10,k)^4*x(11,k)*(x(1,k)-VK)... 
  +GKBKMAX*x(17,k)*(x(1,k)-VK)...
 +GIHMAX*x(14,k)*(x(1,k)-VIHREV)... 
 +GKCAMAX*x(15,k)*(x(1,k)-VK)...  
+ GKL*(x(1,k) - VK) + GNAL*(x(1,k)-VNA) ); 
 


% if t(k) >0 & t(k) < 20
%       x(1,k)=-85;
%   end
 
%       if t(k) > 2 & t(k) < 22
%           x(1,k)=-60; 
%       end 
% 
%       if t(k) > 22 
%           x(1,k)=-80 ; 
%       end
%       
% 
x(2,k+1)= x(2,k) + DT* (MINFNA(x(1,k)) - x(2,k) )/ TAUMNA(x(1,k));
mna3(k+1)= x(2,k+1)^3;

x(3,k+1)=x(3,k) + DT* (  HINFNA(x(1,k)) - x(3,k) )/ TAUHNA(x(1,k));
% % % % 
% x(2,k+1)= x(2,k) + DT* (MINFNA(x(1,k)) - x(2,k) )/TAUMNAC;
% 
% x(3,k+1)=x(3,k) + DT* (  HINFNA(x(1,k)) - x(3,k) )/ TAUHNAC;



x(4,k+1)= x(4,k) + DT* (MINFDR(x(1,k)) - x(4,k) )/ TAUMDR(x(1,k)   );
% x(4,k+1)= x(4,k) + DT* (MINFDR(x(1,k)) - x(4,k) )/ TAUKDRC;

x(5, k+1)=x(5,k) + DT*(MINFCAT(x(1,k)) - x(5,k))/ TAUMCAT(x(1,k)); 
x(6,k+1)=x(6,k) +DT*(HINFCAT(x(1,k))-x(6,k))/TAUHCAT(x(1,k));  

x(7,k+1)=x(7,k) +DT*(  MINFCAL(x(1,k))    -x(7,k)    )/TAUMCAL(x(1,k));  
x(8,k+1)=x(8,k) + DT*(HINFCAL(x(1,k))-x(8,k))/TAUHCAL;  

x(9,k+1)=x(9,k) + DT*(MINFCAN(x(1,k))-x(9,k))/ TAUMCAN(x(1,k)); 

x(12,k+1) = x(12,k) + DT*(HINFCAN(x(1,k)) - x(12,k))/TAUHCAN; 
x(10,k+1)=x(10,k) + DT*(MINFKA1(x(1,k))-x(10,k))/TAUMKA1(x(1,k)); 
x(11,k+1)=x(11,k) + DT*(HINFKA1(x(1,k))-x(11,k))/TAUHKA1(x(1,k)); 

% x(13,k+1)=x(13,k) + DT*(MINFBK(x(1,k))-x(13,k))/TAUBK; 

x(14,k+1)=x(14,k) + DT*(MINFIH(x(1,k))-x(14,k))/TAUMIH(x(1,k)); 

x(15,k+1)=x(15,k) + DT*(MINFKCA(x(16,k))-x(15,k))/TAUMKCA;

   PB(k)=BTOT/(x(16,k) + BTOT + KB);
   SOURCE(k)= -(GCALMAX*x(7,k)^2*x(8,k)*(x(1,k)-VCAREV) ...
   +GCANMAX*x(9,k)^2*x(12,k)*(x(1,k)  -VCAREV))*(1-PB(k))/(2*F*VOL); 
   PUMP(k) = KPUMP*x(16,k)/ ( x(16,k) + KDPUMP); 
x(16,k+1)=x(16,k) + DT* (CASOURCEFACTOR*SOURCE(k)   - PUMP(k) );   
x(17, k+1)= x(17,k) + DT*(MBKWOMACK([x(16,k) x(1,k)]) - x(17,k))/TAUMBK; 


if k >1 & x(1,k-1) < -40 & x(1,k) > -40
    countup=countup +1;
     TV(countup) = t(k)+ ktt*100;

 end 
 if k> 1 & x(1,k-1) > -40 & x(1,k) <-40
        countdown = countdown + 1
        DY(countdown)=t(k)+ktt*100;
    end 

    
    %GET UPSLOPE
if x(1,k)<-30 & x(1,k+1) >-30
    kountdown=kountdown+1;
       T1(kountdown)=(k+1)*DT;
         V1(kountdown)=x(1,k+1);
   end
       if x(1,k)<-1 & x(1,k+1)>-1
           kountup=kountup+1;
           T2(kountup)=(k+1)*DT;
             V2(kountup)=x(1,k+1);
       end
       if kountup >0 &  kountdown>0
             UPSLOPE(kountdown)= (V2(kountup)-V1(kountdown))/(T2(kountup)-T1(kountdown)); 
         end
        

end 

VCA(nstep+1)=13.27*log(CAO/x(15,nstep+1));



for k=1:nstep+1
%     VCAREV=VCA(k); 
       INA(k)=-GNAMAX*x(2,k)^3*x(3,k)*(x(1,k)-VNA);
    IKDR(k)=-GKDRMAX*x(4,k)^nk*(x(1,k)-VK) ;
    ILEAK(k)=  -GKL*(x(1,k) - VK) -GNAL*(x(1,k)-VNA) ;
    ICAT(k)=-GCATMAX*x(5,k)^2*x(6,k)*(x(1,k)-VCAREV); 
    ICAL(k)=-GCALMAX*x(7,k)^2*x(8,k)*(x(1,k)-VCAREV);  
    ICAN(k)=-GCANMAX*x(9,k)^2*x(12,k)*(x(1,k)-VCAREV); 
    IKA1(k)=-GKA1MAX*x(10,k)^4*x(11,k)*(x(1,k)-VK); 

    IH(k)=-GIHMAX*x(14,k)*(x(1,k)-VIHREV); 
    IKCA(k)=-GKCAMAX*x(15,k)*(x(1,k)-VK);
    
        IBK(k)=-GKBKMAX*x(17,k)*(x(1,k)-VK); 
    
     PB(k)=BTOT/(x(16,k) + BTOT + KB);
    SOURCE(k)= -(GCALMAX*x(7,k)^2*x(8,k)*(x(1,k)-VCAREV) +GCANMAX*x(9,k)*(x(1,k)...
    -VCAREV))*(1-PB(k))/(2*F*VOL); 
   PUMP(k) = KPUMP*x(16,k)/ ( x(16,k) + KDPUMP); 
    ITOT(k)= INA(k) + IKDR(k) +ICAT(k) + ICAL(k) + ICAN(k)+...
    IKA1(k) + IH(k) +  IKCA(k) +  ILEAK(k); 
ICA(k)= ICAT(k) + ICAL(k) + ICAN(k);
end  



figure(16)
plot(t+ktt*100, x(1,:));
hold on


figure(8)
plot(t+ktt*100, x(1,:));
hold on
plot(t+ktt*100, -40*IBK -60, 'r')
plot(t+ktt*100, -40*IKA1 -60, 'm')
plot(t+ktt*100, -40*IKDR-60,'k')
plot(t+ktt*100, -40*IKCA-60,'g')
 set(findobj('Type', 'line'), 'Linewidth',2); 

   
  figure(10)
plot(t+ktt*100, x(1,:));
hold on
plot(t+ktt*100, 10*INA -60, 'r')
plot(t+ktt*100, 100*ICAN -60, 'm')
plot(t+ktt*100, 100*ICAT -60, 'k')
plot(t+ktt*100, 100*ICAL-60, 'g')
 set(findobj('Type', 'line'), 'Linewidth',2); 


  figure(13)
  plot(t+ktt*100, x(1,:))
  hold on
  plot(t+ktt*100, -40*(IKDR +IKA1 + IKCA + IBK) -60, 'r')
   set(findobj('Type', 'line'), 'Linewidth',2); 

  
  
    figure(14)
  plot(t+ktt*100, x(1,:))
  hold on
  plot(t+ktt*100, 10*(INA + ICAN + ICAT + ICAL) -60, 'r')
   plot(t+ktt*100, -10*(IKDR +IKA1 + IKCA + IBK) -60, 'k')
   set(findobj('Type', 'line'), 'Linewidth',2); 
 
     
  figure(15)
  plot(t+ktt*100, x(1,:))
  hold on 
  plot(t+ktt*100, 15*(INA + ICAN + ICAT + ICAL + IKDR + IKCA + IBK + IKA1)-70, 'r')
     set(findobj('Type', 'line'), 'Linewidth',2); 


figure(1); 
subplot(2,2,1)
plot(t+ktt*100, x(1,:))
hold on
% ylabel('V')
subplot(2,2,2)
plot(t+ktt*100, x(16,:)); hold on;
% ylabel('Ca_i') 
subplot(2,4,5)
plot(t+ktt*100, INA); hold on
subplot(2,4,6)
plot(t+ktt*100, ICAN); hold on 
 set(findobj('Type', 'line'), 'Linewidth',2); 
 subplot(2,4,7)
 plot(t+ktt*100, IKDR); hold on
 subplot(2,4,8)
 plot(t+ktt*100, IKCA); hold on
  set(findobj('Type', 'line'), 'Linewidth',2); 


  figure(7)

  plot(t+ktt*100, INA) ; hold on

  plot(t+ktt*100, ICAT,'r'); hold on
  plot(t+ ktt*100,ICAN,'g')
  
    set(findobj('Type', 'line'), 'Linewidth',2); 
  

figure(9) 

 plot(t+ktt*100, x(1,:)); hold on
 plot(t+ktt*100, -60+60* ICAT,'r'); hold on
 plot (t+ktt*100, -60+60*ICAN,'r--'); hold on
 plot(t+ktt*100, -60-60*IKA1, 'g'); hold on
 plot(t+ktt*100, -60-60*IKCA, 'g--'); hold on
 plot(t+ktt*100, -60-60*IBK, 'm'); hold on
 plot(t+ktt*100, -60-60*IKDR,'m--'); hold on 
 title('v blue, T red, N red --, A green, IKCA gr--, BK m, KDR, m--')
  set(findobj('Type', 'line'), 'Linewidth',2); 
 
 

 
 
 
%  subplot(3,2,3);
%  plot(t+ktt*100, x(16,:)); hold on;
%  subplot(3,2,5)
%  plot(t+ktt*100,IKCA); hold on 
 


% axis([0 100 -80 -30])
figure(2)
subplot(2,2,1)
plot(t+ktt*100, INA); hold on
ylabel('INA')
subplot(2,2,2)
plot(t+ktt*100, IKDR)
hold on
ylabel('IKDR')
subplot(2,2,3)
plot(t+ktt*100, ICAT); hold on;
ylabel('ICAT')
subplot(2,2,4)
plot(t+ktt*100, ICAL); hold on
ylabel('ICAL')
 set(findobj('Type', 'line'), 'Linewidth',2); 

figure(3)
subplot(2,2,1)
plot(t+ktt*100, ICAN); hold on; 
ylabel('ICAN')
subplot(2,2,2)
plot(t+ktt*100, IKA1,'r'); hold on 
plot(t+ktt*100, IBK,'m'); hold on 
ylabel('IKA,  IBK')
subplot(2,2,3)
plot(t+ktt*100, IKCA); hold on
ylabel('IKCA')
subplot(2,2,4)
plot(t+ktt*100, IH);  hold on 
ylabel('IH')
 set(findobj('Type', 'line'), 'Linewidth',2); 

 
 figure(6)
 subplot(2,1,1)
plot(t+ktt*100, ICAT); hold on;
 set(findobj('Type', 'line'), 'Linewidth',2); 
 ylabel('ICAT')
subplot(2,1,2) 
plot(t+ktt*100, IKA1,'r'); hold on;
 set(findobj('Type', 'line'), 'Linewidth',2); 
 ylabel('IA')
 
figure(12) 
plot(t+ktt*100, -(ICAT + IKA1)); hold on 
 set(findobj('Type', 'line'), 'Linewidth',2); 
 ylabel('SUM IA IT') 
  
 
 figure(18)
subplot(4,1,1); plot(t+ktt*100, INA); hold on
subplot(4,1,2); plot(t+ktt*100, x(2,:)); hold on
plot(t+ktt*100, mna3, 'r')
subplot(4,1,3); plot(t+ktt*100, x(3,:)); hold on
subplot(4,1,4); plot(t+ktt*100, -(x(1,:)-VNA)); hold on




  figure(19)
 plot(t+ktt*100, (60+x(1,:))/8); hold on
 plot (t+ktt*100, INA,'r') ; hold on 
 plot(t+ktt*100,ICAN,'g')
 plot(t+ktt*100, IKDR, 'k')
 plot(t+ktt*100, IBK, 'm')
 plot(t+ktt*100, IKA1, 'b--')
 plot(t+ktt*100, IH, 'r--')
 plot(t+ktt*100, IKCA, 'k--')
 plot(t+ktt*100, ICAL, 'm--')
 plot(t+ktt*100,ICAT, 'g--')
 plot(t+ktt*100, ILEAK, 'c')
 
 
 
 
 
set(findobj('Type', 'line'), 'Linewidth',2); 



figure(20)
plot(t+ktt*100, x(1,:))
hold on 
set(findobj('Type', 'line'), 'Linewidth',2); 




 figure(27)
 plot(t+ktt*100, (60+x(1,:))/8)
 hold on
 plot(t+ktt*100, 5e4*x(16,:), 'r')
 plot(t+ktt*100, 50*ICAN, 'g')
 set(findobj('Type', 'line'), 'Linewidth',2); 

 












end









%PLOT ACTIV AND INACT AND TIME CONST 

for k=1:151; y(k)=-101 +k;
   mna(k)= MINFNA(y(k));
   mna3(k) = mna(k)^3; 
%    tmna(k)=TAUMNA(y(k));
   hna(k)=HINFNA(y(k));
   mna3h(k)= mna3(k)*hna(k); 
   
   termna(k)=mna3h(k)*GNAMAX*(y(k)-VNA); 
%    mbk(k)=MINFBK(y(k)); 
   
%   thna(k)=TAUHNA(y(k));
  mcat(k)=MINFCAT(y(k));
  tmcat(k)=TAUMCAT(y(k));
  hcat(k)=HINFCAT(y(k));
  thcat(k)=TAUHCAT(y(k)); 
  mcal(k)=MINFCAL(y(k));
%   tmcal(k)=TAUMCAL(y(k)); 
  hcal(k)= HINFCAL(y(k));
%   thcal(k)=TAUHCAL(y(k));
  mcan(k)=MINFCAN(y(k)); 
  hcan(k)=HINFCAN(y(k)); 
%   tmcan(k)=TAUMCAN( y(k));
  m2hcat(k)= mcat(k)^2*hcat(k); 
  termicat(k)=m2hcat(k)*GCATMAX*(y(k)-VCAREV); 
  
  
end




% 
% 
% 
% SWITCH BACK TO CONSTANT VCAREV 

% VCAREV=VCAREVC; 
for k=1:151
 mkdr(k)= MINFDR(y(k));
%    tkdr(k)=TAUMDR(y(k));
%    
    mka1(k)=MINFKA1(y(k));
    tka1(k)=TAUMKA1(y(k));
   hka1(k)=HINFKA1(y(k));
   thka1(k)=TAUHKA1(y(k));
   termka(k)=mka1(k)^4*hka1(k)*GKA1MAX*(y(k)-VK); 
   termkdr(k)=mkdr(k)^nk*GKDRMAX*(y(k)-VK); 
%    termbk(k)=mbk(k)*GBK*(y(k)-VK); 
%    
% %    mka2(k)=MINFKA2(y(k));
% 
%   
% %    thka2(k)=TAUHKA2(y(k));
%    
  mih(k)=MINFIH(y(k));
  tmih(k)=TAUMIH(y(k)); 
  termcal(k)=mcal(k)^2*hcal(k)*GCALMAX*(y(k)-VCAREV); 
  %IF ICAN HAS INACT
%   termcan(k)=mcan(k)^2*hcan(k)*GCANMAX*(y(k)-VCAREV);

  % IF ICAN HAS NO INACT
  termcan(k)=mcan(k)^2*hcan(k)*GCANMAX*(y(k)-VCAREV);
  termih(k)=mih(k)*GIHMAX*(y(k)-VIHREV); 
  termleak(k)=GKL*(y(k)-VK) + GNAL*(y(k)-VNA); 
  termkca(k)= GKCAMAX*MINFKCA(CAIR)*(y(k) -VK);
  tot(k)= -termna(k)-termicat(k)-termka(k)-termkdr(k)-termih(k)-termcal(k)-termcan(k)-mu-termleak(k)-termkca(k); 
  
  
  
end  

FVR= tot(41)
% 
  
figure(4)

plot(y,- termna);
hold on
plot(y, -termicat,'r');
plot(y, -termka,'--')
plot(y, -termkdr, 'r--')
plot(y, -termcan, 'k')
plot(y, -termcal,'g')
% plot(y, -termbk,'m'); 

title('blue NA, RED T, blue --- KA, red --- KDR, BLACK ICAN, Green ICAL')
 line([VR VR], [-.5 0.5])
    line([VR+5 VR+5], [-.5 0.75])
     line([-100 -10], [0  0])
axis([-90 30   -.5  .75])
 set(findobj('Type', 'line'), 'Linewidth',2); 

figure(5)
   plot(y, -termna-termicat-termka-termkdr-termih-termcal-termcan-mu-termleak);
   hold on     
   line([VR VR], [-4 max(tot)])
    line([VR+5 VR+5], [-4  max(tot)])
      line([-100 0], [0  0])
         axis([-90 0 -1  max(tot)])
         ylabel('TOTAL ALL COMP')
    set(findobj('Type', 'line'), 'Linewidth',2); 

    
    
     figure(11)
hold on
plot(y, -termicat,'r');
plot(y, -termka,'--')
plot(y, -termkdr, 'r--')
plot(y, -termcan, 'k')
plot(y, -termcal,'g')
% plot(y, -termbk,'m'); 

title('blue NA, RED T, blue --- KA, red --- KDR, BLACK ICAN, Green ICAL')
 line([VR VR], [-.25 0.15])
    line([VR+5 VR+5], [-.25 .15])
     line([-100 -10], [0  0])
axis([-90 30   -.25  .15])
 set(findobj('Type', 'line'), 'Linewidth',2); 
 
    
    
       
  DURATION = DY-TV;
    ISI= diff(DY);
     UPSLOPE; 

    mean(DURATION)
    mean(ISI)
 mean(UPSLOPE)


    
    
    
    

 cf = 2000;                  % carrier frequency (Hz)
sf = 22050;                 % sample frequency (Hz)
d = 1.0;                    % duration (s)
n = sf * d;                 % number of samples
s = (1:n) / sf;             % sound data preparation
s = sin(2 * pi * cf * s);   % sinusoidal modulation
sound(s, sf);               % sound presentation
pause(d + 0.5);             % waiting for sound end


    toc