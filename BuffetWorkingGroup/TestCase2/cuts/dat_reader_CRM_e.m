function [TurbulenceModel_final,BasicAlgorithm_final,final,grid_final,alpha_final,cut_final,eta_final] = dat_reader_CRM_e(file)
% Reads DPW-8/AePW-4 (Version 5) files that may contain template/example text
% PLUS one or more real datasets appended later (multiple TITLE blocks).
%
% Outputs like your dat_reader_CRM_a:
%   final{i} columns = [X/C(or XoC), X, Y, Z, CP_AVG, CP_RMS]
%
% cut_final rule (as requested earlier):
%   cut_final(i) is based on unique Eta in file order:
%       first unique Eta => cut 1, second => cut 2, etc.
%
% Robustness:
%   - ignores template rows with "???.????" etc (not numeric)
%   - handles blank lines
%   - does NOT assume ZONE data start at fixed offsets

fid = fopen(file,'r');
assert(fid>0, 'Cannot open file: %s', file);
C = textscan(fid, '%s', 'delimiter','\n', 'whitespace','');
fclose(fid);
data = C{1};

% ----- Parse VARIABLES (use the LAST VARIABLES line before first real ZONE,
% but in practice just use the last VARIABLES in the file)
varIdxAll = find(contains(data,'VARIABLES'));
assert(~isempty(varIdxAll), 'No VARIABLES line found.');
VARline = data{varIdxAll(end)};

q = strfind(VARline,'"');
assert(mod(numel(q),2)==0 && ~isempty(q), 'Could not parse VARIABLES quotes.');
VAR = cell(1,numel(q)/2);
for k = 1:2:numel(q)
    VAR{(k+1)/2} = VARline(q(k)+1:q(k+1)-1);
end
nVars = numel(VAR);

% Needed columns
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

% ----- Find all zones (real + template). We will keep only zones that have real numeric data.
ZONE = find(contains(data,'ZONE '));
assert(~isempty(ZONE), 'No ZONE lines found.');

% outputs (build dynamically because we skip template zones)
final = {};
grid_final = {};
alpha_final = [];
eta_final   = [];
cut_final   = [];
TurbulenceModel_final = {};
BasicAlgorithm_final  = {};

% eta->cut mapping in order of first appearance
eta_keys = [];
eta_tol  = 1e-10;

outCount = 0;

for iz = 1:numel(ZONE)
    % Determine zone block bounds
    iStart = ZONE(iz)+1;
    if iz < numel(ZONE), iEnd = ZONE(iz+1)-1; else, iEnd = numel(data); end
    block = data(iStart:iEnd);

    % Extract per-zone metadata by searching within the block (more robust than global indexing)
    gridStr  = local_getQuoted(local_getFirstMatchLine(block, 'AUXDATA GridLevel'));
    alphaStr = local_getQuoted(local_getFirstMatchLine(block, 'AUXDATA Alpha'));
    etaStr   = local_getQuoted(local_getFirstMatchLine(block, 'AUXDATA Eta'));

    alphaVal = str2double(alphaStr);
    etaVal   = str2double(etaStr);

    % If eta is not numeric, this is probably the template/example section => skip
    if ~isfinite(etaVal)
        continue;
    end

    % Collect numeric table lines: must have >= nVars numeric fields.
    % This automatically ignores template "???.????" lines.
    numLines = {};
    started = false;
    for j = 1:numel(block)
        s = strtrim(block{j});
        if isempty(s), continue; end

        % Only consider lines that start with a number (+/- allowed)
        if isempty(regexp(s,'^[\+\-]?\d','once'))
            continue;
        end

        vals = sscanf(s,'%f');
        if numel(vals) >= nVars
            started = true;
            numLines{end+1,1} = s; %#ok<AGROW>
        else
            if started, break; end
        end
    end

    % If no numeric data, skip this zone
    if isempty(numLines)
        continue;
    end

    % Parse numeric table
    big = sprintf('%s\n', numLines{:});
    fmt = repmat('%f',1,nVars);
    tmp = textscan(big, fmt, 'CollectOutput', true);
    M = tmp{1};

    % Some files may have fewer columns than VARIABLES suggests (rare); guard:
    if size(M,2) < max(a)
        continue; % or error(...) if you prefer
    end

    % ---- accept this zone
    outCount = outCount + 1;

    final{outCount,1} = M(:,a);

    grid_final{outCount,1}  = gridStr;
    alpha_final(outCount,1) = alphaVal;
    eta_final(outCount,1)   = etaVal;

    % cut from eta order
    if isempty(eta_keys)
        eta_keys = etaVal;
        cut_final(outCount,1) = 1;
    else
        jj = find(abs(eta_keys - etaVal) <= eta_tol, 1, 'first');
        if isempty(jj)
            eta_keys(end+1) = etaVal; %#ok<AGROW>
            cut_final(outCount,1) = numel(eta_keys);
        else
            cut_final(outCount,1) = jj;
        end
    end

    % Turbulence/basic algorithm: find the LAST occurrence before this zone (closest above)
    % This handles multi-TITLE files where metadata repeats.
    tm = local_findNearestAbove(data, ZONE(iz), 'TurbulenceModel');
    ba = local_findNearestAbove(data, ZONE(iz), 'BasicAlgorithm');

    TurbulenceModel_final{outCount,1} = local_getQuoted(tm);
    BasicAlgorithm_final{outCount,1}  = local_getQuoted(ba);
end

end

% ================= helpers =================
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

function line = local_getFirstMatchLine(lines, pat)
idx = find(contains(lines, pat), 1, 'first');
if isempty(idx), line = ''; else, line = lines{idx}; end
end

function line = local_findNearestAbove(data, idx0, pat)
% Find nearest line above idx0 that contains pat
idx = find(contains(data(1:idx0), pat), 1, 'last');
if isempty(idx), line = ''; else, line = data{idx}; end
end