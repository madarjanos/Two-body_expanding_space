%Animation from existing t vs x-y data
fprintf('*** Stop (break) with Ctrl+C ***');

%length of time vector
n = (length(t) - 1);
%partitioning (assuming 1000 time points in one orbit period if T = 1)
%change this if needed
m = 50;

%figure
figure(1);
minx = min(x);
maxx = max(x);
minx = minx - (maxx - minx)*0.1;
maxx = maxx + (maxx - minx)*0.1;
miny = min(y);
maxy = max(y);
miny = miny - (maxy - miny)*0.1;
maxy = maxy + (maxy - miny)*0.1;
axis([minx maxx miny maxy]);
axis equal
%plot in small steps
for ix = 1:m:n
    %plot old and new and center
    plot(x(1:ix),y(1:ix),'b-', x(ix:ix+m), y(ix:ix+m), 'k.', [0], [0],'r.');
    axis([minx maxx miny maxy]);
    %write the %
    s = sprintf('%.0f%%',ix/n*100);
    title(s);
    %show
    drawnow
    %wait a little
    pause(0.1)
end
