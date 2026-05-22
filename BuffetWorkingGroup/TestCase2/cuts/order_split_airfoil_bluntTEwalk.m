function out = order_split_airfoil_bluntTEwalk(x,z,varargin)
%ORDER_SPLIT_AIRFOIL_BLUNTTE
% Robust ordering + split into upper/lower/TE for blunt TE airfoil.
%
% Strategy:
%  (1) Order contour via alphaShape boundary (concave OK), CCW, starting at LE.
%  (2) Find TE corners from tiny chordwise S-band near TE (extremes in Q).
%  (3) Build the two arcs between TE corners on the ordered loop.
%      The shorter arc = TE connector. The longer arc = BODY.
%  (4) Split BODY at LE into upper (LE->TEu) and lower (LE->TEl) by endpoint identity,
%      not by mean-z/Q (cusp-safe).
%
% Usage:
%   out = order_split_airfoil_bluntTE(x,z,'alpha',7e-3,'sBandFrac',5e-5,'debug',true);

p = inputParser;
p.addParameter('alpha', [], @(v) isempty(v) || (isscalar(v)&&isfinite(v)&&v>0));
p.addParameter('sBandFrac', 1e-3, @(v) isscalar(v)&&isfinite(v)&&v>0&&v<0.2);
p.addParameter('teMaxFrac', 0.05, @(v) isscalar(v)&&isfinite(v)&&v>0&&v<0.6);
p.addParameter('debug', false, @(v) islogical(v)&&isscalar(v));
p.parse(varargin{:});
opts = p.Results;

% ---- clean + dedupe
x = x(:); z = z(:);
good = isfinite(x) & isfinite(z);
x = x(good); z = z(good);
P = [x,z];

tol = 1e-12;
[~, ia] = unique(round(P/tol)*tol,'rows','stable');
P = P(ia,:);
origIdx = find(good); origIdx = origIdx(ia);
N = size(P,1);
if N < 10, error('Not enough unique points.'); end

% ---- alpha
if isempty(opts.alpha)
    idx2 = knnsearch(P,P,'K',2);
    dnn = vecnorm(P - P(idx2(:,2),:),2,2);
    opts.alpha = 3.0*median(dnn);
end

% ---- order boundary via alphaShape (simple cycle)
shp = alphaShape(P(:,1),P(:,2),opts.alpha);
bf = boundaryFacets(shp);
if isempty(bf), error('alphaShape produced empty boundary. Increase alpha.'); end

G = graph(bf(:,1), bf(:,2));
degAll = degree(G);
active = find(degAll>0);
bins = conncomp(G);
compIds = unique(bins(active));
compSizes = zeros(size(compIds));
for k=1:numel(compIds), compSizes(k)=sum(bins(active)==compIds(k)); end
[~,kmax] = max(compSizes);
keepNodes = active(bins(active)==compIds(kmax));

Gk = subgraph(G, keepNodes);
degk = degree(Gk);
if opts.debug
    fprintf('alpha=%.6g: boundary edges=%d, components=1, kept nodes=%d, deg2 fraction=%.3f\n', ...
        opts.alpha, size(bf,1), numnodes(Gk), mean(degk==2));
end
if any(degk~=2)
    error('Kept boundary component is not a simple cycle (deg~=2). Increase alpha.');
end

% traverse cycle from LE (min x among kept)
Pk = P(keepNodes,:);
[~,iLE_loc] = min(Pk(:,1));
iLE = keepNodes(iLE_loc);

ord = zeros(numel(keepNodes),1);
ord(1)=iLE;
nbs = neighbors(G, iLE);
curr = nbs(1); prev=iLE;
for t=2:numel(keepNodes)
    ord(t)=curr;
    nbs = neighbors(G, curr);
    if nbs(1)==prev, nxt=nbs(2); else, nxt=nbs(1); end
    prev=curr; curr=nxt;
end

XYo  = P(ord,:);
idxo = origIdx(ord);
n = size(XYo,1);

% enforce CCW
signedA = 0.5*sum( XYo(:,1).*circshift(XYo(:,2),-1) - circshift(XYo(:,1),-1).*XYo(:,2) );
if signedA < 0
    XYo  = flipud(XYo);
    idxo = flipud(idxo);
end

% rotate so LE is first
[~,iLE2] = min(XYo(:,1));
XY  = circshift(XYo,  -(iLE2-1));
idx = circshift(idxo, -(iLE2-1));

% perimeter edges
dedge = vecnorm(diff([XY; XY(1,:)],1,1),2,2);
perim = sum(dedge);

% ---- chordwise coordinates S and normal Q
[~, iTEpre] = max(XY(:,1)); % direction proxy
LE = XY(1,:);
TEpre = XY(iTEpre,:);
t = TEpre - LE; nt = norm(t);
if nt < eps, error('Degenerate LE->TEpre.'); end
t = t/nt;
nvec = [-t(2), t(1)];

S = (XY - LE)*t(:);
Q = (XY - LE)*nvec(:);

Smax = max(S); Smin=min(S); Sspan=max(Smax-Smin, eps);
sBand = opts.sBandFrac*Sspan;
TEcand = find(S >= Smax - sBand);
if numel(TEcand) < 4
    error('Too few TE candidates; increase sBandFrac slightly.');
end

% TE corners = extremes in Q within TEcand
[~,iu] = max(Q(TEcand)); iTEu = TEcand(iu);
[~,il] = min(Q(TEcand)); iTEl = TEcand(il);
if iTEu==iTEl, error('Failed to find distinct TE corners; increase sBandFrac.'); end

% ---- build both arcs between TE corners
arc_u2l = arc_indices(iTEu,iTEl,n);
len_u2l = sum(dedge(arc_u2l(1:end-1)));
arc_l2u = arc_indices(iTEl,iTEu,n);
len_l2u = sum(dedge(arc_l2u(1:end-1)));

% Shorter arc is TE, longer is BODY
if len_u2l <= len_l2u
    teIdx   = arc_u2l;
    bodyIdx = arc_l2u;
    teLen = len_u2l;
else
    teIdx   = arc_l2u;
    bodyIdx = arc_u2l;
    teLen = len_l2u;
end

% Ensure TE is ordered TEu->TEl (upper->lower) based on Q
if Q(teIdx(1)) < Q(teIdx(end))
    teIdx = flipud(teIdx);
end
iTEu2 = teIdx(1);
iTEl2 = teIdx(end);

if opts.debug
    fprintf('TE corners: TEu=(%.6g,%.6g), TEl=(%.6g,%.6g)\n', ...
        XY(iTEu2,1),XY(iTEu2,2), XY(iTEl2,1),XY(iTEl2,2));
    fprintf('sBandFrac=%g, TEcand=%d, TE len frac=%.4f, TE points=%d/%d\n', ...
        opts.sBandFrac, numel(TEcand), teLen/perim, numel(teIdx), n);
end
if teLen > opts.teMaxFrac*perim
    error('TE connector too long. Reduce sBandFrac or teMaxFrac.');
end

% ---- BODY arc should contain LE and both TE corners
if ~ismember(1, bodyIdx)
    error('LE not on body arc (unexpected).');
end
if ~ismember(iTEu2, bodyIdx) || ~ismember(iTEl2, bodyIdx)
    error('TE corners not on body arc (unexpected).');
end

% Rotate BODY to start at LE
kLEb = find(bodyIdx==1,1);
bodyR = [bodyIdx(kLEb:end); bodyIdx(1:kLEb-1)];

% Find where TE corners are on bodyR
kU = find(bodyR==iTEu2,1);
kL = find(bodyR==iTEl2,1);

% Build LE->TEu and LE->TEl on bodyR.
% One is a forward prefix; the other must be the wrap-around suffix with LE prepended.
if kU < kL
    pathU = bodyR(1:kU);                % LE -> TEu
    pathL = [bodyR(1); bodyR(kL:end)];  % LE -> ...wrap... -> TEl
else
    pathL = bodyR(1:kL);                % LE -> TEl
    pathU = [bodyR(1); bodyR(kU:end)];  % LE -> ...wrap... -> TEu
end

% At this point endpoints are guaranteed:
%   pathU(end) == iTEu2, pathL(end) == iTEl2
% Label them exactly like that (no swapping).
upperIdx = pathU;
lowerIdx = pathL;

% Final sanity: upper should have larger mean Q; if not, your TEu/TEl got swapped -> swap them.
if mean(Q(upperIdx)) < mean(Q(lowerIdx))
    % swap labels only (geometry is fine)
    tmp=upperIdx; upperIdx=lowerIdx; lowerIdx=tmp;
end

% ---- outputs
out = struct();
out.xy = XY;
out.ordIdx = idx;
out.upper = struct('xy', XY(upperIdx,:), 'idx', idx(upperIdx));
out.lower = struct('xy', XY(lowerIdx,:), 'idx', idx(lowerIdx));
out.te    = struct('xy', XY(teIdx,:),    'idx', idx(teIdx));
out.meta  = struct('alpha',opts.alpha,'sBandFrac',opts.sBandFrac,'sBand',sBand, ...
                   'perimeter',perim,'teLenFrac',teLen/perim,'LE',LE,'TEpre',TEpre, ...
                   'iTEu',iTEu2,'iTEl',iTEl2,'nOrdered',n,'nTEcand',numel(TEcand));

if opts.debug
    figure; hold on; axis equal; grid on;
    plot(XY(:,1),XY(:,2),'-k','DisplayName','ordered');
    scatter(out.upper.xy(:,1), out.upper.xy(:,2), 18,'r','filled','DisplayName','upper');
    scatter(out.lower.xy(:,1), out.lower.xy(:,2), 18,'b','filled','DisplayName','lower');
    scatter(out.te.xy(:,1),    out.te.xy(:,2),    60,'g','filled','DisplayName','TE');
    legend show;
    title(sprintf('alpha=%.4g, sBandFrac=%g, TE len frac=%.4f', opts.alpha, opts.sBandFrac, teLen/perim));
end
end

function arc = arc_indices(iStart,iEnd,n)
if iStart <= iEnd
    arc = (iStart:iEnd)';
else
    arc = [ (iStart:n)'; (1:iEnd)' ];
end
end