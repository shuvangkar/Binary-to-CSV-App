function csv = structToCsv(dataStruct)
    [n,m] = size(dataStruct);
    str = compose("Date and Time,Start(ms), End(ms), Phase A, Phase B, Phase C, Neutral\n");
    
    
    reverseStr = '';
    for i = 1:n
          packetStr = strucToCsvString(dataStruct(i));
          compose(packetStr); 
          str = str + compose(packetStr);
          
          %%print progress 
          progress = (i/n)*100.0;
          msg = sprintf('Current Data Generation done: %3.1f \n', progress);
          fprintf([reverseStr, msg]);
          reverseStr = repmat(sprintf('\b'), 1, length(msg));      
    end
    csv = str;
%     fid=fopen('sample.csv','w');
%     fprintf(fid,'%s',str);  
%     fclose(fid);
end

%% This function converter single structure to to csv String 
function csvStr =  strucToCsvString(dataStruct)
    str = "";
    [m,n] = size(dataStruct.data);
    for i = 1:n
        if(i == 1)
            time = dataStruct.unixTime;
            dt = datetime(time,'ConvertFrom', 'posixtime' );
            str = str + datestr( dt ) + ',';
%             str = str + num2str(dataStruct.unixTime) + ',';
            str = str + num2str(dataStruct.startMicros) + ',';
            str = str + num2str(dataStruct.endMicros) + ',';
            str = str + num2str(dataStruct.data(1,i)) + ',';
            str = str + num2str(dataStruct.data(2,i)) + ',';
            str = str + num2str(dataStruct.data(3,i)) + ',';
            str = str + num2str(dataStruct.data(4,i)) + '\n';
        else
            str = str + ',';
            str = str + ',';
            str = str + ',';
            str = str + num2str(dataStruct.data(1,i)) + ',';
            str = str + num2str(dataStruct.data(2,i)) + ',';
            str = str + num2str(dataStruct.data(3,i)) + ',';
            str = str + num2str(dataStruct.data(4,i)) + '\n';
        end
    end
    csvStr = str;
%     A1.data(1,:)
end