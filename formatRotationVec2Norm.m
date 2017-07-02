function [ deg ] = formatRotationVec2Norm( rotation_vector )
% simplify rotation vector and convert it into deg
% Created by Xiang Li
% ----------------------------------------- %
% INPUT:
%   - rotation_vector
% OUTPUT:
%   - deg
rad = norm(rotation_vector);
while rad > pi
    rad  = rad - 2*pi;
end
while rad < -pi
    rad = rad + 2*pi;
end
deg = rad / pi*180;
end

