%% 2. 
X_initial = 0.00079;
maxT = 100;
t = 0:maxT;
X = zeros(size(t));
store = zeros(1,50);


X(1) = X_initial;
for r = 2:0.01:4
    for i = 1:maxT
        if i>50
            store(i-50) = X(i);
        end
        X(i+1) = r*X(i)*(1-X(i));
    end
    xaxis = r*ones(50);
    scatter(xaxis, store, 'black', '.')
    hold on
end

hold off
xlabel('r')
ylabel('x')