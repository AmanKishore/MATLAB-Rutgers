function [ output_args ] = HP4145A_getCurrent( input_args )
%HP4145A_GETCURRENT Summary of this function goes here
%   Detailed explanation goes here
clc
format shortg;
obj2 = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', 20 , 'Tag', '');
data2 = 0;
% Create the GPIB object if it does not exist
% otherwise use the object that was found.
if isempty(obj2)
    obj2 = gpib('NI', 0, 20);
else
    fclose(obj2);
    obj2 = obj2(1)
end

fopen(obj2);


data2 = query(obj2, 'IC 1?');

end