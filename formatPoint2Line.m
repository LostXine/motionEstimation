function [lines] = formatPoint2Line(points)
% format start & end points into line structure
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - points 2M*3
% OUTPUT:
%   - lines M*1 -struct
%% format line stucture
line = struct('point1',zeros(1,3),'point2',ones(1,3));
%% fill data
m = floor(size(points,1)/2);
lines = repmat(line, [m 1]);
for t = 1:m
    lines(t).point1 = points(2*t-1,:);
    lines(t).point2 = points(2*t,:);
end
end

