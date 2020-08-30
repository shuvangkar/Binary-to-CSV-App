function files = getFiles(directory,fileType)
    extension = strcat('*',fileType);
    filesInfo = dir(fullfile(directory,extension));
    files = filesInfo;
%     files = [filesInfo.name];
end