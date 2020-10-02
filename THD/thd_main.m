clc;
clear all;
close all;

Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 100;             % Length of signal
t = (0:L-1)*T;        % Time vector

%% CSV Data Read into array
fileName = "08-26-2020T19-00-00.csv";
M = csvread(fileName)

% S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
% fftBin(S,Fs)