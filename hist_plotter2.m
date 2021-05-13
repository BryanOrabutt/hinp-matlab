file_root = './csv_nimbin_parsed/';
hg_data_file = [file_root 'evens_neg_12mv5_1V5_hg_parsed.csv'];
tvc_data_file = [file_root 'evens_neg_12mv5_1V5_lg_parsed.csv'];
hit_data_file = [file_root 'evens_neg_12mv5_1V5_hit_parsed.csv'];

hg_data = csvread(hg_data_file);
tvc_data = csvread(tvc_data_file);
hit_data = csvread(hit_data_file);

hg_data(1,:) = [];
tvc_data(1,:) = [];
hit_data(1,:) = [];

fig_folder = './figs_no_cutoff/';

sweep_start = .05;
sweep_end = .75;
sweep_steps = 11;
sweep_increment = linspace(sweep_start,sweep_end,sweep_steps);

adc_step = 3.3/2^14;
energy_scale_factor_lg = 400/3;
energy_scale_factor_hg = 100/3;

for i=8:8
    if(i == 5)
        continue
    end
    figure; box on;
    subplot(2,1,1); 
    hist_data = hg_data(:, 2*i-1);
    ind = find(~hit_data(:, 2*i-1));
    hist_data(ind) = [];
    %hist_data = hist_data(hist_data < 9690);
    %hist_data = hist_data(hist_data > 9500);
    h = histogram(hist_data, 1000);
    %[sweep_bc, sweep_edges] = histcounts(hist_data, 100);
    channel_num = num2str((i-1)*2+1);
    t = strcat("4mV to 3V sweep histogram for Channel", {' '}, ...
        channel_num, {' '}, "HG");
    title(t, 'FontSize', 18, 'FontWeight', 'Bold');
    set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
        'TickLength', [0.015 0.015]);
    ylabel('Number of samples', 'FontWeight', 'Bold', 'FontSize', 18);
    xlabel('ADC Counts', 'FontWeight', 'Bold', 'FontSize', 18);
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
    %xlim([12795 12850]);
    ax = gca;
    ax.XRuler.Exponent = 0;
    
%     xticks = get(gca, 'XTickLabel');
%     xticks_ary = str2double(xticks);
%     xticks = xticks_ary.*adc_step.*energy_scale_factor_hg;
%     set(gca, 'XTickLabel', round(xticks, 1));
    
    max_counts = max(h.BinCounts);
    leftbin = find(h.BinCounts > max_counts/2, 1, 'first');
    rightbin = find(h.BinCounts > max_counts/2, 1, 'last');
    fwhm_hg = rightbin-leftbin;
    fwhm_hg = fwhm_hg*h.BinWidth;
%     
%     str = strcat("FWHM:", {' '}, num2str(fwhm_hg));
%     dim = [.7 .55 .3 .3];
%     annotation('textbox',dim,'String',str,'FitBoxToText','on', ...
%         'FontSize', 14);
    
    subplot(2,1,2);
    hist_data = tvc_data(:, 2*i-1);
    ind = find(~hit_data(:, 2*i-1));
    hist_data(ind) = [];
    %hist_data = hist_data(hist_data < 600);
    %hist_data = hist_data(hist_data > 520);
    h = histogram(hist_data, 1000);
    t = strcat("5mV to 3V sweep histogram for Channel", {' '}, ...
        channel_num, {' '}, "LG");
    title(t, 'FontSize', 18, 'FontWeight', 'Bold');
    set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
        'TickLength', [0.015 0.015]);
    xlabel('ADC Counts', 'FontWeight', 'Bold', 'FontSize', 18);
    ylabel('Number of samples', 'FontWeight', 'Bold', 'FontSize', 18);
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
    
%     
%     xticks = get(gca, 'XTickLabel');
%     xticks_ary = str2double(xticks);
%     xticks = xticks_ary.*adc_step.*energy_scale_factor_lg;
%     set(gca, 'XTickLabel', round(xticks, 1));
    
    
    max_counts = max(h.BinCounts);
    leftbin = find(h.BinCounts > max_counts/2, 1, 'first');
    rightbin = find(h.BinCounts > max_counts/2, 1, 'last');
    fwhm_lg = rightbin-leftbin;
    fwhm_lg = fwhm_lg*h.BinWidth;
    
%     str = strcat("FWHM:", {' '}, num2str(fwhm_lg));
%     dim = [.6 .05 .3 .3];
%     annotation('textbox',dim,'String',str,'FitBoxToText','on', ...
%         'FontSize', 14);
    %saveas(gcf, fig_name); 
end
