function [ cost, cost_list ] = costFunctionRotation( rotation_vector,...
    config,point_set_1,point_set_2,line_set_1,line_set_2,...
    last_rotation_vector)
% rotation cost function
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - rotation_vector 3*1
%   - config 1*1 struct
%   - point_set_1 N*3 matched points in frame 1
%   - point_set_2 N*3 matched points in frame 2
%   - line_set_1 N*3 matched lines in frame 1
%   - line_set_2 N*3 matched lines in frame 2
%   - last_rotation_vector 3*1
% OUTPUT:
%   - cost value
%   - cost_list (5 parts of cost)
%% forword transformation 
ptsetB = point_set_2;
rotation_mat = rodrigues(rotation_vector);
% [R]3x3 [ptA]3x1 = [ptB]3x1
% [R]3x3 [ptA]'3x1 = [ptB]'3x1
ptsetA = (rotation_mat * point_set_1')';
lsetB = line_set_2;
lsetpt1 = formatLine2Point(line_set_1);
lsetptA =(rotation_mat * lsetpt1')';
lsetA = formatPoint2Line(lsetptA);
%% calculate cost
cost_p_1 = costFunctionPointOrientation(ptsetA,ptsetB);
cost_p_2 = costFunctionPointDistanceStd(ptsetA,ptsetB);
cost_l = costFunctionLineOrientation(lsetA,lsetB);
cost_list = [cost_p_1;cost_p_2;cost_l;
    abs(getAngleBetweenVecs(rotation_vector, last_rotation_vector));
    norm(rotation_vector)];
weight_list = [config.cp * config.c1;
    config.cp * config.c2;
    config.cl * config.c3;
    config.ci;
    config.cn];
cost = weight_list' * cost_list;
end

