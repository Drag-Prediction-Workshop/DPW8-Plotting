function[TurbulenceModel_final,BasicAlgorithm_final,final,grid_final,alpha_final,cut_final,eta_final] = dat_reader_CRM_a(file)

fid = fopen(file,'r');
data = textscan(fid, '%s','delimiter',sprintf('\n'));
data = data{1};
fclose all;

TurbulenceModel = strfind(data,'TurbulenceModel '); TurbulenceModel = find(not(cellfun('isempty', TurbulenceModel)));
TurbulenceModel = data{TurbulenceModel};
k = strfind(TurbulenceModel,'"');
TurbulenceModel = TurbulenceModel(k(1)+1:k(2)-1);

BasicAlgorithm = strfind(data,'BasicAlgorithm '); BasicAlgorithm = find(not(cellfun('isempty', BasicAlgorithm)));
BasicAlgorithm = data{BasicAlgorithm};
k = strfind(BasicAlgorithm,'"');
BasicAlgorithm = BasicAlgorithm(k(1)+1:k(2)-1);

ZONE = strfind(data,'ZONE '); ZONE = find(not(cellfun('isempty', ZONE)));
GridLevel = strfind(data,'GridLevel '); GridLevel = find(not(cellfun('isempty', GridLevel)));
Alpha = strfind(data,'Alpha '); Alpha = find(not(cellfun('isempty', Alpha)));
Eta = strfind(data,'Eta '); Eta = find(not(cellfun('isempty', Eta)));
Cut = strfind(data,'SECTION '); Cut = find(~cellfun('isempty',Cut) & ~contains(data,'EXAMPLE'));

VAR = strfind(data,'VARIABLES'); VAR = find(not(cellfun('isempty', VAR)));
VAR = data{VAR};
k = strfind(VAR,'"');
var = {};
for i = 1:2:length(k)
    var{(i+1)/2} = VAR(k(i)+1:k(i+1)-1);
end
VAR = var;
clear k i var

for i = 1:length(ZONE)

    if i == length(ZONE)
        final{i} = str2num(char(data(ZONE(i)+12:end)));
    else
        final{i} = str2num(char(data(ZONE(i)+12:ZONE(i+1)-1)));
    end

    if isempty(final{i})
        if i == length(ZONE)
            final{i} = str2num(char(data(ZONE(i)+17:end)));
        else
            final{i} = str2num(char(data(ZONE(i)+17:ZONE(i+1)-1)));
        end
    end

    grid = data{GridLevel(i)};
    k = strfind(grid,'"');
    grid = grid(k(1)+1:k(2)-1);
    grid_final{i} = grid;

    alpha = data{Alpha(i)};
    k = strfind(alpha,'"');
    alpha = alpha(k(1)+1:k(2)-1);
    alpha_final(i,1) = str2num(alpha);

    TurbulenceModel_final{i} = TurbulenceModel;
    BasicAlgorithm_final{i} = BasicAlgorithm;

    eta = data{Eta(i)};
    k = strfind(eta,'"');
    eta = eta(k(1)+1:k(2)-1);
    eta_final(i,1) = str2num(eta);

    cut = data{Cut(i)};
    k = strfind(cut,'"');
    k2 = strfind(cut,'SECTION');
    cut = cut(k2+7:k(2)-1);
    cut_final(i,1) = str2num(cut);

end

a = [find(contains(VAR,'X/C')), find( contains(VAR,"X") & ~contains(VAR,"X/C") ), find(contains(VAR,'Y')), find(contains(VAR,'Z')), find(contains(VAR,'CP_AVG')), find(contains(VAR,'CP_RMS'))];
for i = 1:length(final)
    final{i} = final{i}(:,a);
end
