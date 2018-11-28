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
%                       Visualize Signals FT                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% variables
samplingRate = 1/sr; %sr is the sampling rate Ning used in his sound() function call (8000Hz) therefore period is 1/sr
parseLow = 13000; %parse signal to section of speech to reduce noise
parseHigh = parseLow + 39300;
name = ["Original Signal with Interval Overlayed","Fourier Transform of Original Signal", "Synthysized Signal with Interval Overlayed","Fourier Transform of Sythysized Signal"];

% declare signal for original signal
signal = y;
plot_number = 1;
play = y(parseLow:parseHigh);
sound(play,sr);

% create figure for subplot
figure

% call visualize function
visualizeFT(signal,samplingRate, parseLow, parseHigh, plot_number, name)

% declare signal for synthysized signal
clear signal
signal = newY;
plot_number = 3;

% call visualize function
visualizeFT(signal,samplingRate, parseLow, parseHigh, plot_number, name)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Function Definitions                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Visualize the Fourier Transform
function void = visualizeFT(signal, samplingRate, parseLow, parseHigh, plot_number, name)
    %Assign signal
    clear signalParsed
    signalParsed = signal(parseLow:parseHigh);

    %Plot original signal
    subplot(2,2,plot_number)
    plot_number = plot_number + 1;
    time = (1:1:numel(signal));
    plot(time*samplingRate,signal)
    title(name(plot_number-1));
    xlabel('Time') 
    ylabel('Amplitude') 
    hold on

    %Plot parsed version overtop
    time2 = parseLow:1:parseHigh;
    plot(time2*samplingRate,signalParsed)
    hold off
    
    %Create time array for current interval 
    tarray = parseLow*samplingRate:samplingRate:parseHigh*samplingRate;

    %Create frequency array for current interval 
    wlowerlim = 2*pi*0;
    wupperlim = 2*pi*1000; %Human voice: fundemental frequency is typically between 85Hz-180Hz (male) 165 - 255Hz (female) to see harmonics lets go to 1000)
    dw = 1;
    warray = wlowerlim:dw:wupperlim;
    
    %Call fourier transform function
    Xw = MyFT(signalParsed, tarray, warray, samplingRate);
    
    %Plot magnitude
    Xw_magnitude = abs(Xw);
    subplot(2,2,plot_number)
    plot_number = plot_number + 1;
    warrayHz = warray/(2*pi);
    plot(warrayHz,Xw_magnitude)
    title(name(plot_number-1))
    xlabel('Frequency (Hz)') 
    ylabel('Magnitude') 
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% end of Question 1