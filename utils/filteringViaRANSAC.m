function [ mask ] = filteringViaRANSAC( sequence, max_iter, threshold)
% filtering using RANSAC 
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - sequence N*1 sequence of rotation speed
%   - max_iter 1*1 the max times of iteration
%   - threshold 1*1 the threshold of model
% OUTPUT:
%   - mask N*1 mask of inner points
m = length(sequence);
if (m < 5)
    disp('RANSAC needs more points.');
    mask = ones(m, 1);
    return;
end
mask = zeros(m,1);
max_inner_count = 0;
%% begin to iterate
for t = 10:max_iter
    inner = randperm(m);
    inner = inner(1:3);
    inner_val = sequence(inner);
    mean_val = mean(inner_val);
    this_mask = zeros(m,1);
    inner_count = 0;
    for k = 1:m
        if abs(sequence(k) - mean_val) < threshold
            inner_count = inner_count + 1;
            this_mask(k) = 1;
        end
    end
    if max_inner_count < inner_count
        max_inner_count = inner_count;
        mask = this_mask;
    end
end
end

