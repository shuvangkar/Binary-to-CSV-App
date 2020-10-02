function data = fftBin(x,Fs)

L = length(x);

Y = fft(x);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

maxP1 = max(P1);
P1 = 100*(P1/maxP1);

f_main = f(mod(f,50)==0); %only keep the main harmonics component


for i = 1:length(f)
       if(mod(i,50)==0)
           
       end
end

plot(f,P1) 


end