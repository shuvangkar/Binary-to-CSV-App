clc;
clear all;
close all;

Fs = 500;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 50;             % Length of signal
t = (0:L-1)*T;        % Time vector


S = sin(2*pi*50*t) + 0.7*sin(2*pi*150*t);
fftx = fftBin(S,Fs)