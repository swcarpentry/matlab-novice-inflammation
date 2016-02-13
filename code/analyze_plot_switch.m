
% plot_switch:
%   0 - show plots interactively
%   1 - save plots to disk

plot_switch = 0;

for idx = 1:3

    % Generate strings for file and image names:
    file_name = sprintf('data/inflammation-%02d.csv', idx);
    img_name = sprintf ('patient_data-%02d', idx);

    patient_data = csvread(file_name);
    ave_inflammation = mean(patient_data, 1);

    if plot_switch == 1
        figure('visible', 'off')
    else
        figure('visible', 'on')
    end

    subplot(2, 2, 1);
    plot(ave_inflammation);
    ylabel('average')

    subplot(2, 2, 2);
    plot(max(patient_data, [], 1));
    ylabel('max')

    subplot(2, 2, 3);
    plot(min(patient_data, [], 1));
    ylabel('min')

    if plot_switch == 1
        print(img_name,'-dpng');   
        close()
    end

end
