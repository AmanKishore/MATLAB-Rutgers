function [ data2 ] = HP8168F_setPower( pow )
%HP8168F_SETPOWER %Allows user to easily set the power of the HP8168F
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

fopen(obj2);

S_pow = num2str(pow);
gpib_command1 = ['SOUR:POW:LEV:IMM:AMP ' S_pow 'MW'];
fprintf(obj2, gpib_command1);
data2 = query(obj2, 'SOUR:POW:LEV:IMM:AMP?');

end

