function [ cost ] = costFunctionLineOrientation( lines1,lines2 )
% line orientation cost
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - lines1 m*1 struct
%   - lines2 m*1 struct
% OUTPUT:
%   - cost
m = length(lines1);
if m == 0
    cost = 0;
    return;
end
rad_seq = zeros(m,1);
for t = 1:m
    vec1 = lines1(t).point1 - lines1(t).point2;
    vec2 = lines2(t).point1 - lines2(t).point2;
    rad = getAngleBetweenVecs(vec1, vec2);
    if rad > pi/2
        rad = pi - rad;
    end
    rad_seq(t) = abs(rad);
end
cost = mean(rad_seq);
end
