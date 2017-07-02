function [ rotation_vector, translation_vector, cost_list ] = ...
    estimateMotion(config, point_set_1, point_set_2,...
    line_set_1, line_set_2,...
    last_rotation_vector)
% estimate motion via lines and points
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - config 1*1 struct
%   - point_set_1 N*3 matched points in frame 1
%   - point_set_2 N*3 matched points in frame 2
%   - line_set_1 N*3 matched lines in frame 1
%   - line_set_2 N*3 matched lines in frame 2
%   - (optional) last_rotation_vector 3*1
% OUTPUT:
%   - rotation_vector 3*1
%   - translation_vector 3*1
%   - cost_list 5*1 5 parts of cost
if nargin < 6
    config.ci = 0;
    % default axis:
    last_rotation_vector = [0;0;1];
end
% initialize start point
rotation_vector = last_rotation_vector;
translation_vector = mean(point_set_1,1)';
%% STAGE 1 FIND ROTATIOIN VECTOR
option = optimset('fminsearch');
option.MaxFunEvals = 100000;
option.TolX = 10e-7;
[rotation_vector] = fminsearch(...
    @(x)costFunctionRotation(x,config,point_set_1,point_set_2,...
    line_set_1,line_set_2,last_rotation_vector),...
    rotation_vector,option);
[cost, cost_list] = costFunctionRotation(rotation_vector, config,...
    point_set_1,point_set_2, line_set_1,line_set_2,last_rotation_vector);
% figure(2);
% bar(cost_list);
point_set_tmp = forwardTransform(point_set_1,rotation_vector,zeros(3,1));
%% STAGE 2 FIND TRANSLATION VECTOR
[translation_vector] = fminsearch(@(x)costFunctionTranslation(x,...
    point_set_tmp,point_set_2),translation_vector,option);
% rotation_vector = rotation_vector_solution;
end