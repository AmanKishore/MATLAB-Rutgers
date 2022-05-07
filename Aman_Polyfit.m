function[max_power] = Aman_Polyfit(wav,dwav)

clc
format short
close all
file_name='Wavelength_vs_MaxPower.fig';
fig1=openfig(file_name);

if wav < (1475 + dwav) || wav > (1590 - dwav)
    fprintf('The value of the wavelength must be greater than 1475 + delta wavelength and less than 1590 - delta wavelength \n');
    
    return;
end

h = gcf;
H = get(h,'Children');
HP = get(H,'Children');
x = cell2mat(get(HP,'Xdata'));
y = cell2mat(get(HP,'Ydata'));
z = 1475:0.01:1590;
interval = -1;

if mod(wav,1) == 0
    interval = -1;
    mult = 1;
elseif mod(wav,0.1) == 0
    interval = -0.1;
    mult = 10;
elseif mod(wav,0.01) == 0
    interval = -0.01;
    mult = 100;
elseif mod(wav,0.001) == 0
    interval = -0.001;
    mult = 1000;
end
up = ceil(wav) + dwav;
down = floor(wav) - dwav;
p = interp1(up:-1:down,y(x>=down & x<=up),up:interval:down,'spline');
max_power = interp1(x, y,wav,'spline');
max_powtemp = max_power * mult;
max_powtempt = round(max_powtemp);
max_power = max_powtempt/mult;
plot(x,y,'',up:interval:down,p)
%a = polyfit(x,y,5)
%fitting = polyval(a,z)
%plot(x,y,'',z,fitting)