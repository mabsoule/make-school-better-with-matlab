% the process of speech analysis and synthesis
clear all;
close all;

%load voice data
load('SYDE252FUN.mat');
% play the original sound
% sound(y,sr);
% get the model parameters for a 40-order filter
[a,g,x] = getModel(y,20);

% synthesis voice from the estimated parameters
newY = synthVoice(a,g,1,x,1);
% play the synthesized audio signal
% pause(5);
% sound(newY,sr);
% pause(5);

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
%visualizeFT(signal,samplingRate, parseLow, parseHigh, plot_number, name)

% declare signal for synthysized signal
clear signal
signal = newY;
plot_number = 3;

% call visualize function
%visualizeFT(signal,samplingRate, parseLow, parseHigh, plot_number, name)

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


% %% Changing the speed of the speech, without significantly modifying the tone of the speech
% % play the audio at half speed
% sound(y,sr/2);
% % play the audio at double speed
% sound(y,sr*2);
% % Question 2
% 
% 
% % end of Question 2
% % Question 3: changing the length of x, without changing its general shape
% x_f = interp1(); % finish this line to generate x_f[n] for faster speech
% x_s = interp1(); % finish this line to generate x_s[n] for slower speech
% % end of Question 3
% 
% % synthesis voices using the x_fast and x_slow you just generated
% y_f = synthVoice(a,g,1,x_f,0.5);
% y_s = synthVoice(a,g,1,x_s,2);
% 
% % play the synthesized audio signal
% sound(y_f,sr);
% sound(y_s,sr);
% 
% 
% %% changing the tone without changing the speed
% 
% % move the poles so the resulting system function would have a higher gain
% % at higher frequencies
% aHigh = myMovePoles(a,0.2);
% % synthesis the speech with the new system and the original x[n], resulting in a speech with
% % higher tone, but at the same speed as the original signal
% yHigh = synthVoice(aHigh,g,1,x,1);
% % play the new signal
% sound(yHigh,sr);
% 
% 
% % move the poles so the resulting system function would have a higher gain
% % at lower frequencies
% aLow = myMovePoles(a,-0.2);
% % synthesis the speech with the new system and the original x[n], resulting in a speech with
% % lower tone, but at the same speed as the original signal
% yLow = synthVoice(aLow,g,1,x,1);
% % play the new signal
% sound(yLow,sr);