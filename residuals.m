file_root = './csv_nimbin_parsed/';
hg_data_file = [file_root 'odds_pos_4mv_3V_heatsink_hg_parsed.csv'];
tvc_data_file = [file_root 'odds_pos_4mv_3V_heatsink_lg_parsed.csv'];
hit_data_file = [file_root 'odds_pos_4mv_3V_heatsink_hit_parsed.csv'];

hg_data = csvread(hg_data_file);
tvc_data = csvread(tvc_data_file);
hit_data = csvread(hit_data_file);

hg_data(1,:) = [];
tvc_data(1,:) = [];
hit_data(1,:) = [];

fig_folder = './figs_no_cutoff/';

adc_step = 3.3/2^14;
energy_scale_factor_lg = 400/3;
energy_scale_factor_hg = 100/3;

sweep_start = 0.004;
sweep_end = 3;
sweep_steps = 11;
sweep_increment = linspace(sweep_start,sweep_end,sweep_steps);


for i=8:8
    figure; box on;
    subplot(2,1,1); 
    hist_data = hg_data(:, 2*i);
    ind = find(~hit_data(:, 2*i));
    hist_data(ind) = [];
    %hist_data = hist_data(hist_data < 12000);
    h = histogram(hist_data, 1000);
    
    hold on;
    counts = h.BinCounts;
    counts = [1 counts];
    [peaks_hg, locs_hg] = findpeaks(counts);
    locs_hg = locs_hg;
    centers_hg = h.BinEdges(1:end-1) + diff(h.BinEdges)/2;
    ind = find(peaks_hg < 2);
    peaks_hg(ind) = [];
    locs_hg(ind) = [];
    peak_y = peaks_hg+12;
    peak_y = peak_y(3:end-1);
    peak_hg = centers_hg(locs_hg);
    peak_hg = peak_hg(3:end-1);
    scatter(peak_hg, peak_y, 'rv', 'filled');
    hold off;
    
    channel_num = num2str((i-1)*2+1);
    %channel_num = '2';
    t = strcat("500 mV to 3V sweep histogram for Channel", {' '}, ...
        channel_num);
    title(t, 'FontSize', 22);
    set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
        'TickLength', [0.015 0.015]);
    ylabel('Number of samples', 'FontWeight', 'Bold', "Interpreter", ...
        "latex", 'FontSize', 20);
    ymax = max(h.BinCounts)*1.2;
    
    ylim([0 ymax]);
    edges = h.BinEdges;
    xloc = edges(1:end-1) + diff(edges)/2;
    bin_counts = h.BinCounts;
    bin_counts(bin_counts==0) = -1;
    labels = string(bin_counts);
    labels = strrep(labels, '-1', '');
    %text(xloc, bin_counts+1, labels, 'HorizontalAlignment', ...
     %   'center', 'VerticalAlignment', 'bottom', 'FontSize', 14);
    str = strcat("Counts:", {' '}, num2str(length(hist_data)));
    dim = [.7 .6 .3 .3];
    annotation('textbox',dim,'String',str,'FitBoxToText','on', ...
        'FontSize', 14);
    %xlim([0 2^14-1]);
    ax = gca;
    ax.XRuler.Exponent = 0;
    
    subplot(2,1,2);
    hist_data = tvc_data(:, 2*i);
    ind = find(~hit_data(:, 2*i));
    hist_data(ind) = [];
    %hist_data = hist_data(hist_data < 6000);
    h = histogram(hist_data, 2000);
    
    hold on;
    counts = h.BinCounts;
    counts = [1 counts];
    [peaks_lg, locs_lg] = findpeaks(counts, 1, 'MinPeakProminence', 15);
    locs_lg = locs_lg;
    centers_lg = h.BinEdges(1:end-1) + diff(h.BinEdges)/2;
    ind = find(peaks_lg < 2);
    peaks_lg(ind) = [];
    locs_lg(ind) = [];
    peak_y = peaks_lg+12;
    peak_y = peak_y(2:end);
    peak_lg = centers_lg(locs_lg);
    peak_lg = peak_lg(2:end);
    scatter(peak_lg, peak_y, 'rv', 'filled');
    
    hold off;
    
    t = strcat("Low Gain histogram for Channel", {' '}, ...
        channel_num);
    title(t, 'FontSize', 22);
    set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
        'TickLength', [0.015 0.015]);
    xlabel('ADC reading', 'FontWeight', 'Bold', "Interpreter", ...
        "latex", 'FontSize', 20);
    ylabel('Number of samples', 'FontWeight', 'Bold', "Interpreter", ...
        "latex", 'FontSize', 20);
    str = strcat("Counts:", {' '}, num2str(length(hist_data)));
    dim = [.6 .1 .3 .3];
    annotation('textbox',dim,'String',str,'FitBoxToText','on', ...
        'FontSize', 14);
    ymax = max(h.BinCounts)*1.2;
    ylim([0 ymax]);
    edges = h.BinEdges;
    xloc = edges(1:end-1) + diff(edges)/2;
    bin_counts = h.BinCounts;
    bin_counts(bin_counts==0) = -1;
    labels = string(bin_counts);
    labels = strrep(labels, '-1', '');
    %text(xloc, bin_counts+1, labels, 'HorizontalAlignment', ...
     %   'center', 'VerticalAlignment', 'bottom', 'FontSize', 14);
    ax = gca;
    ax.XRuler.Exponent = 0;
    set(gcf, "units", "normalized", "outerposition", [0 0 1 1]);
    
    fig_name = strcat("./hist_no_cutoff/channel", channel_num, ...
        "_histogram.pdf");
    %saveas(gcf, fig_name); 
    
    figure; box on; hold on;
    subplot(2,1,1);
    
    if length(peak_hg) > 11
       peak_hg = peak_hg(1:11); 
    end
    
    mdl1_x = sweep_increment(2:6);
    mdl1_y = peak_hg(2:6);
    %mdl1 = fitlm(mdl1_x, mdl1_y, 'linear');
    mdl1 = polyfit(mdl1_x, mdl1_y, 1);
    y = polyval(mdl1, sweep_increment);
    x = sweep_increment;
    x2 = x(1:length(peak_hg));
    plot(x, y, 'x-', x2, peak_hg, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
    ax = gca;
    ax.YRuler.Exponent = 0;
    
    t = "Linearity from 12.5 mV to 1.5V (negative) HG";
    t = strcat(t, {' '}, "Channel", {' '}, channel_num);
    title(t, 'FontSize', 18, 'FontWeight', 'Bold');
    set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
        'TickLength', [0.015 0.015]);
    ylabel('ADC Reading', 'FontWeight', 'Bold', 'FontSize', 18);
    xlabel('Pulse Amplitude (V)', 'FontWeight', 'Bold', 'FontSize', 18);
    legend('Fit Line', 'Real Samples', 'FontSize', 20, ...
    'Location', 'best');
    xlim([0 sweep_end+0.1]);
    
    subplot(2,1,2);
    x = sweep_increment;
    for k = length(peak_hg):length(y)-1
       peak_hg = [peak_hg 0]; 
    end
    y = abs(peak_hg-y)./y.*100;
    semilogy(x, y, 'rx-', 'MarkerSize', 10, 'LineWidth', 2);
    
    set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
        'TickLength', [0.015 0.015]);
    ylabel('Residual (%)', 'FontWeight', 'Bold', 'FontSize', 18);
    xlabel('Pulse Amplitude (V)', 'FontWeight', 'Bold', 'FontSize', 18);
    xlim([0 sweep_end+0.1]);
    
    
    figure; box on; hold on;
    
    if length(peak_lg) > 11
       peak_lg = peak_lg(1:11); 
    end
    
    subplot(2,1,1);
    mdl2_x = sweep_increment(2:6);
    mdl2_y = peak_lg(2:6);
    %mdl1 = fitlm(mdl1_x, mdl1_y, 'linear');
    mdl2 = polyfit(mdl2_x, mdl2_y, 1);
    y = polyval(mdl2, sweep_increment);
    x = sweep_increment;
    x2 = x(1:length(peak_lg));
    plot(x, y, 'x-', x2, peak_lg, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
    ax = gca;
    ax.YRuler.Exponent = 0;
    set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on');
    %ylim([0 6000]);
    
    t = "Linearity from 4 mV to 3 V (negative) LG";
    t = strcat(t, {' '}, "Channel", {' '}, channel_num);
    title(t, 'FontSize', 18, 'FontWeight', 'Bold');
    set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
        'TickLength', [0.015 0.015]);
    ylabel('Residual', 'FontWeight', 'Bold', 'FontSize', 18);
    xlabel('Pulse Amplitude (V)', 'FontWeight', 'Bold', 'FontSize', 18);
    xlim([0 sweep_end+0.1]);
    
    
    subplot(2,1,2);
    x = sweep_increment;
    for k = length(peak_lg):length(y)-1
       peak_lg = [peak_lg 0]; 
    end
    y = abs(peak_lg-y)./y.*100;
    semilogy(x, y, 'rx-', 'MarkerSize', 10, 'LineWidth', 2);
    set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on');
    %ylim([0 350]);
    
    set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
        'TickLength', [0.015 0.015]);
    ylabel('Residual (%)', 'FontWeight', 'Bold', 'FontSize', 18);
    xlabel('Pulse Amplitude (V)', 'FontWeight', 'Bold', 'FontSize', 18);
    xlim([0 sweep_end+0.1]);
    
    gain = zeros(1,6);
    diff_hg = zeros(1,6);
    diff_lg = zeros(1,6);
    for n = 1:6
       gain(n) =  (peak_hg(n+1)-peak_hg(n))./(peak_lg(n+1)-peak_lg(n));
       diff_hg(n) = peak_hg(n+1)-peak_hg(n);
       diff_lg(n) = peak_lg(n+1)-peak_lg(n);
    end
end