clear

% Define the bounds and time-step for time domain
tlowerlim = -10;
tupperlim = 10;
dt = 0.01;
tarray = tlowerlim:dt:tupperlim;

% Define the x-axis vector for frequency domain
dw = 0.01;
wlowerlim = -10;
wupperlim = 10;
warray = wlowerlim:dw:wupperlim;

%Finds the FT or iFT and plots it - TEST CASES
%Xt = tsignal(tarray);
%Xw = MyFT(Xt, warray, dt, tlowerlim, tupperlim);
%plot(warray, Xw)
Xw = wsignal(warray);
newXt = MyiFT(Xw, tarray, dw, wlowerlim, wupperlim);
plot(tarray,newXt)

% Takes a time-domain function and evaluates it at each point of tarray
%Inputs = time-valued function and t-array (on line 29)
function xt = tsignal(tarray)
    size = numel(tarray);
    results = zeros(1, size);
    for i = 1:size
        results(i) = cos(tarray(i)); %put time signal here, evaluated at tarray(i)
    end
    xt = results;
end

% Inputs: tarray, warray, Time-domain signal evaluated at every point of tarray
% Output: The fourier transform of the time-domain signal evaluated at every point of warray
function Xw = MyFT(Xt, warray, dt, tlowerbound, tupperbound)
    tarray = tlowerbound:dt:tupperbound
    wsize = numel(warray);
    tsize = numel(tarray);
    Xw = zeros(0, wsize);
    for i = 1:wsize
        operation = zeros(0, tsize);
        for k = 1:tsize
            operation(k) = dt*Xt(k)*exp(-1j*warray(i)*tarray(k));
        end
        Xw(i) = sum(operation);
    end
end

% Takes a frequency-domain function and evaluates it at each point of warray
% Inputs = frequency-domain signal (on line 56)
function xw = wsignal(warray)
    size = numel(warray);
    results = zeros(1, size);
    for i = 1:size
        results(i) = 1; %put frequency-valued signal here, evaluated at warray(i)
    end
    xw = results;
end

% Inputs: warray, tarray, time-domain signal evaluated at every point of tarray
% Output: The inverse fourier transform of the frequency-domain signal evaluated at every point of tarray
function Xt = MyiFT(Xw, tarray, dw, wlowerbound, wupperbound)
    warray = wlowerbound:dw:wupperbound;
    wsize = numel(warray);
    tsize = numel(tarray);
    Xt = zeros(0, tsize);
    for i = 1:tsize
        operation = zeros(0, wsize);
        for k = 1:wsize
            operation(k) = dw*(1/(2*pi()))*(Xw(k)*exp(1j*tarray(i)*warray(k)));
        end
        Xt(i) = sum(operation);
    end
end
