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

S = [315
270
275
358
370
474
498
518
540
562
644
719
753
730
630
541
517
496
475
448
];
S = S-mean(S);

Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1)
f = Fs*(0:(L/2))/L;
maxP1 = max(P1);
P1 = 100*(P1/maxP1)
plot(f,P1) 