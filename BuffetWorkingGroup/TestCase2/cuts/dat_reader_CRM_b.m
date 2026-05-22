function [TurbulenceModel_final,BasicAlgorithm_final,final,grid_final,alpha_final,cut_final,eta_final] = dat_reader_CRM_b(file)
%DAT_READER_CRM_B  Reader for DPW/AePW sectional cut Tecplot ASCII (variant B)
%
% Handles files where:
%  - VARIABLES may contain "XoC" (instead of "X/C")
%  - ZONE blocks include additional Tecplot headers:
%       STRANDID=..., Nodes=..., Elements=..., ZONETYPE=..., DATAPACKING=..., DT=(...)
%  - ZONETYPE can be FELineSeg, followed by connectivity lines (e.g., "1 2")
%
% Outputs match dat_reader_CRM_a:
%   TurbulenceModel_final : cell(nZones,1) (same value replicated)
%   BasicAlgorithm_final  : cell(nZones,1) (same value replicated)
%   final                 : cell(nZones,1) numeric, columns = [X/C(or XoC), X, Y, Z, CP_AVG, CP_RMS]
%   grid_final            : cell(nZones,1) GridLevel string
%   alpha_final           : (nZones,1) double
%   cut_final             : (nZones,1) double (wing section number)
%   eta_final             : (nZones,1) double

fid = fopen(file,'r');
assert(fid>0, 'Cannot open file: %s', file);
C = textscan(fid, '%s', 'delimiter', '\n', 'whitespace','');
fclose(fid);
data = C{1};

% ---------- Global metadata (replicated per zone, like your original)
tmLine = local_getFirstMatchLine(data, 'TurbulenceModel');
baLine = local_getFirstMatchLine(data, 'BasicAlgorithm');

if isempty(tmLine), TurbulenceModel = ''; else, TurbulenceModel = local_getQuoted(tmLine); end
if isempty(baLine), BasicAlgorithm  = ''; else, BasicAlgorithm  = local_getQuoted(baLine); end

% ---------- Indices
ZONE      = find(contains(data,'ZONE '));
GridLevel = find(contains(data,'AUXDATA GridLevel'));
Alpha     = find(contains(data,'AUXDATA Alpha'));
Eta       = find(contains(data,'AUXDATA Eta'));

% Old-style SECTION lines (may not exist in new files)
CutLines  = find(contains(data,'SECTION ') & ~contains(data,'EXAMPLE'));

assert(~isempty(ZONE), 'No ZONE lines found.');

% ---------- VARIABLES parse
varLineIdx = find(contains(data,'VARIABLES'), 1, 'first');
assert(~isempty(varLineIdx), 'No VARIABLES line found.');
VARline = data{varLineIdx};

k = strfind(VARline,'"');
assert(mod(numel(k),2)==0 && ~isempty(k), 'Could not parse VARIABLES quotes.');
VAR = cell(1, numel(k)/2);
for ii = 1:2:numel(k)
    VAR{(ii+1)/2} = VARline(k(ii)+1:k(ii+1)-1);
end

% Select columns to match your original output: [X/C(or XoC), X, Y, Z, CP_AVG, CP_RMS]
idx_XoC   = find(strcmpi(VAR,'X/C') | strcmpi(VAR,'XoC') | strcmpi(VAR,'XOC'), 1);
idx_X     = find(strcmpi(VAR,'X'), 1);
idx_Y     = find(strcmpi(VAR,'Y'), 1);
idx_Z     = find(strcmpi(VAR,'Z'), 1);
idx_CPAVG = find(strcmpi(VAR,'CP_AVG'), 1);
idx_CPRMS = find(strcmpi(VAR,'CP_RMS'), 1);

a = [idx_XoC, idx_X, idx_Y, idx_Z, idx_CPAVG, idx_CPRMS];
if any(cellfun(@isempty, {idx_XoC,idx_X,idx_Y,idx_Z,idx_CPAVG,idx_CPRMS}))
    error('Missing required VARIABLES. Need X/C or XoC, X, Y, Z, CP_AVG, CP_RMS. Found: %s', strjoin(VAR, ', '));
end

nVars = numel(VAR);
nZones = numel(ZONE);

% ---------- Preallocate outputs
final = cell(nZones,1);
grid_final = cell(nZones,1);
alpha_final = nan(nZones,1);
eta_final   = nan(nZones,1);
cut_final   = nan(nZones,1);
TurbulenceModel_final = cell(nZones,1);
BasicAlgorithm_final  = cell(nZones,1);

% ---------- Loop zones
for i = 1:nZones
    % zone content lines (excluding the ZONE line itself)
    iStart = ZONE(i) + 1;
    if i < nZones
        iEnd = ZONE(i+1) - 1;
    else
        iEnd = numel(data);
    end
    block = data(iStart:iEnd);

    % Find first numeric-looking line => start of node data
    firstNum = find(cellfun(@(s) ~isempty(regexp(strtrim(s),'^[\+\-]?\d','once')), block), 1, 'first');
    assert(~isempty(firstNum), 'Zone %d: could not find start of numeric data.', i);

    % Collect node data lines only: must contain at least nVars numeric fields
    numDataLines = {};
    started = false;
    for j = firstNum:numel(block)
        s = strtrim(block{j});
        if isempty(s), continue; end

        % Quick parse of all floats on the line
        vals = sscanf(s, '%f');

        if numel(vals) >= nVars
            started = true;
            numDataLines{end+1,1} = s; %#ok<AGROW>
        else
            % Once data started, a short line is likely connectivity ("1 2") or similar => stop
            if started
                break;
            end
        end
    end

    assert(~isempty(numDataLines), 'Zone %d: no node data lines parsed.', i);

    % Parse node data with fixed column count
    big = sprintf('%s\n', numDataLines{:});
    fmt = repmat('%f', 1, nVars);
    tmp = textscan(big, fmt, 'CollectOutput', true);
    M = tmp{1};   % [Npoints x nVars]

    % Select required columns
    final{i} = M(:, a);

    % Per-zone meta (kept consistent with your original approach: index i)
    if i <= numel(GridLevel)
        grid_final{i} = local_getQuoted(data{GridLevel(i)});
    else
        grid_final{i} = '';
    end

    if i <= numel(Alpha)
        alpha_final(i) = str2double(local_getQuoted(data{Alpha(i)}));
    end

    if i <= numel(Eta)
        eta_final(i) = str2double(local_getQuoted(data{Eta(i)}));
    end

    % Section/cut parsing:
    % Prefer ZONE title: "... WING SECTION 1 ..."
    zline = data{ZONE(i)};
    secTok = regexp(zline, 'WING\s+SECTION\s*([0-9]+)', 'tokens', 'once');
    if ~isempty(secTok)
        cut_final(i) = str2double(secTok{1});
    else
        % fallback to old-style SECTION line list if present
        if i <= numel(CutLines)
            cutLine = data{CutLines(i)};
            q = strfind(cutLine,'"');
            k2 = strfind(cutLine,'SECTION');
            if ~isempty(q) && numel(q) >= 2 && ~isempty(k2)
                cutStr = cutLine(k2+7:q(2)-1);
            else
                cutStr = regexprep(cutLine, '.*SECTION\s*', '');
            end
            cut_final(i) = str2double(strtrim(cutStr));
        end
    end

    % Replicate global strings per zone
    TurbulenceModel_final{i} = TurbulenceModel;
    BasicAlgorithm_final{i}  = BasicAlgorithm;
end

end

% ===================== local helpers =====================
function s = local_getQuoted(line)
k = strfind(line,'"');
if numel(k) >= 2
    s = line(k(1)+1:k(2)-1);
else
    eq = strfind(line,'=');
    if ~isempty(eq)
        s = strtrim(line(eq(1)+1:end));
    else
        s = strtrim(line);
    end
end
end

function line = local_getFirstMatchLine(data, pat)
idx = find(contains(data, pat), 1, 'first');
if isempty(idx)
    line = '';
else
    line = data{idx};
end
end