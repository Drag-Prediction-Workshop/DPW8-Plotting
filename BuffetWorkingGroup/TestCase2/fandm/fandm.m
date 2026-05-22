clc; clear all; close all;

saveall = 0;

mother = pwd;
gitdir = '/Users/bwpomero/crm/hs/dpw-8/github/DPW8-Buffet/TestCase2';


%% Read data
files = {'002_Embraer/01_scaLESv202509/DPW8-AePW4_UnsteadyForceMoment_v5.dat' ...
   '005_LAVA/DPW8-AePW4_UnsteadyForceMoment_LAVA_CRMWBT_HRLES_SA_005.01.dat' ...
   '007_JAXA/10_FaSTAR_JAXA_HeldenMesh_SA-R-comp-QCR2000_dt0.001/DPW8-AePW4_UnsteadyForceMoment_v5_HeldenMesh_Grid-Level-1.dat'...
   '007_JAXA/11_FaSTAR_JAXA__HeldenMesh_SA-R-comp-QCR2000_dt0.010/DPW8-AePW4_UnsteadyForceMoment_v5_HeldenMesh.dat'...
   '007_JAXA/12_FaSTAR_JAXA__Pointwise_SA-R-comp-QCR2000_dt0.001/DPW8-AePW4_UnsteadyForceMoment_v5_Pointwise_Grid-Level-1.dat'...
   '007_JAXA/13_FaSTAR_JAXA__Pointwise_SA-R-comp-QCR2000_dt0.010/DPW8-AePW4_UnsteadyForceMoment_v5_Pointwise.dat'...
   '010_Boeing/010_DPW8-AePW4_UnsteadyForceMoment_v5.dat'...
   '013_Technion_DS/01_PowerFLOW_L1-4/DPW8-AePW4_UnsteadyForceMoment_v5.dat'...
   '013_Technion_DS/02_PowerFLOW_L4/DPW8-AePW4_UnsteadyForceMoment_v5.dat'...
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

inds = [5 6 16 26];
tunnel.reyinteresting = tunnel.rey(inds);
tunnel.machinteresting = tunnel.mach(inds);
tunnel.alphainteresting = tunnel.alpha(inds);
tunnel.clinteresting = tunnel.cl(inds);
tunnel.cdinteresting = tunnel.cd(inds);
tunnel.cminteresting = tunnel.cm(inds);

clc


%% Mine
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
   switch type
      case 'alpha'
         alpha = str2num(parts{3});
         switch alpha
            case 1.22
               a{1} = [a{1} ii];
            case 2.29
               a{2} = [a{2} ii];
            case 4.84
               a{4} = [a{4} ii];
            case 5.89
               a{5} = [a{5} ii];
         end % Switch alpha
         
      case 'grid'
         gridlevel = parts{4};
         switch gridlevel
            case '1'
               g{1} = [g{1} ii];
            case '2'
               g{2} = [g{2} ii];
            case '3'
               g{3} = [g{3} ii];
            case '4'
               g{4} = [g{4} ii];
            case '5'
               g{5} = [g{5} ii];
            case '6'
               g{6} = [g{6} ii];
            otherwise
               % Strand L10-L12
               g999 = [g999 ii];
         end % switch grid level
   end % Constant alpha or constant grid zone?
end


%% Make plots for experimental data set

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
hello
if saveall == 1
   exportgraphics(gcf,'pdf/cl-cd-exp.pdf','ContentType','vector')
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
end

%% Participant plots... oye!

% Find all cases for aoa=5.89
% [inds] = find(a{5} == 1 )

%% By turbulence model, alpha sweeps
% CL-Alpha

% Figure out where it's the turbulence model of interest and a constant
% grid (variable alpha) sweep
sanegsubset = [];
for ii = 1:6
   inds = intersect(g{ii}, saneg);
   sanegsubset = [sanegsubset inds];
end

sarcsubset = [];
for ii = 1:6
   inds = intersect(g{ii}, sarc);
   sarcsubset = [sarcsubset inds];
end

dynamicsubset = [];
for ii = 1:6
   inds = intersect(g{ii}, dynamic);
   dynamicsubset = [dynamicsubset inds];
end

lbmsubset = [];
for ii = 1:6
   inds = intersect(g{ii}, lbm);
   lbmsubset = [lbmsubset inds];
end

rsmsubset = [];
for ii = 1:6
   inds = intersect(g{ii}, rsm);
   rsmsubset = [rsmsubset inds];
end

sstsubset = [];
for ii = 1:6
   inds = intersect(g{ii}, sst);
   sstsubset = [sstsubset inds];
end


figure(101); hold on; grid minor % CL-Alpha
figure(102); hold on; grid minor % CL-CD
figure(103); hold on; grid minor % CL-CM



gridwin(2,1,[2 2])
hold on
xlabel('\alpha (deg)')
ylabel('C_L')
plot(tunnel.alpha,tunnel.cl,'k-o','markerfacecolor','k')
lentries = {};
plot(nan,nan,'r-o','markerfacecolor','r')
plot(nan,nan,'-o','color',[0 0.7 0],'markerfacecolor',[0 0.7 0])
plot(nan,nan,'b-o','markerfacecolor','b')
plot(nan,nan,'c-o','markerfacecolor','c')
plot(nan,nan,'m-o','markerfacecolor','m')
plot(nan,nan,'y-o','markerfacecolor','y')

lentries{1} = 'SA-neg';
for ii = 1:length(sanegsubset)
   plot(alldata(sanegsubset(ii)).alpha,alldata(sanegsubset(ii)).clavg,'r-o','markerfacecolor','r')
end

lentries{2} = 'SA-RC';
for ii = 1:length(sarcsubset)
   plot(alldata(sarcsubset(ii)).alpha,alldata(sarcsubset(ii)).clavg,'-o','color',[0 0.7 0],'markerfacecolor',[0 0.7 0])
end

lentries{3} = 'Dynamic Smagorinsky';
for ii = 1:length(dynamicsubset)
   plot(alldata(dynamicsubset(ii)).alpha,alldata(dynamicsubset(ii)).clavg,'b-o','markerfacecolor','b')
end

lentries{4} = 'Lattice Boltzman k-$e$';
for ii = 1:length(lbmsubset)
   plot(alldata(lbmsubset(ii)).alpha,alldata(lbmsubset(ii)).clavg,'c-o','markerfacecolor','c')
end

lentries{5} = 'SST';
for ii = 1:length(sstsubset)
   plot(alldata(sstsubset(ii)).alpha,alldata(sstsubset(ii)).clavg,'m-o','markerfacecolor','m')
end

lentries{6} = 'Reynolds Stress';
for ii = 1:length(rsmsubset)
   plot(alldata(rsmsubset(ii)).alpha,alldata(rsmsubset(ii)).clavg,'y-o','markerfacecolor','y')
end

hl = legend('Experiment',lentries{1},lentries{2},lentries{3},lentries{4},lentries{5},lentries{6},...
   'location','eastoutside');

hello
if saveall == 1
   exportgraphics(gcf,'pdf/cl-alpha-turb.pdf','ContentType','vector')
end



%{

alldata(xxx).
gridlevel
gridsize
gridfac
mach
rey
alpha
clavg
cdavg
cmavg
clrms
cdrms
cmrms
%}
