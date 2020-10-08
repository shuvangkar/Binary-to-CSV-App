clc;
close all;
clear all;

% Fs = 1000;            % Sampling frequency                    
% T = 1/Fs;             % Sampling period       
% L = 100;             % Length of signal
% t = (0:L-1)*T;        % Time vector
% 
% S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);

L = 20;
Fs = 1000;

S = [315.5
270.6
275.7
358.8
370.9
474.1
498.3
518.4
540.6
562.123
644.467
719.767
753.98
730.67
630.45
541.789
517.90
496.09
475.123
448.567
];
S = S-mean(S);

Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1)
f = Fs*(0:(L/2))/L;
maxP1 = max(P1);
% P1 = 100*(P1/maxP1)
plot(f,P1) 