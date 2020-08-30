function data = binToStruct(fileDir)
    
    col = 4;
    row = 120/col;
    %% Binary C structure format
    c_Struct = ...
    {'uint32',   [1 1],      'unixTime'; ...
     'uint32',  [1 1],      'startMicros'; ...
     'uint32',  [1 1],      'endMicros'; ...
     'uint16',   [col row],  'data'
    };
    %% Read File
    structFile = memmapfile(fileDir,'format',c_Struct);
    data = structFile.Data;
end