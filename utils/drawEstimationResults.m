function [ figure_handle ] = drawEstimationResults(handle,...
    rotation_vector, rotation_center,...
    point_set_1, point_set_2, line_set_1, line_set_2 )
% draw estimation results
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - rotation_vector 3*1
%   - rotation_center 3*1
%   - point_set_1 N*3 matched points in frame 1
%   - point_set_2 N*3 matched points in frame 2
%   - line_set_1 N*3 matched lines in frame 1
%   - line_set_2 N*3 matched lines in frame 2
% OUTPUT:
%   - figure_handle 
% Calculate the points and lines after estimated transformation
point_set_estimated = forwardTransform(point_set_1,...
    rotation_vector,...
    rotation_center);
lines_set_pt_estimated = forwardTransform(formatLine2Point(line_set_1),...
    rotation_vector,...
    rotation_center);
line_set_estimated = formatPoint2Line(lines_set_pt_estimated);
% prepare figure
figure_handle = figure(handle);
hold on;
grid on;
% Draw the point clouds and lines
% origin is in blue
plot3(point_set_1(:,1),point_set_1(:,2),point_set_1(:,3),'bx');
% target is in red
plot3(point_set_2(:,1),point_set_2(:,2),point_set_2(:,3),'rx');
% estimation is in green
plot3(point_set_estimated(:,1),...
    point_set_estimated(:,2),...
    point_set_estimated(:,3),'gx');
% draw the corresponding lines between points.
for t = 1:size(point_set_1, 1)
    % corresponding between origin and target
    corr1 = [point_set_1(t,:);point_set_2(t,:)];
    plot3(corr1(:,1),corr1(:,2),corr1(:,3),'r--');
    % corresponding between origin and estimation
    corr2 = [point_set_1(t,:);point_set_estimated(t,:)];
    plot3(corr2(:,1),corr2(:,2),corr2(:,3),'g--');
end
% draw lines
line_set_e = line_set_estimated;
for t = 1:size(line_set_1, 1)
    plot3([line_set_1(t).point1(1);line_set_1(t).point2(1)],...
        [line_set_1(t).point1(2);line_set_1(t).point2(2)],...
        [line_set_1(t).point1(3);line_set_1(t).point2(3)],'b-');
    plot3([line_set_2(t).point1(1);line_set_2(t).point2(1)],...
        [line_set_2(t).point1(2);line_set_2(t).point2(2)],...
        [line_set_2(t).point1(3);line_set_2(t).point2(3)],'r-');
    plot3([line_set_e(t).point1(1);line_set_e(t).point2(1)],...
        [line_set_e(t).point1(2);line_set_e(t).point2(2)],...
        [line_set_e(t).point1(3);line_set_e(t).point2(3)],'g-');
end
% draw rotation vector
point_center = mean(point_set_1, 1);
get_rotation_direction = rotation_vector/norm(rotation_vector);
get_vector_center = ...
    [get_rotation_direction + point_center', point_center']';
plot3(get_vector_center(:,1),get_vector_center(:,2),...
    get_vector_center(:,3),...
    'g-','linewidth',2);
set(gca,'DataAspectRatio',[1 1 1]);
title('Features in Space');
view(3);
hold off;
end

