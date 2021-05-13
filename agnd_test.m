file_dir = './agnd_test/csv_parsed/';
int_agnd_file = [file_dir 'agnd_internal_no_pulse_parsed.csv'];
ext_agnd_file = [file_dir 'agnd_external1V65_no_pulser_parsed.csv'];
int_agnd_neg_file = [file_dir 'internal_agnd1V63_odds_neg_parsed.csv'];
int_agnd_pos_file = [file_dir 'internal_agnd1V63_odds_pos_parsed.csv'];
ext_agnd_neg_file = [file_dir 'agnd_external1V65_odd_negative_parsed.csv'];
ext_agnd_pos_file = [file_dir 'external_agnd1V65_odds_pos_parsed.csv'];

int_agnd_data = csvread(int_agnd_file);
ext_agnd_data = csvread(ext_agnd_file);
int_agnd_neg_data = csvread(int_agnd_neg_file);
int_agnd_pos_data = csvread(int_agnd_pos_file);
ext_agnd_neg_data = csvread(ext_agnd_neg_file);
ext_agnd_pos_data = csvread(ext_agnd_neg_file);

%% no pulse
figure; box on;
subplot(2,1,1);
hist_int_hg_no_pulse = histogram(int_agnd_data(:,1), 100);
title('TVC Buffer with Internal AGND -- No Pulse', 'FontSize', 18, 'FontWeight', 'Bold');
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('ADC Counts', 'FontWeight', 'Bold', 'FontSize', 18);
ylabel('Number of samples', 'FontWeight', 'Bold', 'FontSize', 18);
subplot(2,1,2);
hist_ext_hg_no_pulse = histogram(ext_agnd_data(:,1), 100);
title('TVC Buffer with External AGND -- No Pulse', 'FontSize', 18, 'FontWeight', 'Bold');
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('ADC Counts', 'FontWeight', 'Bold', 'FontSize', 18);
ylabel('Number of samples', 'FontWeight', 'Bold', 'FontSize', 18);

figure; box on;
subplot(2,1,1);
x = linspace(0, length(int_agnd_data), length(int_agnd_data));
hist_int_hg_no_pulse = plot(x, int_agnd_data(:,1));
ylim([0 65]);
title('TVC Buffer with Internal AGND -- No Pulse', 'FontSize', 18, 'FontWeight', 'Bold');
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('Sample Number', 'FontWeight', 'Bold', 'FontSize', 18);
ylabel('ADC Count', 'FontWeight', 'Bold', 'FontSize', 18);

subplot(2,1,2);
x = linspace(0, length(ext_agnd_data), length(ext_agnd_data));
hist_ext_hg_no_pulse = plot(x, ext_agnd_data(:,1));
ylim([0 65]);
title('TVC Buffer with External AGND -- No Pulse', 'FontSize', 18, 'FontWeight', 'Bold');
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('Sample Number', 'FontWeight', 'Bold', 'FontSize', 18);
ylabel('ADC Count', 'FontWeight', 'Bold', 'FontSize', 18);

%% neg pulse
figure; box on;
subplot(2,1,1);
hist_int_hg_no_pulse = histogram(int_agnd_neg_data(:,1), 100);
title('TVC Buffer with Internal AGND -- Neg Pulse', 'FontSize', 18, 'FontWeight', 'Bold');
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('ADC Counts', 'FontWeight', 'Bold', 'FontSize', 18);
ylabel('Number of samples', 'FontWeight', 'Bold', 'FontSize', 18);

subplot(2,1,2);
hist_ext_hg_no_pulse = histogram(ext_agnd_neg_data(:,1), 100);
title('TVC Buffer with External AGND -- Neg Pulse', 'FontSize', 18, 'FontWeight', 'Bold');
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('ADC Counts', 'FontWeight', 'Bold', 'FontSize', 18);
ylabel('Number of samples', 'FontWeight', 'Bold', 'FontSize', 18);

figure; box on;
subplot(2,1,1);
x = linspace(0, length(int_agnd_neg_data), length(int_agnd_neg_data));
hist_int_hg_no_pulse = plot(x, int_agnd_neg_data(:,1));
ylim([0 65]);
title('TVC Buffer with Internal AGND -- Neg Pulse', 'FontSize', 18, 'FontWeight', 'Bold');
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('ADC Counts', 'FontWeight', 'Bold', 'FontSize', 18);
ylabel('Number of samples', 'FontWeight', 'Bold', 'FontSize', 18);

subplot(2,1,2);
x = linspace(0, length(ext_agnd_neg_data), length(ext_agnd_neg_data));
hist_ext_hg_no_pulse = plot(x, ext_agnd_neg_data(:,1));
ylim([0 65]);
title('TVC Buffer with External AGND -- Neg Pulse', 'FontSize', 18, 'FontWeight', 'Bold');
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('ADC Counts', 'FontWeight', 'Bold', 'FontSize', 18);
ylabel('Number of samples', 'FontWeight', 'Bold', 'FontSize', 18);

%% Pos Pulse
figure; box on;
subplot(2,1,1);
hist_int_hg_no_pulse = histogram(int_agnd_pos_data(:,1), 100);
title('TVC Buffer with Internal AGND -- Pos Pulse', 'FontSize', 18, 'FontWeight', 'Bold');
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('ADC Counts', 'FontWeight', 'Bold', 'FontSize', 18);
ylabel('Number of samples', 'FontWeight', 'Bold', 'FontSize', 18);

subplot(2,1,2);
hist_ext_hg_no_pulse = histogram(ext_agnd_pos_data(:,1), 100);
title('TVC Buffer with External AGND -- Pos Pulse', 'FontSize', 18, 'FontWeight', 'Bold');
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('ADC Counts', 'FontWeight', 'Bold', 'FontSize', 18);
ylabel('Number of samples', 'FontWeight', 'Bold', 'FontSize', 18);

figure; box on;
subplot(2,1,1);
x = linspace(0, length(int_agnd_pos_data), length(int_agnd_pos_data));
hist_int_hg_no_pulse = plot(x, int_agnd_pos_data(:,1));
ylim([0 65]);
title('TVC Buffer with Internal AGND -- Pos Pulse', 'FontSize', 18, 'FontWeight', 'Bold');
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('ADC Counts', 'FontWeight', 'Bold', 'FontSize', 18);
ylabel('Number of samples', 'FontWeight', 'Bold', 'FontSize', 18);

subplot(2,1,2);
x = linspace(0, length(ext_agnd_pos_data), length(ext_agnd_pos_data));
hist_ext_hg_no_pulse = plot(x, ext_agnd_pos_data(:,1));
ylim([0 65]);
title('TVC Buffer with External AGND -- Pos Pulse', 'FontSize', 18, 'FontWeight', 'Bold');
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('ADC Counts', 'FontWeight', 'Bold', 'FontSize', 18);
ylabel('Number of samples', 'FontWeight', 'Bold', 'FontSize', 18);