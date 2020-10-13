clc;
close all;
clear all;

Fs = 1000;
ts = 1/Fs;
f = 50;

t = 0:ts: 100*ts;
H1 = 200;
H2 = 20;
H3 = 40; 
H4 = 10;
H5 = 6;
H6 = 3;
H7 = 1;
H8 = 0.5;
H9 = 0.1;
H10 = 0.1
x = H1*sin(2*pi*f*t)+H2*sin(2*pi*2*f*t)+H3*sin(2*pi*3*f*t)+H4*sin(2*pi*4*f*t);
plot(x);