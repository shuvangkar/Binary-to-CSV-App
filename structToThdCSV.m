function csv = structToThdCSV(dataStruct,offset,Fs,factor)
[n,m] = size(dataStruct);

%% Find index for per minute continuous data
idx = getDataIndex(dataStruct);
if(isempty(idx))
    msg = "No continuous data found"
    csv = "";
    return;
end
mIdx = getMinuteIndex(dataStruct,idx);

%% Heading 
harStr5 = "rms,0Hz, 50Hz, 100Hz, 150Hz, 200Hz, 250Hz";
harStr10 = "rms,0Hz, 50Hz, 100Hz, 150Hz, 200Hz, 250Hz, 300Hz, 350Hz, 400Hz, 450Hz, 500Hz";

str = "";
headStr = "";
if(Fs == 500)
    headStr = harStr5;
    str = "Time,Phase A,,,,,,,PhaseB,,,,,,, PhaseC,,,,,,, Phase N \n";
elseif (Fs == 1000)
    str = "Time,Phase A,,,,,,,,,,,,PhaseB,,,,,,,,,,,, PhaseC,,,,,,,,,,,, Phase N \n";
    headStr = harStr10;
end
str = str + "," + headStr +",";
str = str + headStr +",";
str = str + headStr +",";
str = str + headStr +"\n";
str = compose(str);

%% Calculate thd and convert csv
% offset = get_offset(dataStruct)
reverseStr = '';
n = length(mIdx);
for i = 1:n
    unixTime = dataStruct(mIdx(i)).unixTime;
%     A = [dataStruct(mIdx(i)).data(1,:) dataStruct(mIdx(i)+1).data(1,:) dataStruct(mIdx(i)+2).data(1,:) dataStruct(mIdx(i)+3).data(1,:)];
%     B = [dataStruct(mIdx(i)).data(2,:) dataStruct(mIdx(i)+1).data(2,:) dataStruct(mIdx(i)+2).data(2,:) dataStruct(mIdx(i)+3).data(2,:)];
%     C = [dataStruct(mIdx(i)).data(3,:) dataStruct(mIdx(i)+1).data(3,:) dataStruct(mIdx(i)+2).data(3,:) dataStruct(mIdx(i)+3).data(3,:)];
%     N = [dataStruct(mIdx(i)).data(4,:) dataStruct(mIdx(i)+1).data(4,:) dataStruct(mIdx(i)+2).data(4,:) dataStruct(mIdx(i)+3).data(4,:)];
    
    
    A = dataStruct(mIdx(i)).data(1,:);
    B = dataStruct(mIdx(i)).data(2,:);
    C = dataStruct(mIdx(i)).data(3,:);
    N = dataStruct(mIdx(i)).data(4,:);
%     meanA = mean(A);
%     meanB = mean(B);
%     meanC = mean(C);
%     meanN = mean(N);
%     A = A - meanA;
%     B = B - meanB;
%     C = C - meanC;
%     N = N - meanN;
%     txt = sprintf("--------------count : %d---------------",i)
    A = A - offset.meanA;
    B = B - offset.meanB;
    C = C- offset.meanC;
    N = N - offset.meanN;
    Rms.A = factor*rms(A);
    Rms.B = factor*rms(B);
    Rms.C = factor*rms(C);
    Rms.N = factor*rms(N);
    fftA = fftBin(A,offset.meanA, Fs,factor);
    fftB = fftBin(B,offset.meanB, Fs,factor);
    fftC = fftBin(C,offset.meanC, Fs,factor);
    fftN = fftBin(N,offset.meanN, Fs,factor);
    csvStr = fftsTocsv(Rms,fftA,fftB,fftC,fftN,unixTime) + "\n";
    str = str + compose(csvStr);
 %%CSV print progress 
    progress = (i/n)*100.0;
    msg = sprintf('Current FFT Conversion done: %3.1f \n', progress);
    fprintf([reverseStr, msg]);
    reverseStr = repmat(sprintf('\b'), 1, length(msg));     
    
end 

csv = str;

end

%% FFT to CSV String conversion
function fftCsv = fftsTocsv(RMS,fftA,fftB, fftC, fftN , unixTime)

str = "";
% time = unixTime - (21600*3);
time = unixTime;
dt = datetime(time,'ConvertFrom', 'posixtime');
% , 'TimeZone', 'Asia/Dhaka'
str = str + datestr( dt ) + ',';
str = str + num2str(RMS.A,'%.2f')+ ',';
str = str + fftPhaseToCsv(fftA);
str = str + num2str(RMS.B,'%.2f')+ ',';
str = str + fftPhaseToCsv(fftB);
str = str + num2str(RMS.C,'%.2f')+ ',';
str = str + fftPhaseToCsv(fftC);
str = str + num2str(RMS.N,'%.2f')+ ',';
str = str + fftPhaseToCsv(fftN);
fftCsv = str;
end

%% FFT(single phase) to CSV

function fftxCsv = fftPhaseToCsv(fftx)
str = "";
for i = 1: length(fftx.freq)
    str = str + num2str(fftx.Har(i),'%.2f')+ ',';
end
fftxCsv = str;
end

%% This functions returns all the data structure index that has continuity in more than 100 samples
function index = getDataIndex(data)
[n,m] = size(data);
index = [];
% for i = 1:n-4
%     if(data(i).endMicros+1 == data(i+1).startMicros)
%         if(data(i+1).endMicros + 1 == data(i+2).startMicros)
%             if(data(i+2).endMicros+1 == data(i+3).startMicros)
% %                     txt = sprintf("Index : %d",i)
%                     index(end+1)=i;
%             end
%         end
%     end
% end

for i = 1:n
    index(end+1)=i;
end

end

%% This functions returns the minute-wise continuous data index

function minIndex = getMinuteIndex(data,index)
[n,m] = size(data);
minIndex = [];

iCount = 1;
dt = datetime(data(1).unixTime,'ConvertFrom', 'posixtime' );
currentMin = minute(dt);
previousMin = currentMin;

for i = 1:n-4
    if(i == index(iCount))
        dt = datetime(data(i).unixTime,'ConvertFrom', 'posixtime' );
        currentMin = minute(dt);
        if(currentMin>previousMin)
            previousMin = currentMin;
            minIndex(end+1) = index(iCount);
%             dt
        end 
        iCount = iCount+1;
    end
    
end

end
