function [TurbulenceModel_final,BasicAlgorithm_final,final,grid_final,alpha_final,cut_final,eta_final] = dat_reader_CRM_f(file)
%DAT_READER_CRM_D_FLEX
% Flexible DPW-8/AePW-4 sectional-cut reader for "Version 5 form" files with
% inconsistent formatting across submitters.
%
% Handles all of these variations:
%   (A) Clean format with AUXDATA Eta/GridLevel/Alpha present
%   (B) VARIABLES line glued to prior text (e.g., "... 8VARIABLES = ...")
%   (C) Eta present only in ZONE title like "... ETA=0.1050"
%   (D) VARIABLES list contains X Y Z X/C CP_AVG CP_RMS CF_AVG CF_RMS but
%       numeric rows may contain:
%         - all variables (8 numbers), OR
%         - a subset (e.g., 7 numbers: missing one var), OR
%         - a different set (e.g., no Z column at all)
%
% Output contract (same as your original):
%   final{i} = [X/C (or XoC), X, Y, Z, CP_AVG, CP_RMS]  (Nx6)
%   grid_final{i} : string grid level (if available)
%   alpha_final(i), eta_final(i), cut_final(i): numeric
%
% Missing requested columns are filled with NaN.

fid = fopen(file,'r');
assert(fid>0, 'Cannot open file: %s', file);
C = textscan(fid, '%s', 'delimiter','\n', 'whitespace','');
fclose(fid);
data = C{1};

% global strings (replicated per zone)
TurbulenceModel = local_getQuoted(local_getFirstMatchLine(data,'TurbulenceModel'));
BasicAlgorithm  = local_getQuoted(local_getFirstMatchLine(data,'BasicAlgorithm'));

% VARIABLES (robust quote-based parsing)
[varNames, nVars] = local_parseVariables(data);
assert(nVars>0, 'Could not parse VARIABLES.');

% indices (may be missing!)
idx_XoC   = local_findVar(varNames, {'X/C','XoC','XOC'});
idx_X     = local_findVar(varNames, {'X'});
idx_Y     = local_findVar(varNames, {'Y'});
idx_Z     = local_findVar(varNames, {'Z'});
idx_CPAVG = local_findVar(varNames, {'CP_AVG'});
idx_CPRMS = local_findVar(varNames, {'CP_RMS'});

% zones
ZONE = find(contains(data,'ZONE'));
assert(~isempty(ZONE),'No ZONE lines found.');
nZones = numel(ZONE);

% AUXDATA indices (optional)
GridLevel = find(contains(data,'AUXDATA GridLevel'));
Alpha     = find(contains(data,'AUXDATA Alpha'));
EtaLine   = find(contains(data,'AUXDATA Eta'));

% outputs
final = cell(nZones,1);
grid_final = cell(nZones,1);
alpha_final = nan(nZones,1);
eta_final   = nan(nZones,1);
cut_final   = nan(nZones,1);
TurbulenceModel_final = cell(nZones,1);
BasicAlgorithm_final  = cell(nZones,1);

% eta->cut mapping in order of first appearance
eta_keys = [];
eta_tol  = 1e-10;

for i = 1:nZones
    zoneLine = data{ZONE(i)};

    % block bounds
    iStart = ZONE(i)+1;
    if i < nZones, iEnd = ZONE(i+1)-1; else, iEnd = numel(data); end
    block = data(iStart:iEnd);

    % --- metadata with fallbacks
    if i <= numel(GridLevel)
        grid_final{i} = local_getQuoted(data{GridLevel(i)});
    else
        grid_final{i} = local_parseGridFromZone(zoneLine);
    end

    if i <= numel(Alpha)
        alpha_final(i) = str2double(local_getQuoted(data{Alpha(i)}));
    else
        alpha_final(i) = local_parseAlphaFromZone(zoneLine);
    end

    if i <= numel(EtaLine)
        eta_final(i) = str2double(local_getQuoted(data{EtaLine(i)}));
    else
        eta_final(i) = local_parseEtaFromZone(zoneLine);
    end
    if ~isfinite(eta_final(i))
        error('Zone %d: Could not determine Eta (no AUXDATA Eta and no ETA=... in ZONE title).', i);
    end

    % --- find numeric table start
    firstNum = find(cellfun(@(s) ~isempty(regexp(strtrim(s),'^[\+\-]?\d','once')), block), 1, 'first');
    assert(~isempty(firstNum), 'Zone %d: could not find numeric table start.', i);

    % --- detect numeric row width (how many numbers per row) and parse
    % We do NOT assume it equals nVars.
    rowLens = zeros(numel(block)-firstNum+1,1);
    k = 0;
    for j = firstNum:numel(block)
        s = strtrim(block{j});
        if isempty(s), continue; end
        v = sscanf(s,'%f');
        if isempty(v), continue; end
        k = k+1;
        rowLens(k) = numel(v);
        if k >= 20, break; end
    end
    rowLens = rowLens(1:k);
    assert(~isempty(rowLens),'Zone %d: no numeric rows found.', i);

    rowLen = mode(rowLens);              % most common row length
    assert(rowLen >= 4, 'Zone %d: numeric rows too short.', i);

    % collect numeric lines that match rowLen (allow trailing spaces)
    numLines = {};
    started = false;
    for j = firstNum:numel(block)
        s = strtrim(block{j});
        if isempty(s), continue; end
        v = sscanf(s,'%f');
        if numel(v) == rowLen
            started = true;
            numLines{end+1,1} = s; %#ok<AGROW>
        else
            if started, break; end
        end
    end
    assert(~isempty(numLines), 'Zone %d: parsed zero numeric rows.', i);

    big = sprintf('%s\n', numLines{:});
    fmt = repmat('%f',1,rowLen);
    tmp = textscan(big, fmt, 'CollectOutput', true);
    M = tmp{1};                           % [N x rowLen]

    % --- map parsed numeric columns to VARIABLES
    % If rowLen == nVars: assume 1-to-1 with varNames (standard Tecplot).
    % Else: assume the file omitted the LAST (nVars-rowLen) variables (common in your example).
    colMap = nan(1,nVars);               % var index -> numeric column
    if rowLen == nVars
        colMap = 1:nVars;
    elseif rowLen < nVars
        % assume truncated at end: numeric column k corresponds to variable k
        colMap(1:rowLen) = 1:rowLen;
    else
        % more numbers than variables: take first nVars
        colMap = 1:nVars;
    end

    % --- build final Nx6 with NaN fill if a required variable is missing
    Nrow = size(M,1);
    out6 = nan(Nrow,6);

    out6(:,1) = local_getVarColumn(M, colMap, idx_XoC);    % X/C
    out6(:,2) = local_getVarColumn(M, colMap, idx_X);      % X
    out6(:,3) = local_getVarColumn(M, colMap, idx_Y);      % Y
    out6(:,4) = local_getVarColumn(M, colMap, idx_Z);      % Z (may be missing -> NaN)
    out6(:,5) = local_getVarColumn(M, colMap, idx_CPAVG);  % CP_AVG
    out6(:,6) = local_getVarColumn(M, colMap, idx_CPRMS);  % CP_RMS

    final{i} = out6;

    % --- cut mapping from eta in encounter order
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

    TurbulenceModel_final{i} = TurbulenceModel;
    BasicAlgorithm_final{i}  = BasicAlgorithm;
end
end

% ================= helpers =================
function [VAR, nVars] = local_parseVariables(data)
VAR = {};
nVars = 0;
idx = find(contains(data,'VARIABLES'), 1, 'first');
if isempty(idx), return; end

% join this line + a few following lines (handles wrap and glued tokens)
buf = data{idx};
for k = 1:6
    if idx+k <= numel(data)
        nxt = strtrim(data{idx+k});
        if startsWith(nxt,'ZONE') || startsWith(nxt,'AUXDATA') || startsWith(nxt,'DATASETAUXDATA')
            break;
        end
        buf = [buf, ' ', nxt]; %#ok<AGROW>
    end
end

q = strfind(buf,'"');
if isempty(q) || mod(numel(q),2)~=0, return; end
VAR = cell(1,numel(q)/2);
for k = 1:2:numel(q)
    VAR{(k+1)/2} = buf(q(k)+1:q(k+1)-1);
end
nVars = numel(VAR);
end

function idx = local_findVar(varNames, keys)
idx = [];
for k = 1:numel(keys)
    j = find(strcmpi(varNames, keys{k}), 1);
    if ~isempty(j), idx = j; return; end
end
end

function col = local_getVarColumn(M, colMap, varIdx)
% varIdx is index into varNames; colMap(varIdx) gives numeric column
if isempty(varIdx) || varIdx < 1 || varIdx > numel(colMap) || ~isfinite(colMap(varIdx))
    col = nan(size(M,1),1);
else
    c = colMap(varIdx);
    if c >= 1 && c <= size(M,2)
        col = M(:,c);
    else
        col = nan(size(M,1),1);
    end
end
end

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

function a = local_parseAlphaFromZone(zoneLine)
a = NaN;
toks = regexp(zoneLine,'ALPHA\s*([+\-]?\d+(\.\d+)?([eE][+\-]?\d+)?)','tokens','once');
if ~isempty(toks), a = str2double(toks{1}); end
end

function g = local_parseGridFromZone(zoneLine)
g = '';
toks = regexp(zoneLine,'GRID\s*([0-9]+)','tokens','once');
if ~isempty(toks), g = toks{1}; end
end

function e = local_parseEtaFromZone(zoneLine)
e = NaN;
toks = regexp(zoneLine,'ETA\s*=\s*([+\-]?\d+(\.\d+)?([eE][+\-]?\d+)?)','tokens','once');
if ~isempty(toks), e = str2double(toks{1}); end
end