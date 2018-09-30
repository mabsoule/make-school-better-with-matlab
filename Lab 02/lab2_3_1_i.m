%Define Variables 
R2 = 500;
R3 = 10000;
C4 = 47*10^-6;
w = 1:100000;

%Define magnitude of Gain
g =((((R3*(R2+R3))./((w.*(C4*R2*R3)).^2 +((R2+R3)^2))).^2)    +    (((R3*(w.*(C4*R2*R3)))./((w.*(C4*R2*R3)).^2+((R2+R3)^2))).^2)).^0.5;

%Plot Gain (Vout/Vin) vs Frequency (rad/s)
plot(w,g)
xlim([0,500])
xlabel('Frequency (rad/s)')
ylabel('Gain (Vout/Vin)')
title('Gain (Vout/Vin) vs Frequency (rad/s)')

%Plot Gain (Vout/Vin) vs Frequency (rad/s) with x as log scale
figure
semilogx(w,g)
xlabel('Frequency (rad/s)')
ylabel('Gain (Vout/Vin)')
title('Gain (Vout/Vin) vs Frequency (rad/s) with Logarithmic Freq Scale')

%Plot Gain (dB) vs Frequency (rad/s) with x as log scale
figure
semilogx(w,20*log10(g))
xlabel('Frequency (rad/s)')
ylabel('Gain (Vout/Vin)')
title('Gain (dB) vs Frequency (rad/s) with Logarithmic Freq Scale')


