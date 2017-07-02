function [ corr_homo ] = formatNonCoor2Homo( corr_none )
% Convert non-homogeneous coordinate into homogenous one
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - corr_none N*3
% OUTPUT:
%   - corr_homo N*4
m = size(corr_none);
corr_homo = ones(m(1),4);
corr_homo(:,1:3)=corr_none;
end

