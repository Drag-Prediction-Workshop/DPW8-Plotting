function [TurbulenceModel_final,BasicAlgorithm_final,final,grid_final,alpha_final,cut_final,eta_final] = dat_reader_CRM_d(file)
% DPW-8/AePW-4 sectional cut reader (Version 5 form)
% CUT definition (as requested):
%   cut_final(i) = 1 for the first unique Eta encountered (in file order),
%                  2 for the second unique Eta encountered, etc.
% So: all zones with Eta=0.5 -> cut 1, Eta=0.6 -> cut 2, ...

fid = fopen(file,'r');
assert(fid>0, 'Cannot open file: %s', file);
C = textscan(fid, '%s', 'delimiter','\n', 'whitespace','');
fclose(fid);
data = C{1};

% global strings (replicated per zone)
TurbulenceModel = local_getQuoted(local_getFirstMatchLine(data,'TurbulenceModel'));
BasicAlgorithm  = local_getQuoted(local_getFirstMatchLine(data,'BasicAlgorithm'));

% VARIABLES
varLineIdx = find(contains(data,'VARIABLES'), 1, 'first');
assert(~isempty(varLineIdx), 'No VARIABLES line found.');
VARline = data{varLineIdx};

q = strfind(VARline,'"');
assert(mod(numel(q),2)==0 && ~isempty(q), 'Could not parse VARIABLES quotes.');
VAR = cell(1,numel(q)/2);
for k = 1:2:numel(q)
    VAR{(k+1)/2} = VARline(q(k)+1:q(k+1)-1);
end
nVars = numel(VAR);

% final{i} columns must match your original: [X/C(or XoC), X, Y, Z, CP_AVG, CP_RMS]
idx_XoC   = find(strcmpi(VAR,'X/C') | strcmpi(VAR,'XoC') | strcmpi(VAR,'XOC'), 1);
idx_X     = find(strcmpi(VAR,'X'), 1);
idx_Y     = find(strcmpi(VAR,'Y'), 1);
idx_Z     = find(strcmpi(VAR,'Z'), 1);
idx_CPAVG = find(strcmpi(VAR,'CP_AVG'), 1);
idx_CPRMS = find(strcmpi(VAR,'CP_RMS'), 1);
if any([isempty(idx_XoC), isempty(idx_X), isempty(idx_Y), isempty(idx_Z), isempty(idx_CPAVG), isempty(idx_CPRMS)])
    error('Missing required VARIABLES. Need X/C(or XoC), X, Y, Z, CP_AVG, CP_RMS. Found: %s', strjoin(VAR,', '));
end
a = [idx_XoC, idx_X, idx_Y, idx_Z, idx_CPAVG, idx_CPRMS];

% zones / auxdata
ZONE      = find(contains(data,'ZONE '));
assert(~isempty(ZONE), 'No ZONE lines found.');
GridLevel = find(contains(data,'AUXDATA GridLevel'));
Alpha     = find(contains(data,'AUXDATA Alpha'));
Eta       = find(contains(data,'AUXDATA Eta'));

nZones = numel(ZONE);

% outputs
final = cell(nZones,1);
grid_final = cell(nZones,1);
alpha_final = nan(nZones,1);
eta_final   = nan(nZones,1);
cut_final   = nan(nZones,1);
TurbulenceModel_final = cell(nZones,1);
BasicAlgorithm_final  = cell(nZones,1);

% eta->cut mapping in order of first appearance
eta_keys = [];  % unique etas in encounter order
eta_tol  = 1e-10;

for i = 1:nZones
    % zone block
    iStart = ZONE(i)+1;
    if i < nZones, iEnd = ZONE(i+1)-1; else, iEnd = numel(data); end
    block = data(iStart:iEnd);

    % numeric table start
    firstNum = find(cellfun(@(s) ~isempty(regexp(strtrim(s),'^[\+\-]?\d','once')), block), 1, 'first');
    assert(~isempty(firstNum), 'Zone %d: could not find numeric table start.', i);

    % collect numeric table lines: must have >= nVars numeric fields
    numLines = {};
    started = false;
    for j = firstNum:numel(block)
        s = strtrim(block{j});
        if isempty(s), continue; end
        vals = sscanf(s,'%f');
        if numel(vals) >= nVars
            started = true;
            numLines{end+1,1} = s; %#ok<AGROW>
        else
            if started, break; end
        end
    end
    assert(~isempty(numLines), 'Zone %d: parsed zero numeric rows.', i);

    % parse numeric table
    big = sprintf('%s\n', numLines{:});
    fmt = repmat('%f',1,nVars);
    tmp = textscan(big, fmt, 'CollectOutput', true);
    M = tmp{1};
    final{i} = M(:,a);

    % auxdata (same indexing convention as your original)
    if i <= numel(GridLevel), grid_final{i}  = local_getQuoted(data{GridLevel(i)}); end
    if i <= numel(Alpha),     alpha_final(i) = str2double(local_getQuoted(data{Alpha(i)})); end
    if i <= numel(Eta)
        eta_final(i) = str2double(local_getQuoted(data{Eta(i)}));
    else
        error('Zone %d: missing AUXDATA Eta line.', i);
    end

    % --- CUT from Eta order
    e = eta_final(i);
    if isempty(eta_keys)
        eta_keys = e;
        cut_final(i) = 1;
    else
        j = find(abs(eta_keys - e) <= eta_tol, 1, 'first');
        if isempty(j)
            eta_keys(end+1) = e; %#ok<AGROW>
            cut_final(i) = numel(eta_keys);
        else
            cut_final(i) = j;
        end
    end

    % replicate global strings per zone
    TurbulenceModel_final{i} = TurbulenceModel;
    BasicAlgorithm_final{i}  = BasicAlgorithm;
end

end

% ---------------- helpers ----------------
function s = local_getQuoted(line)
if isempty(line), s = ''; return; end
k = strfind(line,'"');
if numel(k) >= 2
    s = line(k(1)+1:k(2)-1);
else
    eq = strfind(line,'=');
    if ~isempty(eq), s = strtrim(line(eq(1)+1:end));
    else, s = strtrim(line);
    end
end
end

function line = local_getFirstMatchLine(data, pat)
idx = find(contains(data, pat), 1, 'first');
if isempty(idx), line = ''; else, line = data{idx}; end
end