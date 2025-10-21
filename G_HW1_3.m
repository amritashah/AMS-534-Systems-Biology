%% 3.
clear
global a1 a2 b g 

a1 = 3;
a2 = 2.5;
b = 4;
g = 4;

t = [0 40]';
p0 = [0 2.5]';

fig1 = figure(1);
[t, x_out] = ode45(@xdot, t, p0);
plot(t, x_out);
xlabel('time')
ylabel('concentration')
title('Figure 1')
legend('p1', 'p2')

function d = xdot(t,p)
global a1 a2 b g
if t<10
    i1 = 0;
    i2 = 0;
elseif t>=10 && t<=20
    i1 = 0;
    i2 = 10;
elseif t>20 && t<30
    i1 = 0;
    i2 = 0;
elseif t>=30
    i1 = 10;
    i2 = 0;
end
d = zeros(2, 1);
d(1) = (a1 / (1+ (p(2)/(1+i2))^b)) - p(1);
d(2) = (a2 / (1+ (p(1)/(1+i1))^g)) - p(2);
end

