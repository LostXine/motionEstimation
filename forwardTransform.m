function [ transformed_points ] = forwardTransform(points,...
    rotation_vector,rotation_center)
% do the forward transfrom
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - points N*3
%   - rotation_vector 3*1
%   - rotation_center 3*1
% OUTPUT:
%   - transformed_points N*3
points_homo = formatNonCoor2Homo(points);
rotation_mat = rodrigues(rotation_vector);
% format transform mat
transform_mat = [rotation_mat rotation_mat'*rotation_center;zeros(1,3),1];
ptset_trans_homo = (transform_mat * points_homo')';
transformed_points = formatHomoCoor2Non(ptset_trans_homo);
end

