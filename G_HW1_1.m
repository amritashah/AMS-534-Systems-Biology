%% Amrita Shah    
% AMS 534    
% Homework 1    
% 2/23/23
%% 1.
a1 = -1;
b1 = 1;
a2 = -1;
b2 = 1;
n = 2000;

[x1pts, x2pts] = unif_over_rect(a1, b1, a2, b2, n);

darts_in_circ = 0;
all_darts = 0;
radius = (b1-a1)/2;
for x1 = 1:n
    for x2 = 1:n
        all_darts = all_darts + 1;
        if (x1pts(x1))^2 + (x2pts(x2))^2 <= radius^2
            darts_in_circ = darts_in_circ + 1;
        end
    end
end

fprintf('fraction of darts in unit circle = %.4f', darts_in_circ/all_darts)
fprintf('\n pi/4 = %.4f', pi/4)

function [x1pts, x2pts] = unif_over_rect(a1, b1, a2, b2, n)
    x1pts = (rand(1, n).*(b1-a1)) + a1;
    x2pts = (rand(1, n).*(b2-a2)) + a2;
end