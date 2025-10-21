%% 2.
ru = 0.19;
Xsteps = 30;
Ysteps = 30;
timesteps = 25;
u = zeros(Xsteps,Ysteps,timesteps);
u(10:20, 10:20, 1) = 1;

for t = 1:timesteps
    for x = 1:Xsteps
        for y = 1:Ysteps
            diff = -4*u(x,y,t);
            if x==1
                if y==1
                    diff = diff + u(Xsteps,y,t) + u(x+1,y,t) + u(x,Ysteps,t) + u(x,y+1,t); 
                elseif y==Ysteps
                    diff = diff + u(Xsteps,y,t) + u(x+1,y,t) + u(x,y-1,t) + u(x,1,t);
                else
                    diff = diff + u(Xsteps,y,t) + u(x+1,y,t) + u(x,y-1,t) + u(x,y+1,t);
                end
            elseif x==Xsteps
                if y==1
                    diff = diff + u(x-1,y,t) + u(1,y,t) + u(x,Ysteps,t) + u(x,y+1,t); 
                elseif y==Ysteps
                    diff = diff + u(x-1,y,t) + u(1,y,t) + u(x,y-1,t) + u(x,1,t);
                else
                    diff = diff + u(x-1,y,t) + u(1,y,t) + u(x,y-1,t) + u(x,y+1,t);
                end
            else
                if y==1
                    diff = diff + u(x-1,y,t) + u(x+1,y,t) + u(x,Ysteps,t) + u(x,y+1,t); 
                elseif y==Ysteps
                    diff = diff + u(x-1,y,t) + u(x+1,y,t) + u(x,y-1,t) + u(x,1,t);
                else
                    diff = diff + u(x-1,y,t) + u(x+1,y,t) + u(x,y-1,t) + u(x,y+1,t);
                end
            end
            u(x,y,t+1) = u(x,y,t) + ru*diff;
        end
    end
end

fig1 = figure(1);
imagesc(u(:,:,1));
title('Initial Concentrations of u, t=0')
fig2 = figure(2);
imagesc(u(:,:,timesteps+1));
title('Final Concentrations of u, t=25')
