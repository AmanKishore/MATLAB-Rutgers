function [ data1 ] = HP153A_setWavelength( wav )
%HP153A_SETWAVELENGTH Allows user to easily set the wavelength of the HP153A 
%   Detailed explanation goes here
% Find a GPIB object.
clc
obj1 = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', 26, 'Tag', '');

% Create the GPIB object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = gpib('NI', 0, 26);
else
    fclose(obj1);
    obj1 = obj1(1);
end

% Connect to instrument object, obj1.
fopen(obj1);

% Communicating with instrument object, obj1.
S_wav = num2str(wav);
gpib_command = ['SENS2:POW:WAVE ' S_wav 'NM'];
fprintf(obj1, gpib_command);
data1 = query(obj1, 'SENS2:POW:WAVE?');
RealWave = str2num(data1)*1000000000;

end

