% Find a GPIB object.
obj1 = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', 20, 'Tag', '');

% Create the GPIB object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = gpib('NI', 0, 20);
else
    fclose(obj1);
    obj1 = obj1(1)
end

% Connect to instrument object, obj1.
fopen(obj1);

figure;
for volt = 0.5: 0.001: 2.000
    vol = HP4145A_setVoltage(volt);
    curr = HP4145A_setCurrent(100);
    plot(vol, curr,'x');
    drawnow;
    hold on;
end