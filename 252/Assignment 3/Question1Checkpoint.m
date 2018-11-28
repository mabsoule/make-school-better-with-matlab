% Process of speech analysis and synthesis

%clear variables
clear all;
close all;

%load voice data
load('SYDE252FUN.mat');
% play the original sound
%uncomment to play: sound(y,sr);

% get the model parameters for a 40-order filter
[a,g,x] = getModel(y,20);

% synthesis voice from the estimated parameters
newY = synthVoice(a,g,1,x,1);
% play the synthesized audio signal
%uncomment to pause: pause(5);
%uncomment to play: sound(newY,sr);

% Question 1
% add your code here, using your Fourier Transform to show 
% the spectra of the original signal and the synthesized signal
% Comment on your observation


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          ORIGINAL SIGNAL                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Declare variables
samplingRate = 1/sr; %sr is the sampling rate Ning used in his sound() function call
originalSignal = y;
signalLen = numel(originalSignal);

%Define arrays
noteFreqResults = [];
noteNamesArray = [];
plot_number = 1;

%Single interval testing code
clear parseSignalLow parseSignalHigh
parseSignalLow = 12000;
parseSignalHigh = parseSignalLow + 28000;

%Create figure for subplot
figure

% For each note interval in time domain, find peak value in frequency plot
% and output array of note frequencies 
for parseIdx = 1:numel(parseSignalLow)
    
%Assign signal
    clear signal
    signalParseLow = parseSignalLow(parseIdx);
    signalParseHigh = parseSignalHigh(parseIdx);
    signal = originalSignal(signalParseLow:signalParseHigh); %******
    
    %Plot original signal
    subplot(1,2,plot_number)
    plot_number = plot_number + 1;
    time = (1:1:signalLen);
    plot(time*samplingRate,originalSignal)
    title('Input Signal with Interval Overlayed')
    xlabel('Time') 
    ylabel('Amplitude') 
    hold on
    
    %Plot parsed version overtop
    time2 = signalParseLow:1:signalParseHigh;
    y2 = originalSignal(signalParseLow:signalParseHigh);
    plot(time2*samplingRate,y2)
    hold off
    
%Create time array for current interval 
    tlowerlim = signalParseLow; 
    tupperlim = signalParseHigh;
    dt = samplingRate; %Sampling rate of 16kHz
    tarray = tlowerlim*samplingRate:dt:tupperlim*samplingRate;

%Create frequency array for current interval 
    wlowerlim = 0;
    wupperlim = 2*pi*500;
    dw = 1;
    warray = wlowerlim:dw:wupperlim;
    
%Call fourier transform function
    Xw = MyFT(signal, tarray, warray, dt);
    Xw_magnitude = abs(Xw);
    subplot(1,2,plot_number)
    plot_number = plot_number + 1;
    warrayHz = warray/(2*pi);
    plot(warrayHz,Xw_magnitude)
    title('Fourier Transform of the Sampled Interval')
    xlabel('Frequency (Hz)') 
    ylabel('Magnitude') 
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          SYNTHESIZED SIGNAL                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Declare variables
% samplingRate = 0.01; %seconds
samplingRate = 1/sr; %sr is the sampling rate Ning used in his sound() function call
originalSignal = newY;
signalLen = numel(originalSignal);

%Declare time intervals where notes are played
    % parseSignalLow = [23330,31000,37000,51000,59000,66600,81290,88830,99500,109000,113000];
    % parseSignalHigh = parseSignalLow+2000;
    % parseSignalHigh(9)= parseSignalLow(9) + 50; %Slim band where correct octave note is found... we could alternatively test a wide range of this note and select the first large frequency peak
    % parseSignalHigh(10)= parseSignalLow(10) + 400; %Slim band where correct octave note is found... we could alternatively test a wide range of this note and select the first large frequency peak

%Define arrays
noteFreqResults = [];
noteNamesArray = [];
plot_number = 1;

%Single interval testing code
clear parseSignalLow parseSignalHigh
parseSignalLow = 12000;
parseSignalHigh = parseSignalLow + 28000;

%Create figure for subplot
figure

% For each note interval in time domain, find peak value in frequency plot
% and output array of note frequencies 
for parseIdx = 1:numel(parseSignalLow)
    
%Assign signal
    clear signal
    signalParseLow = parseSignalLow(parseIdx);
    signalParseHigh = parseSignalHigh(parseIdx);
    signal = originalSignal(signalParseLow:signalParseHigh); %******
    
    %Plot original signal
    subplot(1,2,plot_number)
    plot_number = plot_number + 1;
    time = (1:1:signalLen);
    plot(time*samplingRate,originalSignal)
    title('Input Signal with Interval Overlayed')
    xlabel('Time') 
    ylabel('Amplitude') 
    hold on
    
    %Plot parsed version overtop
    time2 = signalParseLow:1:signalParseHigh;
    y2 = originalSignal(signalParseLow:signalParseHigh);
    plot(time2*samplingRate,y2)
    hold off
    
%Create time array for current interval 
    tlowerlim = signalParseLow; 
    tupperlim = signalParseHigh;
    dt = samplingRate; %Sampling rate of 16kHz
    tarray = tlowerlim*samplingRate:dt:tupperlim*samplingRate;

%Create frequency array for current interval 
    wlowerlim = 0;
    wupperlim = 2*pi*500;
    dw = 1;
    warray = wlowerlim:dw:wupperlim;
    
%Call fourier transform function
    Xw = MyFT(signal, tarray, warray, dt);
    Xw_magnitude = abs(Xw);
    subplot(1,2,plot_number)
    plot_number = plot_number + 1;
    warrayHz = warray/(2*pi);
    plot(warrayHz,Xw_magnitude)
    title('Fourier Transform of the Sampled Interval')
    xlabel('Frequency (Hz)') 
    ylabel('Magnitude') 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Function Definitions                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FT function 
function Xw = MyFT(Xt, tarray, warray, dt)
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% end of Question 1