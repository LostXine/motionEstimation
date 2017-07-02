function [ cost ] = costFunctionPointDistanceStd( ptset1,ptset2 )
% point distance standard deviation
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - ptset1 N*3
%   - ptset2 N*3
% OUTPUT:
%   - cost
n = length(ptset1);
len_seq = zeros(n,1);
len_vec = ptset1 - ptset2;
len_mean = mean(len_vec,1);
for t = 1:n
    len_this = len_vec(t,:) - len_mean;
    len_seq(t) = len_this * len_this';
end
cost = sqrt(sum(len_seq)/n);
end

