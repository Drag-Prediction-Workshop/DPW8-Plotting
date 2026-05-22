function [xy_ord, ordIdx, info] = order_airfoil_points_robust(x,z,varargin)
%ORDER_AIRFOIL_POINTS_ROBUST Order unordered boundary points on one closed contour.
% Robust for mild noise + TE cusp. Uses ALL points (after de-dup).
%
% Method: greedy NN tour + repeated 2-opt crossing removal + shortening.
%
% Usage:
%   [xy,idx,info] = order_airfoil_points_robust(x,z,'start','LE','ccw',true,'maxSweeps',80,'debug',true);
%
% Notes:
%  - O(N^2) but fine for N~1000-2000.
%  - Removes duplicates within tol.

p = inputParser;
p.addParameter('start','LE', @(s) ischar(s)||isstring(s));
p.addParameter('ccw', true, @(v) islogical(v)&&isscalar(v));
p.addParameter('maxSweeps', 80, @(v) isscalar(v)&&v>=1);
p.addParameter('maxCrossPass', 20, @(v) isscalar(v)&&v>=1);
p.addParameter('debug', false, @(v) islogical(v)&&isscalar(v));
p.parse(varargin{:});
opts = p.Results;

x = x(:); z = z(:);
good = isfinite(x) & isfinite(z);
x = x(good); z = z(good);
P0 = [x,z];

% de-duplicate
tol = 1e-12;
[~, ia] = unique(round(P0/tol)*tol,'rows','stable');
P = P0(ia,:);
origIdx = find(good);
origIdx = origIdx(ia);
N = size(P,1);
if N < 10, error('Not enough unique points.'); end

Px = P(:,1); Pz = P(:,2);

% start index
startMode = lower(string(opts.start));
if startMode=="le" || startMode=="minx"
    [~,s] = min(Px);
else
    s = 1;
end

% ---- initial tour: greedy nearest neighbor (full search, N~2000 ok)
ord = zeros(N,1);
ord(1) = s;
used = false(N,1);
used(s) = true;

for k = 2:N
    cur = ord(k-1);
    uu = find(~used);
    dx = Px(uu) - Px(cur);
    dz = Pz(uu) - Pz(cur);
    [~,m] = min(dx.*dx + dz.*dz);
    ord(k) = uu(m);
    used(ord(k)) = true;
end

% ---- 2-opt sweeps (intersection OR shortening)
sweep = 0;
improved = true;
while improved && sweep < opts.maxSweeps
    improved = false;
    sweep = sweep + 1;

    for i = 1:N-3
        a = ord(i);   b = ord(i+1);
        Ax=Px(a); Az=Pz(a); Bx=Px(b); Bz=Pz(b);

        for j = i+2:N-1
            c = ord(j);   d = ord(j+1);
            % skip adjacency
            if d==a, continue; end

            Cx=Px(c); Cz=Pz(c); Dx=Px(d); Dz=Pz(d);

            % crossing check
            if segIntersect(Ax,Az,Bx,Bz,Cx,Cz,Dx,Dz)
                ord(i+1:j) = ord(j:-1:i+1);
                improved = true;
                continue;
            end

            % shortening check
            oldL = hypot(Ax-Bx,Az-Bz) + hypot(Cx-Dx,Cz-Dz);
            newL = hypot(Ax-Cx,Az-Cz) + hypot(Bx-Dx,Bz-Dz);
            if newL < oldL
                ord(i+1:j) = ord(j:-1:i+1);
                improved = true;
            end
        end
    end
end

% ---- final crossing-only cleanup passes (often fixes last few swaps for cusp/noise)
crossPass = 0;
while crossPass < opts.maxCrossPass
    crossPass = crossPass + 1;
    changed = false;

    for i = 1:N-3
        a = ord(i);   b = ord(i+1);
        Ax=Px(a); Az=Pz(a); Bx=Px(b); Bz=Pz(b);

        for j = i+2:N-1
            c = ord(j);   d = ord(j+1);
            if d==a, continue; end
            Cx=Px(c); Cz=Pz(c); Dx=Px(d); Dz=Pz(d);

            if segIntersect(Ax,Az,Bx,Bz,Cx,Cz,Dx,Dz)
                ord(i+1:j) = ord(j:-1:i+1);
                changed = true;
            end
        end
    end

    if ~changed
        break;
    end
end

xy_ord = [Px(ord), Pz(ord)];
ordIdx = origIdx(ord);

% enforce CCW if requested
if opts.ccw
    signedA = 0.5*sum( xy_ord(:,1).*circshift(xy_ord(:,2),-1) - circshift(xy_ord(:,1),-1).*xy_ord(:,2) );
    if signedA < 0
        xy_ord = flipud(xy_ord);
        ordIdx = flipud(ordIdx);
    end
end

% rotate to LE if requested
if startMode=="le" || startMode=="minx"
    [~,kLE] = min(xy_ord(:,1));
    xy_ord = circshift(xy_ord, -(kLE-1));
    ordIdx = circshift(ordIdx, -(kLE-1));
end

info = struct();
info.N_unique   = N;
info.sweeps2opt = sweep;
info.crossPass  = crossPass;
info.startIndex = s;

if opts.debug
    figure; hold on; axis equal; grid on;
    plot(xy_ord(:,1),xy_ord(:,2),'-k');
    scatter(xy_ord(1,1),xy_ord(1,2),60,'r','filled');
    title(sprintf('Robust ordering (N=%d, 2opt sweeps=%d, cross passes=%d)', N, sweep, crossPass));
end
end

% ---------- geometry helpers ----------
function tf = segIntersect(Ax,Az,Bx,Bz,Cx,Cz,Dx,Dz)
% Proper intersection test (excludes collinear overlap).
o1 = orient(Ax,Az,Bx,Bz,Cx,Cz);
o2 = orient(Ax,Az,Bx,Bz,Dx,Dz);
o3 = orient(Cx,Cz,Dx,Dz,Ax,Az);
o4 = orient(Cx,Cz,Dx,Dz,Bx,Bz);
tf = (o1*o2 < 0) && (o3*o4 < 0);
end

function o = orient(Ax,Az,Bx,Bz,Cx,Cz)
o = (Bx-Ax)*(Cz-Az) - (Bz-Az)*(Cx-Ax);
end