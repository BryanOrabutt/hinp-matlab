file_root = './csv_parsed2/';
pos_data_file = [file_root 'odds_1k_samp_1us_tvc_hg_parsed.csv'];
neg_data_file = [file_root ''];
%chan4_data_file = [file_root 'chan4_pos_1k_samp_tvc_250ns_parsed.csv'];
%chan9_data_file = [file_root 'chan9_pos_1k_samp_tvc_250ns_tvc_parsed.csv'];
chan9_data_file = [file_root 'chan3_pos_450_samp_tvc_100ns_tvc_parsed.csv'];

pos_data = csvread(pos_data_file);
neg_data = csvread(neg_data_file);
%ch4_data = csvread(chan4_data_file);
ch9_data = csvread(chan9_data_file);

pos_data(1,:) = [];
neg_data(1,:) = [];
%ch4_data(1,:) = [];
ch9_data(1,:) = [];

%pos_data = pos_data(:,any(pos_data));
%neg_data = neg_data(:,any(neg_data));

%remove less than threshold
%ch4_filtered = ch4_data(:,5);
%ind = find(ch4_filtered > 1500);
%ch4_filtered(ind) = [];

ch9_filtered = ch9_data(:,4);
ind = find(ch9_filtered < 2000);
ch9_filtered(ind) = [];

figure; box on;
h = histogram(ch9_filtered, 50);
t = strcat("TVCn histogram for Channel 9");
title(t, 'FontSize', 22);
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
    'TickLength', [0.015 0.015]);
xlabel('ADC reading', 'FontWeight', 'Bold', "Interpreter", ...
    "latex", 'FontSize', 20);
ylabel('Number of samples', 'FontWeight', 'Bold', "Interpreter", ...
    "latex", 'FontSize', 20);
ymax = max(h.BinCounts)*1.2;
%ylim([0 ymax]);
edges = h.BinEdges;
xloc = edges(1:end-1) + diff(edges)/2;
bin_counts = h.BinCounts;
bin_counts(bin_counts==0) = -1;
labels = string(bin_counts);
labels = strrep(labels, '-1', '');
text(xloc, bin_counts+1, labels, 'HorizontalAlignment', ...
    'center', 'VerticalAlignment', 'bottom', 'FontSize', 14);
set(gcf, "units", "normalized", "outerposition", [0 0 1 1]);

for i=1:8
    figure; box on;subplot(2,1,1); 
    h = histogram(pos_data(:,2*i), 50);
    channel_num = num2str((i-1)*2 + 1);
    t = strcat("Positive 3V pulse histogram for Channel", {' '}, ...
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
    text(xloc, bin_counts+1, labels, 'HorizontalAlignment', ...
        'center', 'VerticalAlignment', 'bottom', 'FontSize', 14);
    
    subplot(2,1,2);
    h = histogram(neg_data(:,2*i), 50);
    t = strcat("Negative 3V pulse histogram for Channel", {' '}, ...
        channel_num);
    title(t, 'FontSize', 22);
    set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
        'TickLength', [0.015 0.015]);
    xlabel('ADC reading', 'FontWeight', 'Bold', "Interpreter", ...
        "latex", 'FontSize', 20);
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
    text(xloc, bin_counts+1, labels, 'HorizontalAlignment', ...
        'center', 'VerticalAlignment', 'bottom', 'FontSize', 14);
    set(gcf, "units", "normalized", "outerposition", [0 0 1 1]);
end
