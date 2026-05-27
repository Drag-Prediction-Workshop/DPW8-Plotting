% STARTUP.M

%addpath '/home/l/lo215d/bin/MATLAB'
%addpath '/net/esahome/home5/lo215d/bin/MATLAB/matlab-esb-toolbox-master/esb-toolbox'
addpath '/Users/bwpomero/bin/matlab'
addpath '/Users/bwpomero/bin/matlab/thirdparty'
addpath '/Users/bwpomero/bin/matlab/thirdparty/export_fig'


% To list all properties:
%get(groot,'factory')

% Normal
set(0,'DefaultTextInterpreter','tex'); % Normal
set(0,'DefaultAxesFontSize',20);
set(0,'DefaultTextFontSize',20)
set(0,'DefaultTextHorizontalAlignment','center')

set(0,'DefaultFigurePosition', [1 86 639 430]);
set(0,'DefaultFigureWindowStyle','normal');
set(0,'DefaultFigurePaperPosition', [0 0 8 8]); % 'auto'
set(0,'DefaultFigureColor','white');

% Set axes properties.
set(0,'DefaultAxesFontName','Helvetica');
set(0,'DefaultAxesFontWeight','normal');	% light | {normal} | demi | bold
set(0,'DefaultAxesBox','on');
set(0,'DefaultAxesXGrid','on');
set(0,'DefaultAxesYGrid','on');
set(0,'DefaultAxesZGrid','on');
set(0,'DefaultAxesLineWidth',0.75);
set(0,'DefaultAxesGridLineStyle','-');
set(0,'DefaultAxesLayer','Bottom');
set(0,'DefaultAxesGridColor',[0 0 0])
set(0,'DefaultAxesMinorGridColor',[0 0 0])
set(0,'DefaultAxesGridAlpha',1)
set(0,'DefaultAxesMinorGridAlpha',0.5)
set(0,'DefaultAxesMinorGridColor',[0 0 0]);
set(0,'DefaultAxesXColor',[0 0 0])
set(0,'DefaultAxesYColor',[0 0 0])
set(0,'DefaultAxesZColor',[0 0 0])

% Set miscellaneous properties.
set(0,'DefaultLineLineWidth',2.5)
set(0,'DefaultPatchLineWidth',1)
set(0,'DefaultUicontrolFontSize',10);
set(0,'DefaultLineMarkerSize',6);

% Return default colormap to 'jet'... 2014b uses parula
colormap('jet');
cmap = colormap;
set(0,'DefaultFigureColormap',cmap);
close all

% Return default title fontweight from bold to normal
set(0,'DefaultAxesTitleFontWeight','normal')

% Line style order... need to make this as the default... I'm not sure it works...
set(0,'DefaultAxesColorOrder',[   1.000000000000000                   0                   0;
                   0   0.800000000000000                   0;
                   0                   0                   1;
                   0                   0                   0;
   1.000000000000000   0.827586206896552                   0;
   0.419607843137255   0.266666666666667   0.137254901960784;
   0.517241379310345   0.517241379310345   1.000000000000000;
   1.000000000000000   0.103448275862069   0.724137931034483;
                   0   1.000000000000000   0.758620689655172;
                   0   0.517241379310345   0.586206896551724;
                   0                   0   0.482758620689655;
   0.586206896551724   0.827586206896552   0.310344827586207;
   0.965517241379310   0.620689655172414   0.862068965517241;
   0.827586206896552   0.068965517241379   1.000000000000000;
   0.482758620689655   0.103448275862069   0.413793103448276;
   0.965517241379310   0.068965517241379   0.379310344827586;
   1.000000000000000   0.758620689655172   0.517241379310345;
   0.137931034482759   0.137931034482759   0.034482758620690;
   0.551724137931034   0.655172413793103   0.482758620689655;
   0.965517241379310   0.517241379310345   0.034482758620690;],...
   'DefaultAxesLineStyleOrder','-|--|-.|:');
   set(0,'DefaultLineMarkerFaceColor','auto');
set(0,'DefaultAxesNextPlot','add');

% Miscellaneous
warning on all;
warning on backtrace;
warning on verbose;
warning off MATLAB:MKDIR:DirectoryExists
warning off MATLAB:lang:cannotClearExecutingFunction
warning off MATLAB:dispatcher:nameConflict
%beep off;

% Set the display format.
format short
%format compact;
%format long g;
clear all


