for idx = 1:3

    % Generate strings for file and image names:
    file_name = sprintf('data/inflammation-%02d.csv', idx);
    img_name = sprintf ('patient_data-%02d.png', idx);

    patient_data = csvread(file_name);

    disp(['Maximum inflammation: ', num2str(max(patient_data(:)))]);
    disp(['Minimum inflammation: ', num2str(min(patient_data(:)))]);
    disp(['Standard deviation: ', num2str(std(patient_data(:)))]);

    ave_inflammation = mean(patient_data, 1);

    figure('visible', 'off')

    subplot(2, 2, 1);
    plot(ave_inflammation);
    ylabel('average')

    subplot(2, 2, 2);
    plot(max(patient_data, [], 1));
    ylabel('max')

    subplot(2, 2, 3);
    plot(min(patient_data, [], 1));
    ylabel('min')

    print(img_name,'-dpng');
    close();

end
