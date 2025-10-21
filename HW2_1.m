%% Amrita Shah    
% AMS 534    
% Homework 2    
% 3/28/23
%% 1.
Xsteps = 50;
Ysteps = 50;
generations = 100;
cells = zeros(Xsteps,Ysteps,generations);
cells(:,:,1) = randi([0 1],Xsteps,Ysteps);

for g = 1:generations
    for x = 1:Xsteps
        for y = 1:Ysteps
                    
            % west
            if x==1
                w = cells(Xsteps,y,g);
            else
                w = cells(x-1,y,g);
            end

            % east
            if x==Xsteps
                e = cells(1,y,g);
            else
                e = cells(x+1,y,g);
            end

            % south
            if y==Ysteps
                n = cells(x,1,g);
            else
                n = cells(x,y+1,g);
            end

            % north
            if y==1
                s = cells(x,Ysteps,g);
            else
                s = cells(x,y-1,g);
            end

            % southwest
            if x==1
                if y==Ysteps
                    sw = cells(Xsteps,1,g);
                else
                    sw = cells(Xsteps,y+1,g);
                end
            else
                if y==Ysteps
                    sw = cells(x-1,1,g);
                else
                    sw = cells(x-1,y+1,g);
                end
            end

            % northwest
            if x==1
                if y==1
                    nw = cells(Xsteps,Ysteps,g);
                else
                    nw = cells(Xsteps,y-1,g);
                end
            else
                if y==1
                    nw = cells(x-1,Ysteps,g);
                else
                    nw = cells(x-1,y-1,g);
                end
            end

            % southeast
            if x==Xsteps
                if y==Ysteps
                    se = cells(1,1,g);
                else
                    se = cells(1,y+1,g);
                end
            else
                if y==Ysteps
                    se = cells(x+1,1,g);
                else
                    se = cells(x+1,y+1,g);
                end
            end

            % northeast
            if x==Xsteps
                if y==1
                    ne = cells(1,Ysteps,g);
                else
                    ne = cells(1,y-1,g);
                end
            else
                if y==1
                    ne = cells(x+1,Ysteps,g);
                else
                    ne = cells(x+1,y-1,g);
                end
            end
            
            % cell fate
            neighbors = w + e + n + s + sw + nw + se + ne;
            if cells(x,y,g) == 1
                if neighbors == 2 || neighbors == 3
                    cells(x,y,g+1) = 1;
                else
                    cells(x,y,g+1) = 0;
                end
            elseif cells(x,y,g) == 0
                if neighbors == 3
                    cells(x,y,g+1) = 1;
                else
                    cells(x,y,g+1) = 0;
                end
            else
                disp('error')
            end
        end
    end
end

fig1 = figure(1);
imagesc(cells(:,:,1));
title('Initial Cell Population, gen 0')
fig2 = figure(2);
imagesc(cells(:,:,generations+1));
title('Final Cell Population, gen 100')