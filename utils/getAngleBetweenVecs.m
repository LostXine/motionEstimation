function [ rad ] = getAngleBetweenVecs( vec1, vec2 )
% calculate angle between vectors
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - vec1
%   - vec2 same size as vec1
%  OUTPUT:
%   - rad angle in rad
rad = acos(dot(vec1,vec2)/(norm(vec1) * norm(vec2)));
end

