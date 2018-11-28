
%Declare time intervals where notes are played
parseSignalLow = [22000,26000,30500,34000,39000,47000,52000,57000,64000];
parseSignalHigh = [25000,29500,34000,39000,44000,52000,57000,62000,68000];

% clear parseSignalLow parseSignalHigh
% parseSignalLow = 22500;
% parseSignalHigh = 25000;

noteFreqResults = [];
noteNamesArray = [];

% For each note interval in time domain, find peak value in frequency plot
% and output array of note frequencies 
for parseIdx = 1:numel(parseSignalLow)
    
%Assign signal
    clear signal
    signalParseLow = parseSignalLow(parseIdx);
    signalParseHigh = parseSignalHigh(parseIdx);
    signal = acqData(signalParseLow:signalParseHigh);

%Create time array for interval 
    tlowerlim = signalParseLow; 
    tupperlim = signalParseHigh;
    dt = 1/16000; %Sampling rate of 16kHz
    tarray = tlowerlim/16000:dt:tupperlim/16000;

%Create frequency array for interval 
    wlowerlim = 0;
    wupperlim = 2*pi*4186;
    dw = 1;
    warray = wlowerlim:dw:wupperlim;
    
%Call fourier transform function
    Xw = MyFT(signal, tarray, warray, dt);
%     figure
%     plot(warray,Xw)
    XwMagnitude = abs(Xw);
    figure
    plot(warray,XwMagnitude)

%Find max value in XwMagnitude array, peak in frequency graph
    [val, maxIdx] = max(XwMagnitude);
    noteFreqResults = [noteFreqResults, warray(maxIdx)]

%Convert angular freq to Hz
    noteFreqResultsHz = noteFreqResults/(2*pi);
 
%Find note names
    idx = numel(noteFreqResultsHz)
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