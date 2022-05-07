function [ p_data1 ] = HP8168F_setWavelength( wav )
%HP8168F_SETWAVELENGTH %Allows user to easily set the wavelength of the HP8168F
%   Detailed explanation goes here
% Find a GPIB object.
clc
format shortg;
obj2 = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', 24, 'Tag', '');
data2 = 0;
% Create the GPIB object if it does not exist
% otherwise use the object that was found.
if isempty(obj2)
    obj2 = gpib('NI', 0, 24);
else
    fclose(obj2);
    obj2 = obj2(1)
end

S_wav = num2str(wav);
gpib_command = ['SOUR:WAVE:CW ' S_wav 'NM'];
fprintf(obj2, gpib_command);
data1 = query(obj2, 'SOUR:WAVE:CW?')
p_data1 = str2num(data1)*1000000000

end

