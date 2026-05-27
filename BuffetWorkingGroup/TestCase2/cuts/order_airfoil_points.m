function [xy_ord, ordIdx, info] = order_airfoil_points(x,z,varargin)
%ORDER_AIRFOIL_POINTS_ALL  Order ALL boundary points on ONE closed contour.
%
% Step 1: Use alphaShape boundary to get a robust coarse ordering (handles concavity).
% Step 2: Reinsert any points not on the alphaShape boundary by projecting them onto the
%         ordered polyline and inserting by (segment index, local arclength fraction).
%
% This returns an ordering that includes EVERY unique input point (after de-dup).
%
% Usage:
%   [xy,idx,info] = order_airfoil_points_all(x,z,'alpha',7e-3,'debug',true);
%
% Name-value:
%   'alpha' : alpha radius for alphaShape (default auto from median NN spacing)
%   'start' : 'LE' (min x) or 'none' (default 'LE')
%   'ccw'   : true to force CCW (default true)
%   'debug' : true plots diagnostics (default false)

p = inputParser;
p.addParameter('alpha', [], @(v) isempty(v) || (isscalar(v)&&isfinite(v)&&v>0));
p.addParameter('start', 'LE', @(s) ischar(s) || isstring(s));
p.addParameter('ccw', true, @(v) islogical(v) && isscalar(v));
p.addParameter('debug', false, @(v) islogical(v) && isscalar(v));
p.parse(varargin{:});
opts = p.Results;

x = x(:); z = z(:);
good = isfinite(x) & isfinite(z);
x = x(good); z = z(good);
P0 = [x,z];

% de-duplicate (we can only order unique points meaningfully)
tol = 1e-12;
[~, ia] = unique(round(P0/tol)*tol,'rows','stable');
P = P0(ia,:);
origIdx = find(good);
origIdx = origIdx(ia);

N = size(P,1);
if N < 10, error('Not enough unique points to order.'); end

% ---- choose alpha if needed
if isempty(opts.alpha)
    idx2 = knnsearch(P,P,'K',2);
    dnn = vecnorm(P - P(idx2(:,2),:),2,2);
    opts.alpha = 3.0*median(dnn);
end

% ---- coarse boundary order from alphaShape
[xyB, idxB] = local_order_alpha_cycle(P, origIdx, opts.alpha);

% enforce CCW if requested
if opts.ccw
    signedA = 0.5*sum( xyB(:,1).*circshift(xyB(:,2),-1) - circshift(xyB(:,1),-1).*xyB(:,2) );
    if signedA < 0
        xyB  = flipud(xyB);
        idxB = flipud(idxB);
    end
end

% rotate start to LE if requested
startMode = lower(string(opts.start));
if startMode == "le" || startMode == "minx"
    [~,kLE] = min(xyB(:,1));
    xyB  = circshift(xyB,  -(kLE-1));
    idxB = circshift(idxB, -(kLE-1));
end

% ---- reinsert missing points
used = false(N,1);
% idxB are indices into original input; we need indices into P (unique list).
% Build map origIdx -> local index in P
mapOrigToLocal = containers.Map(num2cell(origIdx), num2cell(1:N));
B_local = zeros(numel(idxB),1);
for i=1:numel(idxB)
    B_local(i) = mapOrigToLocal(idxB(i));
end
used(B_local) = true;

missingLocal = find(~used);
xyM = P(missingLocal,:);
idxM = origIdx(missingLocal);

% If nothing missing, we're done
if isempty(missingLocal)
    xy_ord = xyB;
    ordIdx = idxB;
    info = struct('alpha',opts.alpha,'N_unique',N,'N_boundary',size(xyB,1),'N_missing',0);
    if opts.debug
        figure; hold on; axis equal; grid on;
        plot(xy_ord(:,1),xy_ord(:,2),'-k'); scatter(xy_ord(1,1),xy_ord(1,2),60,'r','filled');
        title('Ordered (all points already on alphaShape boundary)');
    end
    return;
end

% Precompute boundary segments
B = xyB;
nb = size(B,1);
Bnext = B([2:nb,1],:);
seg = Bnext - B;
segLen2 = sum(seg.^2,2);

% For each missing point: find closest boundary segment and param t in [0,1]
segIdx = zeros(numel(missingLocal),1);
tparam = zeros(numel(missingLocal),1);
dist2  = zeros(numel(missingLocal),1);

for k = 1:numel(missingLocal)
    pnt = xyM(k,:);
    % project to all segments (O(Nb) each; fine for ~1e4 points)
    w = pnt - B;                        % nbx2
    t = (w(:,1).*seg(:,1) + w(:,2).*seg(:,2)) ./ max(segLen2, eps);
    t = min(1,max(0,t));
    proj = B + seg.*t;
    d2 = sum((proj - pnt).^2,2);
    [dist2(k), j] = min(d2);
    segIdx(k) = j;
    tparam(k) = t(j);
end

% Build a global "insertion key" along the closed polyline:
% key = segIdx + tparam in [1, nb+1)
key = double(segIdx) + tparam;

% Sort missing points by key so they are inserted in correct perimeter order
[~,perm] = sort(key,'ascend');
xyM  = xyM(perm,:);
idxM = idxM(perm);
segIdx = segIdx(perm);
tparam = tparam(perm);
key = key(perm);

% Merge boundary and missing points:
% For each boundary vertex i, output B(i), then all missing with segIdx==i in increasing t
xy_ord = zeros(nb + numel(missingLocal), 2);
ordIdx = zeros(nb + numel(missingLocal), 1);

outp = 0;
mpos = 1;
for i = 1:nb
    outp = outp + 1;
    xy_ord(outp,:) = B(i,:);
    ordIdx(outp)   = idxB(i);

    % insert points that project onto segment i (between vertex i and i+1)
    while mpos <= numel(missingLocal) && segIdx(mpos) == i
        outp = outp + 1;
        xy_ord(outp,:) = xyM(mpos,:);
        ordIdx(outp)   = idxM(mpos);
        mpos = mpos + 1;
    end
end

% Safety: remove any unused prealloc (shouldn't happen)
xy_ord = xy_ord(1:outp,:);
ordIdx = ordIdx(1:outp);

% Optionally rotate start again to LE after insertions (LE still among vertices)
if startMode == "le" || startMode == "minx"
    [~,kLE] = min(xy_ord(:,1));
    xy_ord  = circshift(xy_ord,  -(kLE-1));
    ordIdx  = circshift(ordIdx,  -(kLE-1));
end

info = struct();
info.alpha      = opts.alpha;
info.N_unique   = N;
info.N_boundary = nb;
info.N_missing  = numel(missingLocal);
info.meanProjDist = sqrt(mean(dist2));
info.maxProjDist  = sqrt(max(dist2));

if opts.debug
    figure; hold on; axis equal; grid on;
    plot(xy_ord(:,1),xy_ord(:,2),'-k');
    scatter(xy_ord(1,1),xy_ord(1,2),60,'r','filled');
    scatter(P(missingLocal,1), P(missingLocal,2), 18, 'b', 'filled');
    legend('ordered all','start','missing (reinserted)');
    title(sprintf('Ordered ALL points: alpha=%.4g, missing=%d, maxProjDist=%.3g', ...
        opts.alpha, info.N_missing, info.maxProjDist));
end
end

% ========================= helper: alpha boundary ordering =========================
function [xyB, idxB] = local_order_alpha_cycle(P, origIdx, alpha)
shp = alphaShape(P(:,1),P(:,2),alpha);
bf = boundaryFacets(shp);
if isempty(bf)
    error('alphaShape returned empty boundary. Increase alpha.');
end

G = graph(bf(:,1), bf(:,2));
degAll = degree(G);
active = find(degAll>0);
bins = conncomp(G);

compIds = unique(bins(active));
compSizes = zeros(size(compIds));
for k=1:numel(compIds)
    compSizes(k) = sum(bins(active)==compIds(k));
end
[~,kmax] = max(compSizes);
keepComp = compIds(kmax);
keepNodes = active(bins(active)==keepComp);

Gk = subgraph(G, keepNodes);
degk = degree(Gk);
if any(degk~=2)
    error('Boundary not a simple cycle for this alpha. Increase alpha.');
end

Pk = P(keepNodes,:);
[~,i0loc] = min(Pk(:,1));   % start at min x within component
i0 = keepNodes(i0loc);

ord = zeros(numel(keepNodes),1);
ord(1) = i0;
nbs = neighbors(G, i0);
curr = nbs(1);
prev = i0;
for t=2:numel(keepNodes)
    ord(t) = curr;
    nbs = neighbors(G, curr);
    if nbs(1)==prev, nxt=nbs(2); else, nxt=nbs(1); end
    prev = curr; curr = nxt;
end

xyB  = P(ord,:);
idxB = origIdx(ord);
end