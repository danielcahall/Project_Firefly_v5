function x = cascadingFilter(x, n, N)
for i = 1:n
    x = movingAverageFilter(x, N);
end
end

