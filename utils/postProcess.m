function [ inner, outer, mask ] = postProcess( seq_rotation_vector )
% post processing
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - seq_rotation_vector m*1 cell - 3*1 rotation_vector
% OUTPUT:
%   - inner n*1 mat inner frame rotation degree
%   - outer (m-n)*1 mat outer frame rotation degree
%   - mask m*1
m = size(seq_rotation_vector, 1);
% save rotation degree
seq_rotation_deg = zeros(m,1);
for t = 1:m
    seq_rotation_deg(t) = formatRotationVec2Norm(seq_rotation_vector{t});
end
%% filtering rotation speed using RANSAC
mask = filteringViaRANSAC(seq_rotation_deg, 5000, 0.3);
inner = seq_rotation_deg(mask == 1);
outer = seq_rotation_deg(mask == 0);
end

