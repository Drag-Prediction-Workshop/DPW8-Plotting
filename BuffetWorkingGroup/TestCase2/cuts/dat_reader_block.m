function [TurbulenceModel_final,BasicAlgorithm_final,final,grid_final,alpha_final] = dat_reader_block(file)
%DAT_READER_BLOCK_V2 Robust Tecplot DATAPACKING=BLOCK reader (DPW/AePW cuts).
% Avoids header parsing brittleness and includes a fallback N inference.

txt = fileread(file);
lines = regexp(txt, '\r\n|\n|\r', 'split')';
lines = lines(:);

% global metadata
TurbulenceModel = local_getDataSetAux(txt,'TurbulenceModel');
BasicAlgorithm  = local_getDataSetAux(txt,'BasicAlgorithm');
alphaStr        = local_getDataSetAux(txt,'Alpha');
alphaVal = str2double(alphaStr);
if ~isfinite(alphaVal), alphaVal = NaN; end

% VARIABLES
[varNames, nVars] = local_parseVariables(txt);
assert(nVars>0,'Could not parse VARIABLES.');

% desired outputs
idx_XoC   = local_findVar(varNames, {'X/C','XoC','XOC'});
idx_Z     = local_findVar(varNames, {'Z'});
idx_CPAVG = local_findVar(varNames, {'CP_AVG'});
idx_CPRMS = local_findVar(varNames, {'CP_RMS'});
idx_CFAVG = local_findVar(varNames, {'CF_AVG'});
idx_CFRMS = local_findVar(varNames, {'CF_RMS'});
want = [idx_XoC, idx_Z, idx_CPAVG, idx_CPRMS, idx_CFAVG, idx_CFRMS];
nOut = numel(want);

% zones
zoneLineIdx = find(startsWith(strtrim(lines),'ZONE'));
assert(~isempty(zoneLineIdx),'No ZONE lines found.');
nZones = numel(zoneLineIdx);

final = cell(nZones,1);
grid_final = cell(nZones,1);
alpha_final = NaN(nZones,1);
TurbulenceModel_final = cell(nZones,1);
BasicAlgorithm_final  = cell(nZones,1);

for iz = 1:nZones
    z0 = zoneLineIdx(iz);
    if iz < nZones, z1 = zoneLineIdx(iz+1)-1; else, z1 = numel(lines); end
    block = lines(z0:z1);

    % Find DT= or DATAPACKING line to locate start of numeric blocks later
    iDT = find(contains(block,'DT='), 1, 'first');
    iDP = find(contains(upper(block),'DATAPACKING=BLOCK'), 1, 'first');

    % Build a big header text from the first chunk of lines (before numeric blocks)
    % We DO NOT use "first numeric line" anymore.
    headN = min(500, numel(block));
    headerText = strjoin(block(1:headN), ' ');

    % Parse N from header
    N = local_parseNpts_from_text(headerText);

    % Find numeric start after DT or DATAPACKING
    startSearch = 2;
    if ~isempty(iDT), startSearch = iDT+1;
    elseif ~isempty(iDP), startSearch = iDP+1;
    end
    firstNum = local_findFirstNumericLine(block, startSearch);
    assert(~isempty(firstNum), 'Zone %d: could not find numeric data start.', iz);

    numText = strjoin(block(firstNum:end), sprintf('\n'));
    vals = sscanf(numText, '%f');
    assert(~isempty(vals), 'Zone %d: parsed zero floats.', iz);

    % Fallback: if N not found in header, infer N by trying common divisors
    if ~(isfinite(N) && N>0)
        N = local_inferN_from_vals(vals, nVars);
    end
    assert(isfinite(N) && N>0, 'Zone %d: could not determine point count N.', iz);

    % grid level
    grid_final{iz} = local_getZoneAux(block, 'GridLevel');

    % metadata per zone
    alpha_final(iz) = alphaVal;
    TurbulenceModel_final{iz} = TurbulenceModel;
    BasicAlgorithm_final{iz}  = BasicAlgorithm;

    % blocks present
    K = floor(numel(vals)/N);
    if K < 1, error('Zone %d: numeric data shorter than N=%d.', iz, N); end
    Kuse = min(K, nVars);

    valsUse = vals(1:N*Kuse);
    M = reshape(valsUse, [N, Kuse]);

    full = NaN(N, nVars);
    full(:,1:Kuse) = M;

    out = NaN(N, nOut);
    for k = 1:nOut
        iv = want(k);
        if ~isempty(iv) && isfinite(iv) && iv <= nVars
            out(:,k) = full(:,iv);
        end
    end
    final{iz} = out;
end
end

% ================= helpers =================
function [VAR, nVars] = local_parseVariables(txt)
VAR = {};
nVars = 0;
pos = regexp(txt,'VARIABLES','once');
if isempty(pos), return; end
tail = txt(pos:min(end,pos+8000));
stop = regexp(tail,'\n\s*ZONE','once');
if ~isempty(stop), tail = tail(1:stop-1); end
q = strfind(tail,'"');
if isempty(q) || mod(numel(q),2)~=0, return; end
VAR = cell(1,numel(q)/2);
for i = 1:2:numel(q)
    VAR{(i+1)/2} = tail(q(i)+1:q(i+1)-1);
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

function val = local_getDataSetAux(txt, key)
expr = ['DATASETAUXDATA\s+', regexptranslate('escape',key), '\s*=\s*"([^"]*)"'];
t = regexp(txt, expr, 'tokens', 'once');
if isempty(t), val = ''; else, val = t{1}; end
end

function val = local_getZoneAux(blockLines, key)
val = '';
expr = ['AUXDATA\s+', regexptranslate('escape',key), '\s*=\s*"([^"]*)"'];
for i=1:numel(blockLines)
    t = regexp(blockLines{i}, expr, 'tokens', 'once');
    if ~isempty(t)
        val = t{1};
        return;
    end
end
end

function N = local_parseNpts_from_text(s)
% FE Nodes=
t = regexp(s,'Nodes\s*=\s*([0-9]+)','tokens','once','ignorecase');
if ~isempty(t), N = str2double(t{1}); return; end

% Ordered I/J/K (very permissive)
ti = regexp(s,'(^|[^A-Za-z0-9_])I\s*=\s*([0-9]+)','tokens','once','ignorecase');
if ~isempty(ti)
    I = str2double(ti{2});
    tj = regexp(s,'(^|[^A-Za-z0-9_])J\s*=\s*([0-9]+)','tokens','once','ignorecase');
    tk = regexp(s,'(^|[^A-Za-z0-9_])K\s*=\s*([0-9]+)','tokens','once','ignorecase');
    if isempty(tj), J = 1; else, J = str2double(tj{2}); end
    if isempty(tk), K = 1; else, K = str2double(tk{2}); end
    N = I*J*K;
    return;
end

% N=
tn = regexp(s,'(^|[^A-Za-z0-9_])N\s*=\s*([0-9]+)','tokens','once','ignorecase');
if ~isempty(tn), N = str2double(tn{2}); return; end

N = NaN;
end

function idx = local_findFirstNumericLine(block, startAt)
idx = [];
for i = startAt:numel(block)
    s = strtrim(block{i});
    if isempty(s), continue; end
    % avoid header-like lines
    if contains(s,'=') && ~isempty(regexp(s,'[A-Za-z]', 'once'))
        continue;
    end
    v = sscanf(s,'%f');
    if ~isempty(v)
        idx = i;
        return;
    end
end
end

function N = local_inferN_from_vals(vals, nVars)
% Heuristic: N should be a "reasonable" divisor producing at least 1 block and <= nVars blocks.
% We try candidate N from 50..200000 based on divisors of numel(vals).
M = numel(vals);
% for typical sections N is 50..5000; search that first
cand = 50:1:min(20000, M);
best = NaN;

for Ntry = cand
    K = floor(M / Ntry);
    if K >= 1 && K <= max(nVars, 12)  % allow some extra (connectivity may add numbers)
        % Prefer K close to nVars or at least >=3 (X,Y,Z...)
        if isnan(best)
            best = Ntry;
        else
            % prefer larger N (more plausible) and K not crazy
            if Ntry > best
                best = Ntry;
            end
        end
    end
end
N = best;
if isnan(N)
    N = NaN;
end
end