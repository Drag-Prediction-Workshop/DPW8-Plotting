function [hl] = plotdata(alldata, datasets, style, variable1, variable2)
% PLOTDATA Plots specified variables from a structure array.
%
% Inputs:
%   alldata   - Structure array containing the data and styling
%   datasets  - Vector of indices in alldata to plot
%   style     - String specifying which style struct to use ('scheme', 'grid', 'turb')
%   variable1 - String specifying the X-axis variable (e.g., 'alpha')
%   variable2 - String specifying the Y-axis variable (e.g., 'clavg')

% Prepare the figure
figure;
grid minor
hold on
%set(gcf,'position',[1 86 765 430])
%set(gca,'position',[0.11 0.14 0.78 0.8])

set(gcf,'position',[1 86 780 430])
set(gca,'position',[0.11 0.14 0.75 0.8])

ax = gca;

% Customize the minor grid lines
set(gca,'GridLineWidth',1.5)
set(gca,'MinorGridLineStyle','--')
%set(gca,'MinorGridColor',[0.3 0.3 0.3])
%set(gca,'MinorGridAlpha',0.75)
set(gca,'MinorGridColor','k')
set(gca,'MinorGridLineWidth',1)


legendtext = {};

%% Set up the legend

%legendcounter = legendcounter + 1;
%legendtext{legendcounter} = alldata(idx).cleantitle;
%plot(nan, nan, lineShape, 'color', lineColor, ...
%   'linewidth', 1.5, 'markerfacecolor', lineColor,'markersize',8);

% Legend
legendcounter = 0;
for ii = 1:length(datasets)
   idx = datasets(ii);
   
   lineColor = alldata(idx).(style).color;
   lineShape = alldata(idx).(style).shape;
   
   if ii == 1
      legendcounter = legendcounter + 1;
      legendtext{legendcounter} = alldata(idx).cleantitle;
      plot(nan, nan, lineShape, 'color', lineColor, 'linewidth', 1.5, 'markerfacecolor', lineColor,'markersize',8);
   else
      % Figure out if it's been plotted or not
      [inds] = strcmp(alldata(idx).cleantitle,legendtext);
      checkall = sum(inds);
      if checkall == 0
         % New
         legendcounter = legendcounter + 1;
         legendtext{legendcounter} = alldata(idx).cleantitle;
         plot(nan, nan, lineShape, 'color', lineColor, 'linewidth', 1.5, 'markerfacecolor', lineColor,'markersize',8);
      end
   end

end


%% Make the plots
%legendcounter = 0;
for ii = 1:length(datasets)
   idx = datasets(ii);
   
   xData = alldata(idx).(variable1);
   yData = alldata(idx).(variable2);
   
   lineColor = alldata(idx).(style).color;
   lineShape = alldata(idx).(style).shape;
   
   plot(xData, yData, lineShape, 'color', lineColor, 'linewidth', 1.5, 'markerfacecolor', lineColor,'markersize',8);
  %legendcounter = legendcounter + 1;
  %legendtext{legendcounter} = alldata(idx).cleantitle;
end

hx = xlabel(variable1,'units','normalized','position',[0.5 -0.07 0]);
hy = ylabel(variable2,'units','normalized');

hl = legend(legendtext{:},'location','northeastoutside','fontsize',14);
set(gca,'fontsize',16)

%% Add the text
%anchorx = 0.7;
%if strcmp(style,'scheme') == 1
%   text(3,0.4,'Test')
%end
