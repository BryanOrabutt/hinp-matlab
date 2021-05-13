file_root = './csv_parsed3/';
hg_data_file = [file_root 'chip0_neg_sweep_50m_1_25V_hgbuff25p_hg_parsed.csv'];
tvc_data_file = [file_root 'chip0_neg_sweep_50m_1_25V_hgbuff25p_tvc_parsed.csv'];
hit_data_file = [file_root 'chip0_neg_sweep_50m_1_25V_hgbuff25p_hit_parsed.csv'];

hg_data = csvread(hg_data_file);
tvc_data = csvread(tvc_data_file);
hit_data = csvread(hit_data_file);

hg_data(1,:) = [];
tvc_data(1,:) = [];
hit_data(1,:) = [];

for i=1:1
    figure; box on;hold on;
    %subplot(2,1,1); 
    energy_data = hg_data(:, 2*i);
    time_data = tvc_data(:, 2*i);
    ind = find(~hit_data(:, 2*i));
    energy_data(ind) = [];
    time_data(ind) = [];
    
    h = scatter(time_data, energy_data, 25, 'r', 'filled');
    channel_num = num2str((i-1)*2 + 1);
    t = strcat("Positive 3V pulse TVC vs Energy for Channel", {' '}, ...
        channel_num);
    title(t, 'FontSize', 22);
    set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
        'TickLength', [0.015 0.015]);
    ylabel('Energy Reading', 'FontWeight', 'Bold', "Interpreter", ...
        "latex", 'FontSize', 20);
    xlabel('TVC Reading', 'FontWeight', 'Bold', "Interpreter", ...
        "latex", 'FontSize', 20);
    set(gcf, "units", "normalized", "outerposition", [0 0 1 1]);
    ylim([0 max(energy_data)*1.1]);
    
    fig_name = strcat("./tvc_vs_energy/channel", channel_num, ...
        "_plot.pdf");
    saveas(gcf, fig_name); 
end
