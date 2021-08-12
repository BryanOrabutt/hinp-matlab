file_root = 'C:\Users\frien\Documents\research\matlab\hinp\py\output\';
t1_file = [file_root 'chan5_tvc_short_250ns_delay_tvc_parsed.csv'];
t2_file = [file_root 'chan5_tvc_short_350ns_delay_tvc_parsed.csv'];
t3_file = [file_root 'chan5_tvc_short_400ns_delay_tvc_parsed.csv'];

t1 = csvread(t1_file);
t2 = csvread(t2_file);
t3 = csvread(t3_file);

figure;
edges = 9630:1:9670;
h1 = histogram(t1, edges);
max_counts = max(h1.BinCounts);
leftbin = find(h1.BinCounts > max_counts/2, 1, 'first');
rightbin = find(h1.BinCounts > max_counts/2, 1, 'last');
fwhm_hg = rightbin-leftbin;
fwhm_hg = fwhm_hg*h1.BinWidth;
str = strcat("FWHM:", {' '}, num2str(fwhm_hg));
dim = [.3 .55 .3 .3];
annotation('textbox',dim,'String',str,'FitBoxToText','on', ...
    'FontSize', 14);

figure;
edges = 9200:1:9250;
h2 = histogram(t2, edges);
max_counts = max(h2.BinCounts);
leftbin = find(h2.BinCounts > max_counts/2, 1, 'first');
rightbin = find(h2.BinCounts > max_counts/2, 1, 'last');
fwhm_hg = rightbin-leftbin;
fwhm_hg = fwhm_hg*h2.BinWidth;
str = strcat("FWHM:", {' '}, num2str(fwhm_hg));
dim = [.3 .55 .3 .3];
annotation('textbox',dim,'String',str,'FitBoxToText','on', ...
    'FontSize', 14);

figure;
edges = 8720:1:8780;
h3 = histogram(t3, edges);
max_counts = max(h3.BinCounts);
leftbin = find(h3.BinCounts > max_counts/2, 1, 'first');
rightbin = find(h3.BinCounts > max_counts/2, 1, 'last');
fwhm_hg = rightbin-leftbin;
fwhm_hg = fwhm_hg*h3.BinWidth;
str = strcat("FWHM:", {' '}, num2str(fwhm_hg));
dim = [.3 .55 .3 .3];
annotation('textbox',dim,'String',str,'FitBoxToText','on', ...
    'FontSize', 14);

