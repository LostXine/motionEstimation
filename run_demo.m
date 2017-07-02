% Demo of motion estimation using artificial data
% -----------------------------------------------
% Created by Xiang Li

%% Config motion
% rotation vec: 3*1 [x y z]
set_rotation_vector = [pi/3;-pi/4;pi/6];
% rotation center: 3*1 [x y z]
set_rotation_center = [0;1;3];

%% Prepare origin points and lines in 3D
% N points: N*3 [x y z]
point_set_1 = [1,0,0;1,1,0;2,1,0;2,0,0;2,0.5,0;1.5,0,0;1,0.5,0;1.5,1,0];
% M lines marked by 2M points: 2M*3 [start_point x y z;end_point x y z]
line_set_pt_1 = [1.2 0.2 0;1.8 0.8 0;
    1.3,0.8,0;1.8,0.2,0;
    1.8 0.8 0;1.3,0.8,0];

%% Calculate target points and lines
addpath('./utils');
% N points: N*3 [x y z]
point_set_2 = forwardTransform(point_set_1,...
    set_rotation_vector,...
    set_rotation_center);
% M lines marked by 2M points: 2M*3 [start_point x y z;end_point x y z]
line_set_pt_2 = forwardTransform(line_set_pt_1,...
    set_rotation_vector,...
    set_rotation_center);

%% Format lines
line_set_1 = formatPoint2Line(line_set_pt_1);
line_set_2 = formatPoint2Line(line_set_pt_2);

%% Execute the estimation
tic;
%Please tune parameters in getConfig.m
config = getConfig();
[get_rotation_vector, get_translation_vector]=...
    estimateMotion(config,point_set_1,point_set_2,line_set_1,line_set_2);
get_rotation_center = rodrigues(get_rotation_vector)*get_translation_vector;
toc;

%% Draw the results
% prepare figure
if exist('figure_handle', 'var')
    try
        close(figure_handle);
    catch
    end;
end
figure_handle = figure;
figure_handle = drawEstimationResults(figure_handle,...
    get_rotation_vector, get_rotation_center,...
    point_set_1,point_set_2,line_set_1,line_set_2);
% draw groundtruth
figure(figure_handle)
hold on;
point_center = mean(point_set_1, 1);
set_rotation_direction = set_rotation_vector/norm(set_rotation_vector);
set_vector_center = ...
    [set_rotation_direction + point_center', point_center']';
plot3(set_vector_center(:,1),set_vector_center(:,2),...
    set_vector_center(:,3),...
    'r-','linewidth',2);
hold off;