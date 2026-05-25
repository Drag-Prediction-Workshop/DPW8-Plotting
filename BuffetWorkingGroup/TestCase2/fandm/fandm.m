clc; clear all; close all;

makeplots = 1; % Tunnel data
saveall = 1;

mother = pwd;
gitdir = '/Users/bwpomero/crm/hs/dpw-8/github/DPW8-Buffet/TestCase2';

tunnelcolor = 0.65;

%% Read data
files = {'002_Embraer/01_scaLESv202509/DPW8-AePW4_UnsteadyForceMoment_v5.dat' ...
   '005_LAVA/DPW8-AePW4_UnsteadyForceMoment_LAVA_CRMWBT_HRLES_SA_005.01.dat' ...
   '007_JAXA/10_FaSTAR_JAXA_HeldenMesh_SA-R-comp-QCR2000_dt0.001/DPW8-AePW4_UnsteadyForceMoment_v5_HeldenMesh_Grid-Level-1.dat'...
   '007_JAXA/11_FaSTAR_JAXA__HeldenMesh_SA-R-comp-QCR2000_dt0.010/DPW8-AePW4_UnsteadyForceMoment_v5_HeldenMesh.dat'...
   '007_JAXA/12_FaSTAR_JAXA__Pointwise_SA-R-comp-QCR2000_dt0.001/DPW8-AePW4_UnsteadyForceMoment_v5_Pointwise_Grid-Level-1.dat'...
   '007_JAXA/13_FaSTAR_JAXA__Pointwise_SA-R-comp-QCR2000_dt0.010/DPW8-AePW4_UnsteadyForceMoment_v5_Pointwise.dat'...
   '010_Boeing/010_DPW8-AePW4_UnsteadyForceMoment_v5.dat'...
   '013_Technion_DS/01_PowerFLOW_L1-4-gridV1/DPW8-AePW4_UnsteadyForceMoment_v5.dat'...
   '013_Technion_DS/02_PowerFLOW_L4-gridV2/DPW8-AePW4_UnsteadyForceMoment_v5.dat'...
   '021_CREATE_AV/02_URANS/021.02-DPW8-AePW4_UnsteadyForceMoment_v5.dat'...
   '021_CREATE_AV/03_IDDES/021.03-DPW8-AePW4_UnsteadyForceMoment_v5.dat'...
   '027_RMIT/05_RSM/DPW8-AePW4_UnsteadyForceMoment_v5.dat'};

count = 0;
for ii = 1:length(files)
   filename = [gitdir '/' files{ii}];
   data(ii) = readfandm(filename);
   datanow = data(ii);
   
   % Display aux data for my future mining
   fields = fieldnames(datanow.auxdata);
   %fprintf('\n\ndata(%i)\n',ii);
   for jj = 1:length(fields)
      field = fields{jj};
      %fprintf('   %-20s%s\n',field,datanow.auxdata.(field));
   end
   
   % Aux data in each zone
   %fprintf('\n');
   for jj = 1:length(datanow.zones)
      count = count + 1;
      
      % Store the unwrapped information
      alldata(count).fileindex   = ii;
      alldata(count).zoneindex   = jj;
      alldata(count).filename    = filename;
      
      % Store file aux data... store as is and then do cleaning/subbing
      alldata(count).fileauxdata = datanow.auxdata;
      
      % Store file aux data... store as is and then do cleaning/subbing
      alldata(count).title       = datanow.zones(jj).title;
      alldata(count).cleantitle  = datanow.zones(jj).title(1:6);
      alldata(count).zoneauxdata = datanow.zones(jj).auxdata;
      
      % Store actual data
      alldata(count).variables = datanow.variables;
      
      alldata(count).gridlevel = datanow.zones(jj).data(:,1);
      alldata(count).gridsize  = datanow.zones(jj).data(:,2);
      alldata(count).gridfac   = datanow.zones(jj).data(:,3);
      alldata(count).mach      = datanow.zones(jj).data(:,4);
      alldata(count).rey       = datanow.zones(jj).data(:,5);
      alldata(count).alpha     = datanow.zones(jj).data(:,6);
      alldata(count).clavg     = datanow.zones(jj).data(:,7);
      alldata(count).cdavg     = datanow.zones(jj).data(:,8);
      alldata(count).cmavg     = datanow.zones(jj).data(:,9);
      alldata(count).clrms     = datanow.zones(jj).data(:,10);
      alldata(count).cdrms     = datanow.zones(jj).data(:,11);
      alldata(count).cmrms     = datanow.zones(jj).data(:,12);
      
      % Display
      %fprintf('   alldata(%i)  -->  data(%i).zones(%i)\n',count,ii,jj)
      fields = fieldnames(datanow.zones(jj).auxdata);
      %fprintf('      Zone title         %s\n',datanow.zones(jj).title);
      for kk = 1:length(fields)
         field = fields{kk};
         %fprintf('      Zone %-14s%s\n',field,datanow.zones(jj).auxdata.(field));
      end
      %fprintf('\n');
   end % Each zone
end % Each file

% Experimental data
raw = importdata('experiment/buffet-TC2_cdclcm_dpw8-handMods.dat');

tunnel.reyfull = raw.data(:,3);
tunnel.machfull = raw.data(:,6);
tunnel.alphafull = raw.data(:,7);
tunnel.cdfull = raw.data(:,8);
tunnel.clfull = raw.data(:,9);
tunnel.cmfull = raw.data(:,10);

tunnel.rey = tunnel.reyfull(2:end-1);
tunnel.mach = tunnel.machfull(2:end-1);
tunnel.alpha = tunnel.alphafull(2:end-1);
tunnel.cl = tunnel.clfull(2:end-1);
tunnel.cd = tunnel.cdfull(2:end-1);
tunnel.cm = tunnel.cmfull(2:end-1);

tunnelinds = [4 5 15 25];
tunnel.reyinteresting = tunnel.rey(tunnelinds);
tunnel.machinteresting = tunnel.mach(tunnelinds);
tunnel.alphainteresting = tunnel.alpha(tunnelinds);
tunnel.clinteresting = tunnel.cl(tunnelinds);
tunnel.cdinteresting = tunnel.cd(tunnelinds);
tunnel.cminteresting = tunnel.cm(tunnelinds);

clc


%% Mine plot styles and store in the alldata structure array
raw = importdata('../README.linestyles');
count = 0;
for ii = 3:16
   count = count + 1;
   
   now = raw{ii,:};
   parts = strsplit(now);
   styles(count).id = parts{1};
   allids(count) = str2num(styles(count).id);
   styles(count).scheme.name = parts{3};
   styles(count).scheme.colorname = parts{4};
   
   switch lower(styles(count).scheme.colorname)
      case 'gold'
         styles(count).scheme.color = [228,190,0]/255;   % Gold
      case 'blue'
         styles(count).scheme.color = [0,0,255]/255;     % Blue
      case 'red'
         styles(count).scheme.color = [255,0,0]/255;     % Red
      case 'green'
         styles(count).scheme.color = [0,170,0]/255;     % Green
      case 'brown'
         styles(count).scheme.color = [141,91,47]/255;   % Brown
      case 'lavender'
         styles(count).scheme.color = [131,131,255]/255; % Lavender
      case 'fuschia'
         styles(count).scheme.color = [255,26,184]/255;  % Fuschia
      otherwise
         error('Problem')
   end
   
   styles(count).scheme.shapename = lower(parts{5});
   switch lower(styles(count).scheme.shapename)
      case 'circle'
         styles(count).scheme.shape = '-o';
      case 'x'
         styles(count).scheme.shape = '-x';
      case '+'
         styles(count).scheme.shape = '-+';
      case 'square'
         styles(count).scheme.shape = '-s';
      case 'diamond'
         styles(count).scheme.shape = '-d';
      case '<'
         styles(count).scheme.shape = '-<';
      otherwise
         error('Problem')
   end % Scheme shape name
   
   % Grid info
   styles(count).grid.name = parts{7};
   styles(count).grid.colorname = parts{8};
   switch lower(styles(count).grid.colorname)
      case 'gold'
         styles(count).grid.color = [228,190,0]/255;   % Gold
      case 'blue'
         styles(count).grid.color = [0,0,255]/255;     % Blue
      case 'red'
         styles(count).grid.color = [255,0,0]/255;     % Red
      case 'green'
         styles(count).grid.color = [0,170,0]/255;     % Green
      case 'brown'
         styles(count).grid.color = [141,91,47]/255;   % Brown
      case 'lavender'
         styles(count).grid.color = [131,131,255]/255; % Lavender
      case 'fuschia'
         styles(count).grid.color = [255,26,184]/255;  % Fuschia
      otherwise
         error('Problem')
   end
   
   styles(count).grid.shapename = lower(parts{9});
   switch lower(styles(count).grid.shapename)
      case 'circle'
         styles(count).grid.shape = '-o';
      case 'x'
         styles(count).grid.shape = '-x';
      case '+'
         styles(count).grid.shape = '-+';
      case 'square'
         styles(count).grid.shape = '-s';
      case 'diamond'
         styles(count).grid.shape = '-d';
      case '<'
         styles(count).grid.shape = '-<';
      otherwise
         error('Problem')
   end % Grid shape name
   
   % Turbulence model info
   styles(count).turb.name = parts{11};
   styles(count).turb.colorname = parts{12};
   switch lower(styles(count).turb.colorname)
      case 'gold'
         styles(count).turb.color = [228,190,0]/255;   % Gold
      case 'blue'
         styles(count).turb.color = [0,0,255]/255;     % Blue
      case 'red'
         styles(count).turb.color = [255,0,0]/255;     % Red
      case 'green'
         styles(count).turb.color = [0,170,0]/255;     % Green
      case 'brown'
         styles(count).turb.color = [141,91,47]/255;   % Brown
      case 'lavender'
         styles(count).turb.color = [131,131,255]/255; % Lavender
      case 'fuschia'
         styles(count).turb.color = [255,26,184]/255;  % Fuschia
      otherwise
         error('Problem')
   end
   
   styles(count).turb.shapename = lower(parts{13});
   switch lower(styles(count).turb.shapename)
      case 'circle'
         styles(count).turb.shape = '-o';
      case 'x'
         styles(count).turb.shape = '-x';
      case '+'
         styles(count).turb.shape = '-+';
      case 'square'
         styles(count).turb.shape = '-s';
      case 'diamond'
         styles(count).turb.shape = '-d';
      case '<'
         styles(count).turb.shape = '-<';
      otherwise
         error('Problem')
   end % Turbulence model shape name
end % Each line in the data file


%% Mine the data files for key information
a{1} = []; a{2} = []; a{4} = []; a{5} = [];
g{1} = []; g{2} = []; g{3} = []; g{4} = []; g{5} = []; g{6} = []; g999 = [];

rans = []; urans = []; hrles = []; wmles = 0;
saneg = []; sarc = []; dynamic = []; lbm = []; sst = []; rsm = [];
helden = []; multiblock = []; voroni = []; cartesian = []; cadence = [];

for ii = 1:length(alldata)
   % Alpha or Grid Sweep?
   clear tmpdata
   
   turbtext   = lower(extractBefore(alldata(ii).fileauxdata.turbulencemodel, 4));
   schemetext = lower(extractBefore(alldata(ii).fileauxdata.basicalgorithm, 4));
   gridtext   = lower(extractBefore(alldata(ii).fileauxdata.gridid, 4));
   
   switch turbtext
      case 'dyn'
         dynamic = [dynamic ii];
      case 'lbm'
         lbm = [lbm ii];
      case 'rsm'
         rsm = [rsm ii];
      case 'san'
         saneg = [saneg ii];
      case 'sa-'
         sarc = [sarc ii];
      case 'sst'
         sst = [sst ii];
   end
   
   switch schemetext
      case 'idd'%es
         hrles = [hrles ii];
      case 'lat'%tice boltzmann method (lbm)
         lbm = [lbm ii];
      case 'lav'%a-hrles model
         hrles = [hrles ii];
      case 'ura'%ns
         urans = [urans ii];
      case 'wml'%es
         wmles = [wmles ii];
   end
   
   switch gridtext
      case 'hel'%den
         helden = [helden ii];
      case 'mul'%tiblock
         multiblock = [multiblock ii];
      case 'vor'%oni
         voroni = [voroni ii];
      case 'car'%tesian
         cartesian = [cartesian ii];
      case 'cad'%ence
         cadence = [cadence ii];
   end
   
   
   % What kind of zone is it? Constant alpha or constant grid?
   parts = strsplit(alldata(ii).title,' ');
   type = lower(parts{2});
   %fprintf('%2i  %s\n',ii,parts{2})
   switch type
      case 'alpha'
         alpha = str2num(parts{3});
         switch alpha
            case 1.22
               a{1} = [a{1} ii];
               alldata(ii).sweep.type = 'ConstantAlpha';
               alldata(ii).sweep.metric = 1.22;
               alldata(ii).constantalpha.color = [228,190,0]/255;
               alldata(ii).constantalpha.shape = '-o';
            case 2.29
               a{2} = [a{2} ii];
               alldata(ii).sweep.type = 'ConstantAlpha';
               alldata(ii).sweep.metric = 2.29;
               alldata(ii).constantalpha.color = [0,0,255]/255;
               alldata(ii).constantalpha.shape = '-x';
            case 4.84
               a{4} = [a{4} ii];
               alldata(ii).sweep.type = 'ConstantAlpha';
               alldata(ii).sweep.metric = 4.84;
               alldata(ii).constantalpha.color = [255,0,0]/255;
               alldata(ii).constantalpha.shape = '-+';
            case 5.89
               a{5} = [a{5} ii];
               alldata(ii).sweep.type = 'ConstantAlpha';
               alldata(ii).sweep.metric = 5.89;
               alldata(ii).constantalpha.color = [0,170,0]/255;
               alldata(ii).constantalpha.shape = '-s';
         end % Switch alpha

      case 'grid'
         gridlevel = parts{4};
         switch gridlevel
            case '1'
               g{1} = [g{1} ii];
               alldata(ii).sweep.type = 'ConstantGrid';
               alldata(ii).sweep.metric = 1;
               alldata(ii).constantgrid.color = [228,190,0]/255;
               alldata(ii).constantgrid.shape = '-o';
            case '2'
               g{2} = [g{2} ii];
               alldata(ii).sweep.type = 'ConstantGrid';
               alldata(ii).sweep.metric = 2;
               alldata(ii).constantgrid.color = [0,0,255]/255;
               alldata(ii).constantgrid.shape = '-x';
            case '3'
               g{3} = [g{3} ii];
               alldata(ii).sweep.type = 'ConstantGrid';
               alldata(ii).sweep.metric = 3;
               alldata(ii).constantgrid.color = [255,0,0]/255;
               alldata(ii).constantgrid.shape = '-+';
            case '4'
               g{4} = [g{4} ii];
               alldata(ii).sweep.type = 'ConstantGrid';
               alldata(ii).sweep.metric = 4;
               alldata(ii).constantgrid.color = [0,170,0]/255;
               alldata(ii).constantgrid.shape = '-s';
            case '5'
               g{5} = [g{5} ii];
               alldata(ii).sweep.type = 'ConstantGrid';
               alldata(ii).sweep.metric = 5;
               alldata(ii).constantgrid.color = [141,91,47]/255;
               alldata(ii).constantgrid.shape = '-d';
            case '6'
               g{6} = [g{6} ii];
               alldata(ii).sweep.type = 'ConstantGrid';
               alldata(ii).sweep.metric = 6;
               alldata(ii).constantgrid.color = [131,131,255]/255;
               alldata(ii).constantgrid.shape = '-<';
            otherwise
               % Strand L10-L12
               g999 = [g999 ii];
               alldata(ii).sweep.type = 'ConstantGrid';
               alldata(ii).sweep.metric = 999;
               alldata(ii).constantgrid.color = [255,26,184]/255;
               alldata(ii).constantgrid.shape = '-^';
         end % switch grid level
   end % Constant alpha or constant grid zone?
   
   % Store the plot style information
   for jj = 1:length(styles)
      if styles(jj).id == alldata(ii).cleantitle
         alldata(ii).scheme.color = styles(jj).scheme.color;
         alldata(ii).scheme.shape = styles(jj).scheme.shape;
         alldata(ii).grid.color   = styles(jj).grid.color;
         alldata(ii).grid.shape   = styles(jj).grid.shape;
         alldata(ii).turb.color   = styles(jj).turb.color;
         alldata(ii).turb.shape   = styles(jj).turb.shape;
      end
   end
end % Each component in alldata


%% Make plots for experimental data set

if makeplots == 1
   % CL-Alpha
   figure
   hold on
   grid minor
   plot(tunnel.alpha,tunnel.cl,'k-o','markerfacecolor','k')
   plot(tunnel.alphainteresting,tunnel.clinteresting,'ro','markerfacecolor','r');
   xlabel('\alpha (deg)')
   ylabel('C_L')
   if saveall == 1
      exportgraphics(gcf,'pdf/cl-alpha-exp.pdf','ContentType','vector')
      exportgraphics(gcf,'png/cl-alpha-exp.png','Resolution',250)
   end
   
   % CL-CD
   figure
   hold on
   grid minor
   plot(tunnel.cd,tunnel.cl,'k-o','markerfacecolor','k')
   plot(tunnel.cdinteresting,tunnel.clinteresting,'ro','markerfacecolor','r');
   xlabel('\alpha (deg)')
   ylabel('C_D')
   set(gca,'xlim',[0.015 0.085])
   if saveall == 1
      exportgraphics(gcf,'pdf/cl-cd-exp.pdf','ContentType','vector')
      exportgraphics(gcf,'png/cl-cd-exp.png','Resolution',250)
   end
   
   % Mach-Alpha
   figure
   hold on
   grid minor
   plot(tunnel.alpha,tunnel.mach,'k-o','markerfacecolor','k')
   plot(tunnel.alphainteresting,tunnel.machinteresting,'ro','markerfacecolor','r');
   xlabel('\alpha (deg)')
   ylabel('Mach')
   set(gca,'ylim',[0.846 0.854])
   if saveall == 1
      exportgraphics(gcf,'pdf/mach-alpha-exp.pdf','ContentType','vector')
      exportgraphics(gcf,'png/mach-alpha-exp.png','Resolution',250)
   end
   
   % Re-Alpha
   figure
   hold on
   grid minor
   plot(tunnel.alpha,tunnel.rey,'k-o','markerfacecolor','k')
   plot(tunnel.alphainteresting,tunnel.reyinteresting,'ro','markerfacecolor','r');
   xlabel('\alpha (deg)')
   ylabel('Re (million)')
   set(gca,'ylim',[1.51 1.52])
   set(gca,'ytick',[1.51 1.515 1.52])
   if saveall == 1
      exportgraphics(gcf,'pdf/re-alpha-exp.pdf','ContentType','vector')
      exportgraphics(gcf,'png/re-alpha-exp.png','Resolution',250)
   end
   
   % CM-CL
   figure
   hold on
   grid minor
   plot(tunnel.cm,tunnel.cl,'k-o','markerfacecolor','k')
   plot(tunnel.cminteresting,tunnel.clinteresting,'ro','markerfacecolor','r');
   xlabel('C_M')
   ylabel('C_L')
   set(gca,'xdir','reverse')
   set(gca,'xlim',[-0.05 0.25])
   if saveall == 1
      exportgraphics(gcf,'pdf/cl-cm-exp.pdf','ContentType','vector')
      exportgraphics(gcf,'png/cl-cm-exp.png','Resolution',250)
   end
   
   % CM-alpha
   figure
   hold on
   grid minor
   plot(tunnel.cm,tunnel.alpha,'k-o','markerfacecolor','k')
   plot(tunnel.cminteresting,tunnel.alphainteresting,'ro','markerfacecolor','r');
   xlabel('C_M')
   ylabel('\alpha (deg)')
   set(gca,'xdir','reverse')
   set(gca,'xlim',[-0.05 0.25])
   if saveall == 1
      exportgraphics(gcf,'pdf/alpha-cm-exp.pdf','ContentType','vector')
      exportgraphics(gcf,'png/alpha-cm-exp.png','Resolution',250)
   end
end %if makeplots == 1

%% By scheme... alpha sweeps at lines of constant grids

% Get constant-grid zones
datasets = sort([g{1} g{2} g{3} g{4} g{5} g{6} g999]); % Zone number

% CL-alpha
hl = plotdata(alldata, datasets, 'scheme', 'alpha', 'clavg');
hp1 = plot(tunnel.alphainteresting,tunnel.clinteresting,'-ks','markerfacecolor','k','markersize',12); hp1.DisplayName = 'Tunnel'; uistack(hp1, 'bottom');
hp2 = plot(tunnel.alpha,tunnel.cl,'-s','color',[tunnelcolor tunnelcolor tunnelcolor],'markerfacecolor',[tunnelcolor tunnelcolor tunnelcolor],'markeredgecolor',[tunnelcolor tunnelcolor tunnelcolor],'handlevisibility','off'); uistack(hp2, 'bottom');
xlabel('\alpha (deg)')
ylabel('C_{L}')
axis([1 6 0.2 0.8])
anchorx = 1.02; anchory = -0.13;
dy = 0.06;
text(anchorx,anchory,'Brown: LBM',  'fontname','fixedwidth','fontweight','bold','color', [141,91,47]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Green: HRLES','fontname','fixedwidth','fontweight','bold','color', [0,170,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Red:   URANS','fontname','fixedwidth','fontweight','bold','color', [255,0,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Blue:  LES',  'fontname','fixedwidth','fontweight','bold','color', [0,0,255]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Gold:  WMLES','fontname','fixedwidth','fontweight','bold','color', [228,190,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
if saveall == 1
   exportgraphics(gcf,'pdf/cl-alpha-scheme.pdf','ContentType','vector')
   exportgraphics(gcf,'png/cl-alpha-scheme.png','Resolution',250)
end

% Polar
hl = plotdata(alldata, datasets, 'scheme', 'cdavg', 'clavg');
hp1 = plot(tunnel.cdinteresting,tunnel.clinteresting,'-ks','markerfacecolor','k','markersize',12); hp1.DisplayName = 'Tunnel'; uistack(hp1, 'bottom');
hp2 = plot(tunnel.cd,tunnel.cl,'-s','color',[tunnelcolor tunnelcolor tunnelcolor],'markerfacecolor',[tunnelcolor tunnelcolor tunnelcolor],'markeredgecolor',[tunnelcolor tunnelcolor tunnelcolor],'handlevisibility','off'); uistack(hp2, 'bottom');
xlabel('C_{D}')
ylabel('C_{L}')
axis([0.02 0.09 0.2 0.8])
anchorx = 1.05; anchory = -0.13;
dy = 0.06;
text(anchorx,anchory,'Brown: LBM',  'fontname','fixedwidth','fontweight','bold','color', [141,91,47]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Green: HRLES','fontname','fixedwidth','fontweight','bold','color', [0,170,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Red:   URANS','fontname','fixedwidth','fontweight','bold','color', [255,0,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Blue:  LES',  'fontname','fixedwidth','fontweight','bold','color', [0,0,255]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Gold:  WMLES','fontname','fixedwidth','fontweight','bold','color', [228,190,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
if saveall == 1
   exportgraphics(gcf,'pdf/cl-cd-scheme.pdf','ContentType','vector')
   exportgraphics(gcf,'png/cl-cd-scheme.png','Resolution',250)
end

% CM-CL
hl = plotdata(alldata, datasets, 'scheme', 'cmavg', 'clavg');
hp1 = plot(tunnel.cminteresting,tunnel.clinteresting,'-ks','markerfacecolor','k','markersize',12); hp1.DisplayName = 'Tunnel'; uistack(hp1, 'bottom');
hp2 = plot(tunnel.cm,tunnel.cl,'-s','color',[tunnelcolor tunnelcolor tunnelcolor],'markerfacecolor',[tunnelcolor tunnelcolor tunnelcolor],'markeredgecolor',[tunnelcolor tunnelcolor tunnelcolor],'handlevisibility','off'); uistack(hp2, 'bottom');
xlabel('C_{M}')
ylabel('C_{L}')
set(gca,'xdir','reverse')
axis([-0.1 0.1 0.2 0.8])
anchorx = 1.05; anchory = -0.13;
dy = 0.06;
text(anchorx,anchory,'Brown: LBM',  'fontname','fixedwidth','fontweight','bold','color', [141,91,47]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Green: HRLES','fontname','fixedwidth','fontweight','bold','color', [0,170,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Red:   URANS','fontname','fixedwidth','fontweight','bold','color', [255,0,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Blue:  LES',  'fontname','fixedwidth','fontweight','bold','color', [0,0,255]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Gold:  WMLES','fontname','fixedwidth','fontweight','bold','color', [228,190,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
if saveall == 1
   exportgraphics(gcf,'pdf/cl-cm-scheme.pdf','ContentType','vector')
   exportgraphics(gcf,'png/cl-cm-scheme.png','Resolution',250)
end




%% By grid type... alpha sweeps at lines of constant grids

% Get constant-grid zones
datasets = sort([g{1} g{2} g{3} g{4} g{5} g{6} g999]); % Zone number

% CL-alpha
hl = plotdata(alldata, datasets, 'grid', 'alpha', 'clavg');

hp1 = plot(tunnel.alphainteresting,tunnel.clinteresting,'-ks','markerfacecolor','k','markersize',12); hp1.DisplayName = 'Tunnel'; uistack(hp1, 'bottom');
hp2 = plot(tunnel.alpha,tunnel.cl,'-s','color',[tunnelcolor tunnelcolor tunnelcolor],'markerfacecolor',[tunnelcolor tunnelcolor tunnelcolor],'markeredgecolor',[tunnelcolor tunnelcolor tunnelcolor],'handlevisibility','off'); uistack(hp2, 'bottom');
xlabel('\alpha (deg)')
ylabel('C_{L}')
axis([1 6 0.2 0.8])
anchorx = 1.02; anchory = -0.13;
dy = 0.06;
text(anchorx,anchory,'Brown: Cart',      'fontname','fixedwidth','fontweight','bold',  'color', [141,91,47]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Green: Voroni',    'fontname','fixedwidth','fontweight','bold','color', [0,170,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Red:   Helden',    'fontname','fixedwidth','fontweight','bold','color', [255,0,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Blue:  Cadence',   'fontname','fixedwidth','fontweight','bold', 'color', [0,0,255]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Gold:  Hex',       'fontname','fixedwidth','fontweight','bold','color', [228,190,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
if saveall == 1
   exportgraphics(gcf,'pdf/cl-alpha-grid.pdf','ContentType','vector')
   exportgraphics(gcf,'png/cl-alpha-grid.png','Resolution',250)
end

% Polar
hl = plotdata(alldata, datasets, 'grid', 'cdavg', 'clavg');
hp1 = plot(tunnel.cdinteresting,tunnel.clinteresting,'-ks','markerfacecolor','k','markersize',12); hp1.DisplayName = 'Tunnel'; uistack(hp1, 'bottom');
hp2 = plot(tunnel.cd,tunnel.cl,'-s','color',[tunnelcolor tunnelcolor tunnelcolor],'markerfacecolor',[tunnelcolor tunnelcolor tunnelcolor],'markeredgecolor',[tunnelcolor tunnelcolor tunnelcolor],'handlevisibility','off'); uistack(hp2, 'bottom');
xlabel('C_{D}')
ylabel('C_{L}')
axis([0.02 0.09 0.2 0.8])
anchorx = 1.05; anchory = -0.13;
dy = 0.06;
text(anchorx,anchory,'Brown: Cart',      'fontname','fixedwidth','fontweight','bold',  'color', [141,91,47]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Green: Voroni',    'fontname','fixedwidth','fontweight','bold','color', [0,170,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Red:   Helden',    'fontname','fixedwidth','fontweight','bold','color', [255,0,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Blue:  Cadence',   'fontname','fixedwidth','fontweight','bold', 'color', [0,0,255]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Gold:  Hex',       'fontname','fixedwidth','fontweight','bold','color', [228,190,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
if saveall == 1
   exportgraphics(gcf,'pdf/cl-cd-grid.pdf','ContentType','vector')
   exportgraphics(gcf,'png/cl-cd-grid.pdf','Resolution',250)
end

% CM-CL
hl = plotdata(alldata, datasets, 'grid', 'cmavg', 'clavg');
hp1 = plot(tunnel.cminteresting,tunnel.clinteresting,'-ks','markerfacecolor','k','markersize',12); hp1.DisplayName = 'Tunnel'; uistack(hp1, 'bottom');
hp2 = plot(tunnel.cm,tunnel.cl,'-s','color',[tunnelcolor tunnelcolor tunnelcolor],'markerfacecolor',[tunnelcolor tunnelcolor tunnelcolor],'markeredgecolor',[tunnelcolor tunnelcolor tunnelcolor],'handlevisibility','off'); uistack(hp2, 'bottom');
xlabel('C_{M}')
ylabel('C_{L}')
set(gca,'xdir','reverse')
axis([-0.1 0.1 0.2 0.8])
anchorx = 1.05; anchory = -0.13;
dy = 0.06;
text(anchorx,anchory,'Brown: Cart', 'fontname','fixedwidth','fontweight','bold',  'color', [141,91,47]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Green: Voroni',    'fontname','fixedwidth','fontweight','bold','color', [0,170,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Red:   Helden',    'fontname','fixedwidth','fontweight','bold','color', [255,0,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Blue:  Cadence',   'fontname','fixedwidth','fontweight','bold', 'color', [0,0,255]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Gold:  Hex',       'fontname','fixedwidth','fontweight','bold','color', [228,190,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
if saveall == 1
   exportgraphics(gcf,'pdf/cl-cm-grid.pdf','ContentType','vector')
   exportgraphics(gcf,'png/cl-cm-grid.png','Resolution',250)
end


%% By grid level... alpha sweeps at lines of constant grids
% Get constant-grid zones
datasets = sort([g{1} g{2} g{3} g{4} g{5} g{6}]); % Zone number

% CL-alpha
hl = plotdata(alldata, datasets, 'constantgrid', 'alpha', 'clavg');
hp1 = plot(tunnel.alphainteresting,tunnel.clinteresting,'-ks','markerfacecolor','k','markersize',12); hp1.DisplayName = 'Tunnel'; uistack(hp1, 'bottom');
hp2 = plot(tunnel.alpha,tunnel.cl,'-s','color',[tunnelcolor tunnelcolor tunnelcolor],'markerfacecolor',[tunnelcolor tunnelcolor tunnelcolor],'markeredgecolor',[tunnelcolor tunnelcolor tunnelcolor],'handlevisibility','off'); uistack(hp2, 'bottom');
set(hl,'visible','off')
xlabel('\alpha (deg)')
ylabel('C_{L}')
axis([1 6 0.2 0.8])
anchorx = 1.02; anchory = -0.13;
dy = 0.06;
text(anchorx,anchory,'Green: L4', 'fontname','fixedwidth','fontweight','bold','color', [0,170,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Red:   L3', 'fontname','fixedwidth','fontweight','bold','color', [255,0,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Blue:  L2', 'fontname','fixedwidth','fontweight','bold','color', [0,0,255]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Gold:  L1', 'fontname','fixedwidth','fontweight','bold','color', [228,190,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
if saveall == 1
   exportgraphics(gcf,'pdf/cl-alpha-gridLevel.pdf','ContentType','vector')
   exportgraphics(gcf,'png/cl-alpha-gridLevel.png','Resolution',250)
end

% Polar
hl = plotdata(alldata, datasets, 'constantgrid', 'cdavg', 'clavg');
hp1 = plot(tunnel.cdinteresting,tunnel.clinteresting,'-ks','markerfacecolor','k','markersize',12); hp1.DisplayName = 'Tunnel'; uistack(hp1, 'bottom');
hp2 = plot(tunnel.cd,tunnel.cl,'-s','color',[tunnelcolor tunnelcolor tunnelcolor],'markerfacecolor',[tunnelcolor tunnelcolor tunnelcolor],'markeredgecolor',[tunnelcolor tunnelcolor tunnelcolor],'handlevisibility','off'); uistack(hp2, 'bottom');
set(hl,'visible','off')
xlabel('C_{D}')
ylabel('C_{L}')
axis([0.02 0.09 0.2 0.8])
anchorx = 1.05; anchory = -0.13;
dy = 0.06;
text(anchorx,anchory,'Green: L4', 'fontname','fixedwidth','fontweight','bold','color', [0,170,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Red:   L3', 'fontname','fixedwidth','fontweight','bold','color', [255,0,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Blue:  L2', 'fontname','fixedwidth','fontweight','bold','color', [0,0,255]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Gold:  L1', 'fontname','fixedwidth','fontweight','bold','color', [228,190,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
if saveall == 1
   exportgraphics(gcf,'pdf/cl-cd-gridLevel.pdf','ContentType','vector')
   exportgraphics(gcf,'png/cl-cd-gridLevel.png','Resolution',250)
end


% CM-CL
hl = plotdata(alldata, datasets, 'constantgrid', 'cmavg', 'clavg');
hp1 = plot(tunnel.cminteresting,tunnel.clinteresting,'-ks','markerfacecolor','k','markersize',12); hp1.DisplayName = 'Tunnel'; uistack(hp1, 'bottom');
hp2 = plot(tunnel.cm,tunnel.cl,'-s','color',[tunnelcolor tunnelcolor tunnelcolor],'markerfacecolor',[tunnelcolor tunnelcolor tunnelcolor],'markeredgecolor',[tunnelcolor tunnelcolor tunnelcolor],'handlevisibility','off'); uistack(hp2, 'bottom');
set(hl,'visible','off')
xlabel('C_{M}')
ylabel('C_{L}')
axis([-0.1 0.1 0.2 0.8])
set(gca,'xdir','reverse')
anchorx = 1.05; anchory = -0.13;
dy = 0.06;
text(anchorx,anchory,'Green: L4', 'fontname','fixedwidth','fontweight','bold','color', [0,170,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Red:   L3', 'fontname','fixedwidth','fontweight','bold','color', [255,0,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Blue:  L2', 'fontname','fixedwidth','fontweight','bold','color', [0,0,255]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
text(anchorx,anchory,'Gold:  L1', 'fontname','fixedwidth','fontweight','bold','color', [228,190,0]/255,'units','normalized','fontsize',14,'horizontalalignment','left'); anchory = anchory + dy;
if saveall == 1
   exportgraphics(gcf,'pdf/cl-cd-gridLevel.pdf','ContentType','vector')
   exportgraphics(gcf,'png/cl-cd-gridLevel.png','Resolution',250)
end



%%


%{
[228,190,0]/255    % Gold
[0,0,255]/255      % Blue
[255,0,0]/255      % Red
[0,170,0]/255      % Green
[141,91,47]/255    % Brown
[131,131,255]/255  % Lavender
[255,26,184]/255   % Fuschia
%}
