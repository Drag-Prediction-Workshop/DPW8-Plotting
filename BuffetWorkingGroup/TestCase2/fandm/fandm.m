clc; clear all; close all;

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
    fprintf('\n\ndata(%i)\n',ii);
    for jj = 1:length(fields)
        field = fields{jj};
        fprintf('   %-20s%s\n',field,datanow.auxdata.(field));
    end

    % Aux data in each zone
    fprintf('\n');
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
        fprintf('   alldata(%i)  -->  data(%i).zones(%i)\n',count,ii,jj)
        fields = fieldnames(datanow.zones(jj).auxdata);
        fprintf('      Zone title         %s\n',datanow.zones(jj).title);
        for kk = 1:length(fields)
            field = fields{kk};
            fprintf('      Zone %-14s%s\n',field,datanow.zones(jj).auxdata.(field));
        end
        fprintf('\n');
    end % Each zone
end % Each file

% Experimental data
raw = importdata('experiment/buffet-TC2_cdclcm_dpw8-handMods.dat');
tunnel.alpha = raw.data(:,7);
tunnel.cd = raw.data(:,8);
tunnel.cl = raw.data(:,9);
tunnel.cm = raw.data(:,10);
clc


%% Mine
a1 = []; a2 = []; a4 = []; a5 = [];
g1 = []; g2 = []; g3 = []; g4 = []; g5 = []; g6 = []; g999 = [];

rans = []; urans = []; hrles = []; wmles = 0;
sa = []; dynamic = []; lbm = []; sst = []; rsm = [];
helden = []; multiblock = []; voroni = []; cartesian = []; cadence = [];

for ii = 1:length(alldata)
    % Alpha or Grid Sweep?
    clear tmpdata

    turbtext   = lower(extractBefore(alldata(ii).fileauxdata.turbulencemodel, 3));
    schemetext = lower(extractBefore(alldata(ii).fileauxdata.basicalgorithm, 4));
    gridtext   = lower(extractBefore(alldata(ii).fileauxdata.gridid, 4));

    switch turbtext
        case 'dy'
            dynamic = [dynamic ii];
        case 'lb'
            lbm = [lbm ii];
        case 'rs'
            rsm = [rsm ii];
        case 'sa'
            sa = [sa ii];
        case 'ss'
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
        case 'hex'%ahedra.... Helden
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
                    a1 = [a1 ii];
                case 2.29
                    a2 = [a2 ii];
                case 4.84
                    a4 = [a4 ii];
                case 5.89
                    a5 = [a5 ii];
            end % Switch alpha

        case 'grid'
            gridlevel = parts{4};
            switch gridlevel
                case '1'
                    g1 = [g1 ii];
                case '2'
                    g21 = [g2 ii];
                case '3'
                    g3 = [g3 ii];
                case '4'
                    g4 = [g4 ii];
                case '5'
                    g5 = [g5 ii];
                case '6'
                    g6 = [g6 ii];
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
plot(1:5,1:5)

% Mach-Alpha

% Re-Alpha

% CM-CL


% Find all cases for aoa=5.89
% [inds] = find(a5 == 1 )



%{
tunnel.alpha = raw.data(:,7);
tunnel.cd = raw.data(:,8);
tunnel.cl = raw.data(:,9);
tunnel.cm = raw.data(:,10);

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
