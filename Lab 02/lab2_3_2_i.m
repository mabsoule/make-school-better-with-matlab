%Define Variables
R = 4700;
C = 0.033*10^-6;
Vin = 5; %Arbitrary voltage selected
f = 0:10000;
%f = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 2000, 4000, 10000];

%Convert frequency in Hz to frequency in rad/s
w = 2*pi()*f;

%Define Gain (dB) and frequency (hz) relationship
g = 20*log10(sqrt((1./((w.*R*C)+1)).^2    +   ((w.*R*C)./((w.*R*C).^2+1)).^2));

%Plot Gain (dB) and frequency (hz)
semilogx(f,g)
xlabel('Frequency (Hz)')
ylabel('Gain (dB)')
title('Gain (dB) vs Frequency (Hz) with Logarithmic Freq Scale')

%Plot -3dB cutoff
hold on
y(1:10001) = -3;
semilogx(f,y)
hold off


%Define Phase (degrees) and frequency (hz) relationship
p = (180/pi()).*-1*atan(w.*R*C);

%Plot Phase (degrees) and frequency (hz)
figure
semilogx(f,p)
xlabel('Frequency (Hz)')
ylabel('Phase (degrees)')
title('Phase (degrees) vs Frequency (Hz) with Logarithmic Freq Scale')

%Plot -45 degree cutoff (half power is from capacitor, half from resistor)
hold on
y(1:10001) = -45;
semilogx(f,y)
hold off



