function [ cost ] = costFunctionTranslation(translation_vector,...
    ptset1,ptset2)
% rotation cost function
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - translation_vector 3*1
%   - point_set_1 N*3 matched points in frame 1
%   - point_set_2 N*3 matched points in frame 2
% OUTPUT:
%   - cost value
m = length(ptset1);
distance_seq = zeros(m,1);
for t = 1:m
    distance_val = ptset1(t,:) + translation_vector' - ptset2(t,:);
    distance_seq(t) = distance_val * distance_val';
end
cost = mean(distance_seq);
end

