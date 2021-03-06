function [ data2 ] = HP4145A_setVoltage( volt )
%HP4145A_SETVOLTAGE Set the voltage of the HP4145A
%   Detailed explanation goes here

    % Find a GPIB object.
clc
format shortg;
obj2 = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', 20 , 'Tag', '');
% Create the GPIB object if it does not exist
% otherwise use the object that was found.
if isempty(obj2)
    obj2 = gpib('NI', 0, 20);
else
    fclose(obj2);
    obj2 = obj2(1)
end

fopen(obj2);

fprintf(obj2, 'US;');
fprintf(obj2, 'IT1 CA1 BC;');
fprintf(obj2, 'DE CH1, ''V1'', ''I1'', 1, 3;');
fprintf(obj2, 'DE CH2, ''V2'', ''I2'', 1, 3;');
fprintf(obj2, 'CH1; CH3; CH4;');
fprintf(obj2, 'VS1; VS2; VS3; VS4;');

fprintf(obj2, 'CH 1, ''volt'', ''curr'', 1, 1;');
fprintf(obj2, 'VS 1, ''volts'', 1;');
fprintf(obj2, 'VM 1, ''voltm'', 1;');
fprintf(obj2, 'VR 1, 20.000, 2.0000, 1.0000, 1.000mA;');

voltage = num2str(volt);

gpib_command1 = ['SS VC 1, ' voltage ', 100.00mA;'];
gpib_command = ['DV 1, 0, ' voltage ', 50mA;']
fprintf(obj2,'MD ME2;');
%disp('Test')
fprintf(obj2,'MD ME4;');
%disp('Test1')
fprintf(obj2, gpib_command);
disp('Test2')
fprintf(obj2, 'DO ''V1'';');
pause(1);
fprintf(obj2, 'WT 1.000s;');
disp('Test3')
data2 = fscanf(obj2);
pause(0.5);
disp('Test4')
end