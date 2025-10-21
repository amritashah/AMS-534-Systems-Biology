% i1 = i2 = 0
clear
fig2 = figure(2);
a1 = 3;
a2 = 2.5;
b = 4;
g = 4;
i1 = 0;
i2 = 0;
p1ticks = 0:0.1:3.5;
p2ticks = 0:0.1:3.5;
[p1, p2] = meshgrid(p1ticks, p2ticks);
dp1_dt = (a1 ./ (1+ ((p2./(1+i2)).^b))) - p1;
dp2_dt = (a2 ./ (1+ ((p1./(1+i1)).^g))) - p2;
quiver(p1, p2, dp1_dt, dp2_dt, 1.2)
xlabel('p1')
ylabel('p2')
title('Figure 2')
xlim([0 3.5])
ylim([0 3.5])
hold on
% null clines
p2_scale = 0:0.1:3.5;
p1_nc = a1 ./ (1+ ((p2_scale./(1+i2)).^b));
plot(p1_nc, p2_scale)

p1_scale = 0:0.1:3.5;
p2_nc = a2 ./ (1+ ((p1_scale./(1+i1)).^g));
plot(p1_scale, p2_nc)
hold off

% i1 = 0, i2 = 10
clear
fig3 = figure(3);
a1 = 3;
a2 = 2.5;
b = 4;
g = 4;
i1 = 0;
i2 = 10;
p1ticks = 0:0.1:3.5;
p2ticks = 0:0.1:3.5;
[p1, p2] = meshgrid(p1ticks, p2ticks);
dp1_dt = (a1 ./ (1+ ((p2./(1+i2)).^b))) - p1;
dp2_dt = (a2 ./ (1+ ((p1./(1+i1)).^g))) - p2;
quiver(p1, p2, dp1_dt, dp2_dt, 1.2)
xlabel('p1')
ylabel('p2')
title('Figure 3')
xlim([0 3.5])
ylim([0 3.5])
hold on
% null clines
p2_scale = 0:0.1:3.5;
p1_nc = a1 ./ (1+ ((p2_scale./(1+i2)).^b));
plot(p1_nc, p2_scale)

p1_scale = 0:0.1:3.5;
p2_nc = a2 ./ (1+ ((p1_scale./(1+i1)).^g));
plot(p1_scale, p2_nc)
hold off
