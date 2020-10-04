clc;
close all;
clear all; 

F   = 50;       % AC Frequency
Fs  = 1000;     %Sampling Frequency
N   = 100;      %Total Sample to process


Ts = 1/Fs;
t = 0:Ts:Ts*(N-1);

x = cos(2*pi*F*t)+ 0.7*cos(2*pi*3*F*t) ;

%%  FFT
Xdft = fft(x);
% xdft = xdft(1:length(x)/2+1); % even length signal
% 
% df = Fs/N;
% freqvec = 0:df:Fs/2;
Xdft_abs = abs(Xdft/N);

Xdft2 = Xdft_abs(1:N/2+1)
df = Fs/N;
f = 0:df:Fs/2;
%% Plotting
subplot(2,1,1);
plot(t,x);

subplot(2,1,2);
plot(f,Xdft2)