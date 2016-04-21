function [y] = movingAverageFilter(x, N)
y=zeros(size(x));
M = N/2;
for i = 1:M
    y(i) = mean(x(1:i+M));
end
for i = M+1:length(x)-M
    y(i) = mean(x(i-M:i+M));
end
for i = (length(x)-M+1):length(x)
    y(i) = mean(x(i-M:end));
end
end



