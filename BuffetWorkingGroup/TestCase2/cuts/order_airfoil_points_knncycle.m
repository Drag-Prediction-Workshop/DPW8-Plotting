function [xy_ord, ordIdx, info] = order_airfoil_points_knncycle(x,z,varargin)
%ORDER_AIRFOIL_POINTS Robust ordering of 2D boundary points (includes ALL points).
%
% Best for ~1e3–2e3 points. Does NOT require alphaShape. Uses:
%   (1) greedy nearest-neighbor tour
%   (2) 2-opt refinement to remove crossings / shorten
%
% Usage:
%   [xy,idx,info] = order_airfoil_points(x,z,'start','LE','ccw',true,'maxSweeps',50,'debug',true);

p = inputParser;
p.addParameter('start','LE', @(s) ischar(s)||isstring(s));
p.addParameter('ccw', true, @(v) islogical(v)&&isscalar(v));
p.addParameter('maxSweeps', 50, @(v) isscalar(v)&&v>=1);
p.addParameter('debug', false, @(v) islogical(v)&&isscalar(v));
p.parse(varargin{:});
opts = p.Results;

x = x(:); z = z(:);
good = isfinite(x) & isfinite(z);
x = x(good); z = z(good);
P0 = [x,z];

% de-duplicate (keep stable)
tol = 1e-12;
[~, ia] = unique(round(P0/tol)*tol,'rows','stable');
P = P0(ia,:);
origIdx = find(good);
origIdx = origIdx(ia);

N = size(P,1);
if N < 10, error('Not enough unique points to order.'); end

% start index
startMode = lower(string(opts.start));
if startMode=="le" || startMode=="minx"
    [~,s] = min(P(:,1));
else
    s = 1;
end

% ---------- (1) initial tour: nearest neighbor ----------
ord = zeros(N,1);
ord(1) = s;
used = false(N,1); used(s) = true;

for k = 2:N
    cur = ord(k-1);
    uu = find(~used);
    d2 = sum((P(uu,:) - P(cur,:)).^2, 2);
    [~,m] = min(d2);
    ord(k) = uu(m);
    used(ord(k)) = true;
end

% precompute for speed
Px = P(:,1); Pz = P(:,2);

% ---------- (2) 2-opt refinement ----------
sweep = 0;
improved = true;

while improved && sweep < opts.maxSweeps
    improved = false;
    sweep = sweep + 1;

    % iterate over edge pairs (i,i+1) and (j,j+1)
    for i = 1:N-3
        a = ord(i);     b = ord(i+1);
        Ax = Px(a); Az = Pz(a);
        Bx = Px(b); Bz = Pz(b);

        for j = i+2:N-1
            c = ord(j);     d = ord(j+1);
            Cx = Px(c); Cz = Pz(c);
            Dx = Px(d); Dz = Pz(d);

            % skip if sharing endpoints
            if a==c || a==d || b==c || b==d, continue; end

            % If segments intersect OR swap reduces length, do swap
            if segIntersect(Ax,Az,Bx,Bz,Cx,Cz,Dx,Dz)
                ord(i+1:j) = ord(j:-1:i+1);
                improved = true;
            else
                oldL = hypot(Ax-Bx,Az-Bz) + hypot(Cx-Dx,Cz-Dz);
                newL = hypot(Ax-Cx,Az-Cz) + hypot(Bx-Dx,Bz-Dz);
                if newL < oldL
                    ord(i+1:j) = ord(j:-1:i+1);
                    improved = true;
                end
            end
        end
    end
end

xy_ord = [Px(ord), Pz(ord)];
ordIdx = origIdx(ord);

% enforce CCW
if opts.ccw
    signedA = 0.5*sum( xy_ord(:,1).*circshift(xy_ord(:,2),-1) - circshift(xy_ord(:,1),-1).*xy_ord(:,2) );
    if signedA < 0
        xy_ord = flipud(xy_ord);
        ordIdx = flipud(ordIdx);
    end
end

% rotate to LE
if startMode=="le" || startMode=="minx"
    [~,kLE] = min(xy_ord(:,1));
    xy_ord = circshift(xy_ord, -(kLE-1));
    ordIdx = circshift(ordIdx, -(kLE-1));
end

info = struct('N_unique',N,'sweeps',sweep);

if opts.debug
    figure; hold on; axis equal; grid on;
    plot(xy_ord(:,1),xy_ord(:,2),'-k');
    scatter(xy_ord(1,1),xy_ord(1,2),60,'r','filled');
    title(sprintf('Ordered tour (TSP+2opt): N=%d, sweeps=%d', N, sweep));
end
end

function tf = segIntersect(Ax,Az,Bx,Bz,Cx,Cz,Dx,Dz)
% Robust segment intersection test (handles general position well).
o1 = orient(Ax,Az,Bx,Bz,Cx,Cz);
o2 = orient(Ax,Az,Bx,Bz,Dx,Dz);
o3 = orient(Cx,Cz,Dx,Dz,Ax,Az);
o4 = orient(Cx,Cz,Dx,Dz,Bx,Bz);

tf = (o1*o2 < 0) && (o3*o4 < 0);
end

function o = orient(Ax,Az,Bx,Bz,Cx,Cz)
% orientation (cross product z-component)
o = (Bx-Ax)*(Cz-Az) - (Bz-Az)*(Cx-Ax);
end