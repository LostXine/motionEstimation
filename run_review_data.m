% Review all the sequence data
% -----------------------------------------------
% Created by Xiang Li

%% sequence control
index = [10;15;20;30;35];

%% prepare container
p = length(index);
set_rotation_speed = zeros(p,1);
get_rotation_speed = zeros(p,1);
inner_percentage = zeros(p,1);
%% start main loop
addpath('./utils');
for t = 1:p
    load(['./data/rotation_' num2str(index(t)) '_dpf.mat']);
    [inner, outer, mask] = postProcess(rotation_vector_sequence);
    seq_length = length(mask);
    set_rotation_speed(t) = -groundtruth; % reversed due to different coordinate system
    get_rotation_speed(t) = mean(inner);
    inner_percentage(t) = length(inner)/seq_length;
    %% draw the result after post processing
    figure(1)
    subplot(1,p,t);
    hold on;
    % draw inner
    plot(inner,'go');
    % draw outer
    plot(outer,'rx');
    % draw ground_truth
    plot([1;seq_length], [set_rotation_speed(t);set_rotation_speed(t)], 'g--');
    text(seq_length/2,set_rotation_speed(t),...
        ['Groundtruth:' num2str(set_rotation_speed(t)) 'deg/frame'],...
        'HorizontalAlignment','Center');
    % draw rotation_speed
    plot([1;seq_length], [get_rotation_speed(t);get_rotation_speed(t)], 'b--');
    text(seq_length/2,get_rotation_speed(t),...
        ['Estimation:' num2str(get_rotation_speed(t)) 'deg/frame'],...
        'HorizontalAlignment','Center');
    hold off;
    xlabel('frame');
    ylabel('deg');
    axis([1;seq_length;-5;0]);
    title(['Speed at ' num2str(groundtruth) 'deg/frame']);
    grid on;
end
figure(2);
plot(abs([set_rotation_speed set_rotation_speed]),...
    abs([set_rotation_speed get_rotation_speed]),'x-');
axis([0.5;4.0;0.5;4.0]);
xlabel('rotation speed groundtruth(deg/frame)');
ylabel('rotation speed estimation(deg/frame)');
grid on;
hold on;
for t = 1:p
    text(abs(set_rotation_speed(t)),abs(get_rotation_speed(t)),...
        ['Inner:' num2str(inner_percentage(t)*100) '%'],...
        'HorizontalAlignment','Center','VerticalAlignment','Bottom')
end
hold off;

