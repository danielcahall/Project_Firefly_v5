function [x] = weightedMovingAverage(x, N)

M = N*(N+1)/2;
z = 0;
for i = N:length(x)
    y = 0;
    for j = 1:N
        y = y + j/M*x(j);
        z = z + j/M;
    end
    x(i) = y;
    z = 0;
end


end

