function [points] = formatLine2Point(lines)
% format line structure into start & end points
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - lines M*1 -struct
% OUTPUT:
%   - points 2M*3
m = length(lines);
points = zeros(2*m,3);
for t = 1:m
    points(2*t-1,:) = lines(t).point1;
    points(2*t  ,:) = lines(t).point2;
end
end

