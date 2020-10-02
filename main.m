clc;
close all;
clear all;

folder = uigetdir(pwd, 'Select a folder');
filesList = getFiles(folder,'.bin');
% FileList = dir(fullfile(Folder, '*.bin'));
for i = 1:numel(filesList)
    fileDir = filesList(i).folder;
    fileName = filesList(i).name;
    File = fullfile(fileDir, fileName);
    structFile = binToStruct(File);
    thdCsv = structToThdCSV(structFile);
%     csv = structToCsv(structFile);
%     
%     csvFileName = filenameToStr(fileName);
%     csvFile = "";
%     csvFile = csvFile + folder + '\' + csvFileName;
%     
%     fid=fopen(csvFile,'w');
%     fprintf(fid,'%s',csv);  
%     fclose(fid);
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
