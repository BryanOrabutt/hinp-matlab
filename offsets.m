file_root = './csv_long_fall_parsed/';
offset_data_file = [file_root 'chan1_244ns_20ns_offset_pos_tvc_short_tvc_parsed.csv'];
tvc_data_file = [file_root 'chan1_244ns_pos_tvc_parsed.csv'];
hit_data_file = [file_root 'chan1_244ns_pos_hit_parsed.csv'];
offset_hit_data_file = [file_root 'chan1_244ns_20ns_offset_pos_tvc_short_hit_parsed.csv'];

offset_data = csvread(offset_data_file);
tvc_data = csvread(tvc_data_file);
hit_data = csvread(hit_data_file);
offset_hit_data = csvread(offset_hit_data_file);

offset_data(1,:) = [];
tvc_data(1,:) = [];
hit_data(1,:) = [];
offset_hit_data(1, :) = [];
channel_offsets = zeros(1, 8);
average_tvc = zeros(1, 8);
average_offsets = zeros(1, 8);

for i=1:1
    offset_tvc_data = offset_data(:, 2*i);
    time_data = tvc_data(:, 2*i);
    ind = find(~hit_data(:, 2*i));
    ind2 = find(~offset_hit_data(:, 2*i));
    offset_tvc_data(ind2) = [];
    time_data(ind) = [];
    moff = mean(offset_tvc_data);
    m = mean(time_data);
    diff20 = m-moff;
    count_per_ns = round(diff20/20);
    
    micro_count = 1000*count_per_ns;
    offset_count = 1020*count_per_ns;
    channel_offsets(i) = round(m) - micro_count;
    average_offsets(i) = round(moff) - offset_count;
    
    
    average_tvc(i) = mean(tvc_data(:,2*i)) - channel_offsets(i);
    
end

figure; box on;
scatter(linspace(1,15,8), channel_offsets, 85, 'r', 'filled');
scatter(linspace(1,15,8), average_offsets, 85, 'b', 'filled');
title("TVC offsets for odd channels", 'FontSize', 22);
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('Channel number', 'FontWeight', 'Bold', "Interpreter", ...
    "latex", 'FontSize', 20);
ylabel('ADC Counts', 'FontWeight', 'Bold', "Interpreter", ...
    "latex", 'FontSize', 20);
xlim([0 16]);
%ylim([0 max(channel_offsets)*1.1]);
xticks(linspace(1,15,8));
xticklabels(linspace(1,15,8));
ax = gca;
ax.XRuler.Exponent = 0;
ax.YRuler.Exponent = 0;

figure; box on; hold on;
tvc_data(:, ~any(tvc_data, 1)) = [];
plot_data = mean(tvc_data);
scatter(linspace(1,15,8), plot_data, 85, 'r', 'filled');
scatter(linspace(1,15,8), average_tvc, 85, 'b', 'filled');
title("TVC Linearity between Channels", 'FontSize', 22);
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('Channel number', 'FontWeight', 'Bold', "Interpreter", ...
    "latex", 'FontSize', 20);
ylabel('ADC Counts', 'FontWeight', 'Bold', "Interpreter", ...
    "latex", 'FontSize', 20);
legend('TVC Average', 'TVC Average Offset Adjusted', 'FontSize', 20, ...
    'Location', 'best');
xlim([0 16]);
%ylim([0 max(plot_data)*1.1]);
xticks(linspace(1,15,8));
xticklabels(linspace(1,15,8));
ax = gca;
ax.XRuler.Exponent = 0;
ax.YRuler.Exponent = 0;
hold off;
