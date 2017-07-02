function [ cost ] = costFunctionPointOrientation( ptset1,ptset2 )
% point orientation cost
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - ptset1 N*3
%   - ptset2 N*3
% OUTPUT:
%   - cost
n = length(ptset1);
ori_seq = zeros(n,1);
ori_vec = ptset1 - ptset2;
ori_mean = mean(ori_vec,1);
for t = 1:n
    ori_this = ori_vec(t,:);
    ori_rad = getAngleBetweenVecs(ori_mean, ori_this);
    ori_seq(t) = abs(ori_rad);
end
cost = mean(ori_seq);
end
