function [ corr_none ] = formatHomoCoor2Non( corr_homo )
% Convert homogeneous coordinate into non-homogenous one
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - corr_homo N*4
% OUTPUT:
%   - corr_none N*3
m = size(corr_homo);
corr_none = zeros(m(1),3);
for t = 1:m(1)
    corr_none(t,:) = corr_homo(t,1:3)/corr_homo(t,4);
end
end
