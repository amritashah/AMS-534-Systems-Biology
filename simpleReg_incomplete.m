function simpleReg

x = [0 1 2 3]';
y = x;
testSlopes = 2:-0.25:0;

clf;
hold on;
subplot(1,2,1), plot(x,y,'b*'), axis([0 4 0 6]);
xlabel('x')
ylabel('y')
hold on;
subplot(1,2,2), plot(0,0), axis([0 3 0 20]);
xlabel('\beta')
ylabel('S(\beta)')

for b = testSlopes
    hold on;
    subplot(1,2,1), plot(x,x*b,'g-');
    auxS = S(x,y,b);
    hold on;
    subplot(1,2,2), plot(b,auxS,'r*');
    disp([b auxS]);
    input('Press a key ...');
end



end
