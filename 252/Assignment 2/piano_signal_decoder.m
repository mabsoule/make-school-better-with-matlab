%Load required variables
clear 
load('Music1.mat')
%load('Music2.mat')
load('pianoNotes.mat')

%Declare sampling rate
samplingRate = 1/16000; %seconds

%Declare time intervals where notes are played
parseSignalLow = [22000,26000,30500,34000,39000,47000,52000,57000,64000];
parseSignalHigh = [23000,29500,32000,39000,44000,52000,57000,62000,68000];

%Single interval testing code
% clear parseSignalLow parseSignalHigh
% parseSignalLow = 22000;
% parseSignalHigh = 23000;

%Define arrays
noteFreqResults = [];
noteNamesArray = [];
plot_number = 1;

% %Plots for tuning
% time = 1:1:104609;
% plot(time*samplingRate,acqData)
% 
% %Plots for tuning
% hold on
% time2 = parseSignalLow:1:parseSignalHigh;
% acqData2 = acqData(parseSignalLow:parseSignalHigh);
% plot(time2*samplingRate,acqData2)
% hold off

% For each note interval in time domain, find peak value in frequency plot
% and output array of note frequencies 
for parseIdx = 1:numel(parseSignalLow)
    
%Assign signal
    clear signal
    signalParseLow = parseSignalLow(parseIdx);
    signalParseHigh = parseSignalHigh(parseIdx);
    signal = acqData(signalParseLow:signalParseHigh);
    
    %Plot original signal
    subplot(9,2,plot_number)
    plot_number = plot_number + 1;
    time = 1:1:104609;
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
    subplot(9,2,plot_number)
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