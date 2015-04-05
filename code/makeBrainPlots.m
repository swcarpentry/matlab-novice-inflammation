close all 
clear all

load('../data/brain_data_for_BrainMap.mat');
load('../data/EEG_ParticipantB_30_09_2013.mat');


left = (data_epochs_B(:,data_key_B==3));
for idx = 1:62
data_compressed_left(idx,:) = mean(left(100*idx-99:100*idx,:));
end
left_mean = mean(data_compressed_left,2);
BrainMap(left_mean,x_full, y_full, mx, my);

right = (data_epochs_B(:,data_key_B==2));
for idx = 1:62
data_compressed_right(idx,:) = mean(right(100*idx-99:100*idx,:));
end
right_mean = mean(data_compressed_right,2);
BrainMap(right_mean,x_full, y_full, mx, my);

neither = (data_epochs_B(:,data_key_B==1));
for idx = 1:62
data_compressed_neither(idx,:) = mean(neither(100*idx-99:100*idx,:));
end
neither_mean = mean(data_compressed_neither,2);
BrainMap(neither_mean,x_full, y_full, mx, my);
