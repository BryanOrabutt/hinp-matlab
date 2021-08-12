file_root = 'C:\Users\frien\Documents\research\matlab\hinp\py\output\';
pos_data_file = [file_root 'chan5_100mv_neg_hg_parsed.csv'];
neg_data_file = [file_root 'chan5_si_input_hg_parsed.csv'];

pos_data = csvread(pos_data_file);
neg_data = csvread(neg_data_file);

pos_data(1,:) = [];
neg_data(1,:) = [];

adc_channels = 2^14-1;
vcount = 3.3/adc_channels;

figure; box on;
%subplot(2,1,1); 
pos_data = pos_data(:,6);
pos_data = pos_data(pos_data < 2660);
%pos_data = pos_data.*vcount.*100e3/.75;
edges = 2500:1:2650;
%xaxis = edges.*vcount.*100e3/.75;
%h = histogram(pos_data, xaxis);
%h = histfit(pos_data);
h = histogram(pos_data, edges);
channel_num = num2str(5);
   
mc = h.BinCounts;
max_counts = max(h.BinCounts);
mc(mc == max_counts) = 0;
max_counts = max(mc);
leftbin = find(h.BinCounts > max_counts/2, 1, 'first');
rightbin = find(h.BinCounts > max_counts/2, 1, 'last');
fwhm_hg = rightbin-leftbin;
fwhm_hg = fwhm_hg*h.BinWidth;

str = strcat("FWHM:", {' '}, num2str(fwhm_hg), {' '}, 'adc channels');
dim = [.28 .55 .3 .3];
annotation('textbox',dim,'String',str,'FitBoxToText','on', ...
    'FontSize', 24);

t = strcat("HG SI input 5.7 MeV histogram for Channel", {' '}, ...
    channel_num);
title(t, 'FontSize', 22);
set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 24, ...
    'TickLength', [0.015 0.015]);
ylabel('Counts', 'FontWeight', 'Bold', 'FontSize', 24);
xlabel('ADC Channel', 'FontWeight', 'Bold', 'FontSize', 24);
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
% 
% subplot(2,1,2);
% neg_data = neg_data(:,4);
% %edges = 890:1:960;
% %xaxis = 2*edges.*vcount.*400e3/1.5;
% %neg_data = 2*neg_data.*vcount.*400e3/1.5;
% %h = histogram(neg_data, xaxis);
% h = histogram(neg_data(neg_data < 600));
% channel_num = num2str(5);
%    
% max_counts = max(h.BinCounts);
% leftbin = find(h.BinCounts > max_counts/2, 1, 'first');
% rightbin = find(h.BinCounts > max_counts/2, 1, 'last');
% fwhm_hg = rightbin-leftbin;
% fwhm_hg = fwhm_hg*h.BinWidth;
% 
% str = strcat("FWHM:", {' '}, num2str(fwhm_hg), {' '}, 'KeV');
% dim = [.5 .09 .3 .3];
% annotation('textbox',dim,'String',str,'FitBoxToText','on', ...
%     'FontSize', 14);
% 
% t = strcat("LG -30mV pulse histogram for Channel", {' '}, ...
%     channel_num);
% title(t, 'FontSize', 22);
% set(gca, "XMinorTick", "on", "YMinorTick", "on", 'FontSize', 14, ...
%     'TickLength', [0.015 0.015]);
% xlabel('Energy (KeV)', 'FontWeight', 'Bold', "Interpreter", ...
%     "latex", 'FontSize', 20);
% ylabel('Number of samples', 'FontWeight', 'Bold', "Interpreter", ...
%     "latex", 'FontSize', 20);
% ymax = max(h.BinCounts)*1.2;
% %ylim([0 ymax]);
% edges = h.BinEdges;
% xloc = edges(1:end-1) + diff(edges)/2;
% bin_counts = h.BinCounts;
% bin_counts(bin_counts==0) = -1;
% labels = string(bin_counts);
% labels = strrep(labels, '-1', '');
% text(xloc, bin_counts+1, labels, 'HorizontalAlignment', ...
%     'center', 'VerticalAlignment', 'bottom', 'FontSize', 14);
% set(gcf, "units", "normalized", "outerposition", [0 0 1 1]);
