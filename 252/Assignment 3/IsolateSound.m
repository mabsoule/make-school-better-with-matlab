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




l = 12000; %parse signal to section of speech to reduce noise
h = parseLow + 28000;


signal = y(parseLow:parseHigh);
sound(y,sr);

clear signal






