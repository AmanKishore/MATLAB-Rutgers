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
all_data = zeros(115,2);

fopen(obj2);

% Communicating with instrument object, obj1.
figure;
i = 1;
for wav = 1475: 1: 1590
    S_wav = num2str(wav);
    gpib_command = ['SOUR:WAVE:CW ' S_wav 'NM'];
    fprintf(obj2, gpib_command);
    data1 = query(obj2, 'SOUR:WAVE:CW?')
    p_data1 = str2num(data1)*1000000000;
    i = i + 1;
    fprintf(obj2, 'OUTP ON');
    for pow = 0.01: 0.01: 9.88
        old_data2 = data2;
        S_pow = num2str(pow);
        gpib_command1 = ['SOUR:POW:LEV:IMM:AMP ' S_pow 'MW'];
        fprintf(obj2, gpib_command1);
        data2 = query(obj2, 'SOUR:POW:LEV:IMM:AMP?');
        if data2 == old_data2
            display(old_data2)
            p_data2 = str2num(old_data2)*1000;
            plot(p_data1, p_data2,'x');
            drawnow;
            hold on;
            all_data(i,1) = p_data1;
            all_data(i,2) = p_data2;
            break;
        end
    end
end
all_data