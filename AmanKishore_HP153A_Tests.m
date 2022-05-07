% Find a GPIB object.
clc
obj1 = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', 26, 'Tag', '');

% Create the GPIB object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = gpib('NI', 0, 26);
else
    fclose(obj1);
    obj1 = obj1(1)
end

% Connect to instrument object, obj1.
fopen(obj1);

% Communicating with instrument object, obj1.
fprintf(obj1, 'SENS2:POW:WAVE 1520NM');
data1 = query(obj1, 'SENS2:POW:WAVE?')
fprintf(obj1, 'SENS2:POW:UNIT DBM');
fprintf(obj1, 'SENS2:POW:ATIME 200MS');