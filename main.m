% Shuvangkar Shuvo
% Binary file to CSV conversion 
% with fft calculation

clc;
close all;
clear all;

Fs = 1000;           %Samplng Frequency
thdGen = true;      % generate thd 
dataGen = true;     %Generate Data file

CT_AND_ADC_FACTOR = 2.2246595745*100*(4.8828125e-3);
PT_AND_ADC_FACTOR = 1.5;


folder = uigetdir(pwd, 'Select a folder');
filesList = getFiles(folder,'.bin');
% FileList = dir(fullfile(Folder, '*.bin'));
for i = 1:numel(filesList)
    fileDir = filesList(i).folder;
    fileName = filesList(i).name;
    File = fullfile(fileDir, fileName);
    structFile = binToStruct(File);
    offset = get_offset(structFile)
    %% THD Store to CSV
    if(thdGen)
        thdCsv = structToThdCSV(structFile,offset,Fs, CT_AND_ADC_FACTOR);
        thdFileName = filenameToStr(fileName);
        thdFile = "";
        thdFile = thdFile + folder + "\fft_"+ thdFileName;
        fidThd = fopen(thdFile,'w');
        fprintf(fidThd,'%s',thdCsv);
        fclose(fidThd);    
    end
    %% Raw Data store to CSV
    if(dataGen)
        csv = structToCsv(structFile,offset);
        csvFileName = filenameToStr(fileName);
        csvFile = "";
        csvFile = csvFile + folder + '\data_' + csvFileName;
        fid=fopen(csvFile,'w');
        fprintf(fid,'%s',csv);  
        fclose(fid);
    end

end



function dateTimeStr = filenameToStr(fileName)
    name = fileName;
    month = name(1:2);
    day = name(3:4);
    year = num2str(str2num(name(5:6))+2000);
    hour = name(7:8);
    
    str = "";
    str = str + month + "-";
    str = str + day + "-";
    str = str + year;
    str = str + "T";
    str = str + hour + '-00-00.csv';
    dateTimeStr = str;

end
