%
% MATLAB routine to determine linearity of peak detector
% Accepts just one argument .. the root filename
%

% Get name of data file

arg_list = argv () ;
rootname = arg_list{1} ;

% m1 specifies starting point
% m2 specities ending point 

m1 = 8 ;
m2 = 17 ;

%
% Load in the data from file
%

fid = fopen([rootname  '.dat'], 'rt') ; 

% Ignore the first line .. it is just a comment
% x is the input voltage
% y is the peak voltage

data = dlmread([rootname '.dat'], '\t', 1, 0) ;
x = data(:,1) ;
x = x * 63.3313 ; %253.3252 for LG
y = data(:,2) ;
n = length(x) ;

xfit = x(m1:m2) ;
yfit = y(m1:m2) ;

%
% Asumme x-data lines on a line whose slope is c2 and intercept is c1
%
% Create y = c1 + c2 * x
% Y = c * X
%
m = length(xfit) ;
X = [ones(m, 1) xfit] ;

% Calculate coefficient vector (slope and intercept)
% 

c = (pinv(X'*X))*X'*yfit ;
intercept = c(1) ;
slope = c(2) ;

% Plot the fitted equation we got from the regression
% X should now be all of the data

X = [ones(n, 1) x] ;

h = figure('name','Peak Sampler Linearity Plot','numbertitle','off') ;

% Plot the original data

cc = subplot(2,1,1) ;
%set(cc, 'Position', [.13 .95 .78 .3]);
plot(x, y, 'r.','MarkerSize',15); 
grid on

%title('Linearity Plot','fontweight','bold','fontsize',14) ; %Set the Title
str = ["(a) Shaper Peak Voltage"];
text(40, 1.75, str, 'fontsize', 14, 'fontweight', 'bold');
set(gca, 'XTickLabel', []);
ylabel('Voltage (V)','fontweight','bold','fontsize',12);
set(gca, 'fontsize',14);
set(gca, 'position', [0.13000 0.5 0.77500 0.20180]);
%get(gca, 'position')

hold on ; 

% Plot the best fit line on the same plot!

plot(X(:,2), X*c, '-', "linewidth", 4) ; 

% Compute the residuals

res =  (X*c) - y ;

% Convert the residual voltage to an energy

res = res ./ slope ;

% Convert the residual energy to a percentage based on energy level

res = (res ./ x) ;

% Plot the residuals


bb = subplot(2,1,2) ;
%set(bb, 'Position', [.13 .4 .78 .3]);
plot(X(:,2), log(abs(res*100)), '-', "linewidth", 4) ;
ylim([-10 +10]) ;
grid on
set(gca, 'fontsize',14);

%title('Residual Plot','fontweight','bold','fontsize',14) ; %Set the Title
str = ["(b) Shaper Linearity"];
text(40, 8.5, str, 'fontsize', 14, 'fontweight', 'bold');
xlabel('Energy (MeV)','fontweight','bold','fontsize',14); % Set the x-axis label
ylabel('log(|Residual|) (%)','fontweight','bold','fontsize',14); % Set the y-axis label

hold on ; 

% Plot the residuals for low levels

%aa = subplot(3,1,3) ;
%set(aa, 'Position', [.13 -.15 .78 .3]);
%plot(X(:,2), res*100, '-', "linewidth", 4) ;
%xlim([0 2]) ;
%ylim([-10 +10]) ;
%grid on
%set(gca, 'fontsize',14);


%title('Residual Plot (Zoomed)','fontweight','bold','fontsize',14) ; %Set the Title
%xlabel('Energy (MeV)','fontweight','bold','fontsize',14); % Set the x-axis label
%ylabel('Residual (%)','fontweight','bold','fontsize',14); % Set the y-axis label


% Create a time_stamp

timestamp = strftime("_%Y-%m-%d_%H:%M", localtime( time() ) ) ;
warning("off")
print(h,'-dpdf','-color', [ './pdf/' rootname "_" timestamp '.pdf']) ;

hold off 
exit

