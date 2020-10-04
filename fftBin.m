function data = fftBin(samples,Fs)

x = [];
if(Fs == 500)
    x = samples(1:10);
elseif(Fs == 1000)
    x = samples(1:20);
end
L = length(x);

Y = fft(x);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

% f = Fs*(0:(L/2))/L
df = Fs/L;
f = 0:df:Fs/2;

maxP1 = max(P1);
P1 = 100*(P1/maxP1);

% f_main = f(mod(f,50)==0); %only keep the main harmonics component

data.freq = [];
data.Har = [];
for i = 1:length(f)
    if(mod(f(i),50)==0)
        data.freq(end+1) = f(i);
        data.Har(end+1) = P1(i);
%         sprintf("F : %d | H : %d",f(i),P1(i))
    end
end

% plot(f,P1) 


end