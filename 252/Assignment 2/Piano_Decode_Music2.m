%Load required variables
clear 
%load('Music1.mat')
load('Music2.mat')
load('pianoNotes.mat')

%Play music
sound(acqData,16000);

%Declare sampling rate
samplingRate = 1/16000; %seconds

% %Low pass filter the data to get rid of high noise frequencies
% filteredSignal = zeros(0,130529);
% filteredSignal2 = zeros(0,130529);
% for i = 1:130527
%     filteredSignal(i) = (acqData(i)+acqData(i+1)+acqData(i+2))/3;
% end
% filteredSignal(i+1) = acqData(i+1);
% filteredSignal(i+2) = acqData(i+2);
% for j = 1:130527
%     filteredSignal2(j) = (filteredSignal(j)+filteredSignal(j+1)+filteredSignal(j+2))/3;
% end
% filteredSignal2(j+1) = filteredSignal(j+1); %final value is just equal to itself since no future value to average 
% filteredSignal2(j+2) = filteredSignal(j+2);

%Declare time intervals where notes are played
parseSignalLow = [23330,31000,37000,51000,59000,66600,81290,88830,99500,109000,113000];
parseSignalHigh = parseSignalLow+2000;
parseSignalHigh(9)= parseSignalLow(9) + 50; %Slim band where correct octave note is found... we could alternatively test a wide range of this note and select the first large frequency peak
parseSignalHigh(10)= parseSignalLow(10) + 400; %Slim band where correct octave note is found... we could alternatively test a wide range of this note and select the first large frequency peak

%Define arrays
noteFreqResults = [];
noteNamesArray = [];
plot_number = 1;

% %Single interval testing code
% clear parseSignalLow parseSignalHigh
% parseSignalLow = 109000;
% parseSignalHigh = parseSignalLow + 400;
% 
% %Plots for tuning
% time = 1:1:130529;
% figure
% plot(time,acqData)
% title('Original Signal')
% 
% %Plots for tuning
% hold on
% time2 = parseSignalLow:1:parseSignalHigh;
% acqData2 = acqData(parseSignalLow:parseSignalHigh);
% plot(time2,acqData2)
% hold off
% 
% figure
% plot(time,filteredSignal)
% title('Smoothed Signal')
% 
% figure
% plot(time,filteredSignal2)
% title('Smoothed Signal 2')


%Create figure for subplot
figure

% For each note interval in time domain, find peak value in frequency plot
% and output array of note frequencies 
for parseIdx = 1:numel(parseSignalLow)
    
%Assign signal
    clear signal
    signalParseLow = parseSignalLow(parseIdx);
    signalParseHigh = parseSignalHigh(parseIdx);
    signal = acqData(signalParseLow:signalParseHigh); %******
    
    %Plot original signal
    subplot(11,2,plot_number)
    plot_number = plot_number + 1;
    time = 1:1:130529;
    plot(time*samplingRate,acqData)
    title('Input Signal with Interval Overlayed')
    xlabel('Time') 
    ylabel('Amplitude') 
    hold on
    
    %Plot parsed version overtop
    time2 = signalParseLow:1:signalParseHigh;
    acqData2 = acqData(signalParseLow:signalParseHigh);
    plot(time2*samplingRate,acqData2)
    hold off
    
%Create time array for current interval 
    tlowerlim = signalParseLow; 
    tupperlim = signalParseHigh;
    dt = samplingRate; %Sampling rate of 16kHz
    tarray = tlowerlim*samplingRate:dt:tupperlim*samplingRate;

%Create frequency array for current interval 
    wlowerlim = 0;
    wupperlim = 2*pi*4186;
    dw = 1;
    warray = wlowerlim:dw:wupperlim;
    
%Call fourier transform function
    Xw = MyFT(signal, tarray, warray, dt);
    Xw_magnitude = abs(Xw);
    subplot(11,2,plot_number)
    plot_number = plot_number + 1;
    warrayHz = warray/(2*pi);
    plot(warrayHz,Xw_magnitude)
    title('Fourier Transform of the Sampled Interval')
    xlabel('Frequency (Hz)') 
    ylabel('Magnitude') 

%Find max value in XwMagnitude array, peak in frequency graph
    [val, maxIdx] = max(Xw_magnitude);
    noteFreqResults = [noteFreqResults, warray(maxIdx)];

%Convert angular freq to Hz
    noteFreqResultsHz = noteFreqResults/(2*pi);
 
%Find note names
    idx = numel(noteFreqResultsHz);
        f = noteFreqResultsHz(idx);
        n = round(((12*log2(f/440))+49),0); % round to nearest integer
        if 0 < n < 89
            noteName = noteNamesFull(n);
            noteNamesArray = [noteNamesArray, noteName];
        else
            noteNamesArray = [noteNamesArray, 'out of range'];
        end
    
%Output notes array as they are found   
    noteNamesArray 
end

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