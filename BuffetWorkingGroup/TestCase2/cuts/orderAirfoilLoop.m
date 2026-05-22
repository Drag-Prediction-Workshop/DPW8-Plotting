function [x_ord, z_ord, idx_ord] = orderAirfoilLoop(x, z, alpha)
%ORDERAIRFOILLOOP Order scattered surface points around a non-convex airfoil.
%
% Inputs
%   x, z   : unordered surface points (Nx1 or 1xN)
%   alpha  : (optional) alpha radius for alphaShape. If empty/omitted, auto-guess.
%
% Outputs
%   x_ord, z_ord : ordered points around the airfoil, closed loop (first point repeated at end)
%   idx_ord      : indices into the ORIGINAL x,z that correspond to x_ord,z_ord
%
% Notes
%   - Requires alphaShape (MATLAB).
%   - If you have duplicate points, they are handled; idx_ord maps back to original.

x = x(:); z = z(:);
P = [x z];

% Keep mapping back to original indices
[Puniq, ia] = unique(P, "rows", "stable");   % ia maps uniq -> original
xu = Puniq(:,1); zu = Puniq(:,2);

% Auto alpha guess if not provided
if nargin < 3 || isempty(alpha)
    k = 6;
    [~, D] = knnsearch(Puniq, Puniq, "K", k);
    h = median(D(:,end));        % typical neighbor distance
    alpha = 2.5*h;               % tweak 1.5–4*h if needed
end

shp = alphaShape(xu, zu, alpha);

% Boundary edges (pairs of vertex indices into Puniq)
E = boundaryFacets(shp);
if isempty(E)
    error("No boundary found. Try increasing alpha.");
end

% Order edges into one or more loops, keep the largest (outer) loop
loops = edgesToLoops(E);
[~, kmax] = max(cellfun(@numel, loops));
loop = loops{kmax};

% Optional: start near trailing edge (max x)
[~, iTE] = max(xu(loop));
loop = loop([iTE:end, 1:iTE-1]);

% Optional: force clockwise orientation (common airfoil convention)
if signedPolyArea(xu(loop), zu(loop)) > 0
    loop = flipud(loop(:));
end

% Close the loop by repeating the first point at the end
loop_closed = [loop; loop(1)];

x_ord = xu(loop_closed);
z_ord = zu(loop_closed);

% Map uniq indices back to original indices
idx_ord = ia(loop_closed);

end

% ---------- helpers ----------

function loops = edgesToLoops(E)
% Convert undirected edge list E (Mx2) into one or more ordered vertex loops.

n = max(E(:));
adj = cell(n,1);
for i = 1:size(E,1)
    a = E(i,1); b = E(i,2);
    adj{a} = [adj{a} b];
    adj{b} = [adj{b} a];
end

visited = false(size(E,1),1);

% Use a map from unordered edge -> edge index for fast lookup
% Key: "min_max"
edgeKey = strings(size(E,1),1);
for i=1:size(E,1)
    a = E(i,1); b = E(i,2);
    if a>b, t=a; a=b; b=t; end
    edgeKey(i) = a + "_" + b;
end
edgeMap = containers.Map(edgeKey, 1:size(E,1));

loops = {};
vertsWithEdges = find(cellfun(@numel, adj) > 0);

usedVertex = false(n,1); %#ok<NASGU> % not strictly needed

for s = vertsWithEdges(:)'
    % try to start a loop from s if it has any unused incident edge
    nbrs = adj{s};
    if isempty(nbrs), continue; end

    % find an unused edge from s
    startFound = false;
    for nb = nbrs
        k = edgeIndex(edgeMap, s, nb);
        if ~visited(k)
            startFound = true;
            startN = nb;
            startK = k;
            break;
        end
    end
    if ~startFound, continue; end

    % walk the loop
    loop = s;
    prev = s;
    curr = startN;
    visited(startK) = true;

    while true
        loop(end+1,1) = curr; %#ok<AGROW>

        % choose next neighbor of curr that doesn't go back along already-used edge if possible
        nbrs = adj{curr};
        if isempty(nbrs)
            break; % open chain (shouldn't happen for a proper boundary)
        end

        % if we returned to start, loop closed
        if curr == s
            break;
        end

        next = [];
        for nb = nbrs
            k = edgeIndex(edgeMap, curr, nb);
            if ~visited(k) && nb ~= prev
                next = nb;
                visited(k) = true;
                break;
            end
        end

        if isempty(next)
            % either only option is going back, or remaining edges already visited
            % try going back if that closes the loop
            for nb = nbrs
                k = edgeIndex(edgeMap, curr, nb);
                if ~visited(k)
                    next = nb;
                    visited(k) = true;
                    break;
                end
            end
        end

        if isempty(next)
            % no unvisited continuation; stop
            break;
        end

        prev = curr;
        curr = next;
    end

    % remove duplicate terminal start vertex if present (we close later ourselves)
    if numel(loop) >= 2 && loop(end) == loop(1)
        loop(end) = [];
    end

    if numel(loop) >= 3
        loops{end+1} = loop; %#ok<AGROW>
    end
end
end

function k = edgeIndex(edgeMap, a, b)
% lookup index for undirected edge (a,b)
if a>b, t=a; a=b; b=t; end
k = edgeMap(a + "_" + b);
end

function A = signedPolyArea(x, y)
% signed area: >0 CCW, <0 CW
A = 0.5*sum( x.*y([2:end 1]) - x([2:end 1]).*y );
end