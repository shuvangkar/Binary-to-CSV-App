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

S = [
653
542
517
493
467
435
341
269
243
277
391
480
506
531
554
596
694
758
774
724
602
533
507
483
458
401
308
254
248
316
];
S = S(1:20);
S = S-mean(S);
Smin = min(S)
Smax = max(S)
% dcblker = dsp.DCBlocker('Algorithm','FIR','Length',length(S));
% dc1 = dsp.DCBlocker('Algorithm','IIR','Order', 6);
% y = dcblker(Savg)
% Ymin = min(y)
% Ymax = max(y)
% y2 = dc1(Savg)
% Y2min = min(y2)
% Y2max = max(y2)
% subplot(2,1,1);



Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1)
f = Fs*(0:(L/2))/L;
maxP1 = max(P1);
% P1 = 100*(P1/maxP1)
subplot(3,1,1);
plot(S);
hold on;
subplot(3,1,2)
plot(f,P1)
hold on
% subplot(3,1,3)
% plot(ifft(P1))