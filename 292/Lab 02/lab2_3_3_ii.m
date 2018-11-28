%Define Variables 
R2 = 20050;
R3 = 19607.84314;
C4 = 95*10^-12;
f = [100, 500, 1000, 5000, 10000, 50000, 100000, 500000, 1000000];

%Convert to w (angular frequency) in rad/sec
w = (2*pi()).*f;

%Define magnitude of Gain
g =((((R3*(R2+R3))./((w.*(C4*R2*R3)).^2 +((R2+R3)^2))).^2)    +    (((R3*(w.*(C4*R2*R3)))./((w.*(C4*R2*R3)).^2+((R2+R3)^2))).^2)).^0.5;

%Convert to magnitude of Gain in dB
g = 20*log10(g)


%BONUS FOR VISUALIZATION
%Convert to w (angular frequency) in rad/sec
f = 100:1000000; %redefined for plotting
w = (2*pi()).*f;

%Define magnitude of Gain
g =((((R3*(R2+R3))./((w.*(C4*R2*R3)).^2 +((R2+R3)^2))).^2)    +    (((R3*(w.*(C4*R2*R3)))./((w.*(C4*R2*R3)).^2+((R2+R3)^2))).^2)).^0.5;

%Convert to magnitude of Gain in dB
g = 20*log10(g);

semilogx(f,g);
ylim([-22, 0]);
